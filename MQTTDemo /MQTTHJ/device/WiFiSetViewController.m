//
//  WiFiSetViewController.m
//  MQTTHJ
//
//  Created by 研发ios工程师 on 2017/12/13.
//  Copyright © 2017年 研发ios工程师. All rights reserved.
//

#import "WiFiSetViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>
 
@interface WiFiSetViewController ()

@property (weak, nonatomic) IBOutlet UITextField *WiFiName;

@property (weak, nonatomic) IBOutlet UITextField *WiFiPassWord;

@property (nonatomic, strong) NSString * deviceID;

@end

@implementation WiFiSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        self.WiFiName.text = [self getWifiName];
    if(self.WiFiName.text){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.WiFiPassWord.text = [defaults objectForKey:@"WiFi_PassWord"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 设备入网
- (IBAction)setHost:(id)sender {
    
    //HmSmartLink * hmSmarkLink = [[HmSmartLink alloc]init];
    NSString * passWord = self.WiFiPassWord.text;
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:passWord  forKey:@"WiFi_PassWord"];
    [defaults synchronize];
    [[HmSmartLink sharedSmartLink]  startWithPassword:passWord progress:^(CGFloat progress) {
    } error:^(NSError *error) {
        NSLog(@"配置WiFi失败");
    } singleDeviceSuccess:^(HmLinkModel *device) {
        NSLog(@"%@",device);
         NSLog(@"配置WiFi成功");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view makeToast:@"配置WiFi成功"];
        });
//      入网失败原因：1 设备和客户端不在一个wifi下  2 wifi不能上网 3 设备问题 4 检查代码
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * macName = device.mac;
        [defaults setObject:macName forKey:@"ZGW_MAC_Name"];
        [defaults synchronize];
    } multiDeviceSuccess:^(NSMutableArray *devices) {
    }];
}



#pragma mark 注册设备到服务器
- (IBAction)registerDevice:(id)sender {
    NSString * macName = [[NSUserDefaults standardUserDefaults] objectForKey:@"ZGW_MAC_Name"];
    [HMHttpManage onRegisterDeviceWithPid:10000 mac:macName  mcuVersion:nil wifiVersion:nil name:@"HJtest" success:^(id data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        NSString * deviceID = [NSString stringWithFormat:@"%@",[dic valueForKey:@"id"]];
        self.deviceID = deviceID;
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:deviceID forKey:@"hhm_deviceID"];
        [defaults synchronize];
        NSLog(@"%@",_deviceID);
        NSLog(@"注册设备到服务器成功了");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view makeToast:@"注册设备成功"];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
}

#pragma mark 用户绑定设备
- (IBAction)bindingDevice:(id)sender {
    self.deviceID = [[NSUserDefaults standardUserDefaults] objectForKey:@"hhm_deviceID"];
    [HMHttpManage onSubscribeDeviceWithDeviceId:self.deviceID success:^(id data) {
    NSLog(@"%@",data);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        NSLog(@"用户绑定设备成功了");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view makeToast:@"绑定设备成功"];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
}

#pragma mark 用户解除绑定设备

- (IBAction)unBingDingDevice:(id)sender {
    self.deviceID = [[NSUserDefaults standardUserDefaults] objectForKey:@"hhm_deviceID"];
    [HMHttpManage onUnSubscribeDeviceWithDeviceId:self.deviceID success:^(id data) {
        NSLog(@"%@",data);
        NSLog(@"用户解除绑定设备成功了");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view makeToast:@"解除绑定成功"];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
}

#pragma mark 获取当前 wifi_IP
- (NSString *)getWifiName
{
    NSString *wifiName = nil;
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if (!wifiInterfaces) {return nil;}
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            NSLog(@"network info -> %@", networkInfo);
            wifiName = [networkInfo objectForKey:(__bridge NSString*)kCNNetworkInfoKeySSID];
            CFRelease(dictRef);
        }
    }
    CFRelease(wifiInterfaces);
    return wifiName;
}
@end
