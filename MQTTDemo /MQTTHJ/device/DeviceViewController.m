 //
//  DeviceViewController.m
//  MQTTHJ
//
//  Created by 研发ios工程师 on 2017/12/13.
//  Copyright © 2017年 研发ios工程师. All rights reserved.
//

#import "DeviceViewController.h"
#import "LoginViewController.h"


@interface DeviceViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *loginout;

@property (weak, nonatomic) IBOutlet UITextField *macName;



@end


@implementation DeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设备相关测试";
    NSData * deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"xg121_deviceToken"];
    NSString * result = [NSString stringWithFormat:@"%@", [self hexStringFromData:deviceToken]];
    [HMHttpManage onRegisterXGWithAppId:4 deviceToken:result success:^(id data) {
        NSLog(@"注册信鸽推送成功");
    } failure:^(NSError *error) {
        NSLog(@"注册信鸽推送失败：%@",error.description);
    }];


}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:false];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.macName.text = [defaults objectForKey:@"ZGW_MAC_Name"];
}

- (IBAction)loginout:(id)sender {
    UIViewController * presentingViewController = self.presentingViewController;
    while (presentingViewController.presentingViewController) {
        presentingViewController = presentingViewController.presentingViewController;
    }
    [presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)setGWF:(id)sender {
    [self performSegueWithIdentifier:@"WiFiSet" sender:nil];
}

- (IBAction)setGWFWithMqtt:(id)sender {
    
    NSString * macName = self.macName.text;
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:macName  forKey:@"ZGW_MAC_Name"];
    [defaults synchronize];
    if (macName != nil && macName.length > 0) {
        [self performSegueWithIdentifier:@"Meshwork" sender:macName];
    }
}

- (IBAction)setZigBeeMqtt:(id)sender {
    [self performSegueWithIdentifier:@"Device_List" sender:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.macName resignFirstResponder];
}

//data   ： <845dd768 14c6>    怎么转成这样的    字符串：845DD76814C6
- (NSString *)hexStringFromData:(NSData *)data{
    return [[[[NSString stringWithFormat:@"%@",data]
              stringByReplacingOccurrencesOfString: @"<" withString: @""]
             stringByReplacingOccurrencesOfString: @">" withString: @""]
            stringByReplacingOccurrencesOfString: @" " withString: @""];
}

@end