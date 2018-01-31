//
//  SubDeviceViewController.m
//  MQTTHJ
//
//  Created by 研发ios工程师 on 2018/1/4.
//  Copyright © 2018年 研发ios工程师. All rights reserved.
//

#import "SubDeviceViewController.h"

@interface SubDeviceViewController ()<HMMQTTDelegate>

@property (nonatomic, strong) NSDictionary * dict;
@property (nonatomic, strong) NSString *  productId;
@property (nonatomic, strong) NSString *  subIndex;
@property (nonatomic, strong) HMDevice *  hmDevice;
@property (nonatomic, strong) NSString * macName;

@property (nonatomic, assign)BOOL isOnoff;

@end

@implementation SubDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hmDevice = [[HMDevice alloc]init];
    [HMMqttManager manager].delegate = self;
    self.hmDevice.pid = 10000;
    self.hmDevice.factoryID = 1000;
    self.hmDevice.acckey = MQTT_ACCKEY;
    self.hmDevice.aeskey = [[NSUserDefaults standardUserDefaults] valueForKey:@"hmdevice_aeskey"];
    self.isOnoff = NO;
}

- (void)configureWithData:(id)data {
    self.dict = data[@"dict"];
    self.productId = [self.dict valueForKey:@"productId"];
    self.subIndex  = [self.dict valueForKey:@"subIndex"];
    self.macName = [data valueForKey:@"wifiMacName"];
    self.hmDevice.deviceMac = self.macName;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[HMMqttManager manager] subscribeLastWordsWithHmDevice:self.hmDevice andHmMqttError:^(NSError *error) {
                if (error) {
                    NSLog(@"订阅遗言失败");
                }else{
                     NSLog(@"订阅遗言成功");
                }
            }] ;
        });
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[HMMqttManager manager] subscribeWithHmDevice:self.hmDevice andHmMqttError:^(NSError *error) {
                if (error) {
                    NSLog(@"订阅主题失败");
                }else{
                    NSLog(@"订阅主题成功");
                }
            }] ;
        });
    });
}

#pragma mark ---------------HMMqttDelegate------------------
- (void)mqttNewMessageData:(BOOL)isOnline{
    if (isOnline == YES) {
        self.navigationItem.title = @"网关在线";
    }else{
        self.navigationItem.title = @"网关离线";
    }
}

- (IBAction)senMqtt:(id)sender {
    [self setSubDeviceWithProductId:self.productId andSubIndex:self.subIndex];
}


/**
 测试设备接口

 @param productId  设备类型 枚举集中查找
 @param subIndex   设备index
 */
-(void)setSubDeviceWithProductId:(NSString *)productId andSubIndex:(NSString *)subIndex{
    NSInteger deviceId = [productId  integerValue];
    NSInteger index = [subIndex integerValue];
    switch (deviceId) {
        case DEVICE_TYPE_ZIGBEE_RGB:
            NSLog(@"rgb");
            [self RGBAndIndex:index];
            break;
        case DEVICE_TYPE_ZIGBEE_ONE_ONOFF:
            [self oneOnoffAndIndex:index];
            NSLog(@"1onoff");
            break;
        case DEVICE_TYPE_ZIGBEE_TWO_ONOFF:
            NSLog(@"2onoff");
            [self twoOnoffAndIndex:index];
            break;
        case DEVICE_TYPE_ZIGBEE_THREE_ONOFF:
            NSLog(@"3onoff");
            break;
        case DEVICE_TYPE_ZIGBEE_RELAY:
            NSLog(@"RELAY");
            break;
        case DEVICE_TYPE_ZIGBEE_FOUR_WHEEL:
            NSLog(@"FOUR_WHEEL");
            break;
        case DEVICE_TYPE_ZIGBEE_SOUND_AND_LIGHT_ALARM:
            NSLog(@"SOUND_AND_LIGHT_ALARM");
            break;
        case DEVICE_TYPE_ZIGBEE_THP:
            NSLog(@"THP");
            break;
        case DEVICE_TYPE_ZIGBEE_METRTING_PLUGIN:
            NSLog(@"METRTING_PLUGIN");
            [self metringPlugAndIndex:index];
            break;
        case DEVICE_TYPE_ZIGBEE_PLUGIN:
            NSLog(@"PLUGIN");
            [self mPlugAndIndex:index];
            break;
        default:
            break;
    }
}

- (void)mPlugAndIndex:(NSInteger)index{

}

- (void)metringPlugAndIndex:(NSInteger)index{
    HMMetringPlug * mPlug = [[HMMetringPlug alloc]init];
//    mPlug.metOnoff = self.isOnoff?0:1;
    if (self.isOnoff == NO) {
        mPlug.metOnoff = 1 ;
        self.isOnoff =YES;
    }else{
        mPlug.metOnoff = 0 ;
        self.isOnoff = NO;
    }
    [[HMMqttManager manager] setDevicePropertyWithSubDeviceType:DEVICE_TYPE_ZIGBEE_METRTING_PLUGIN subIndex:index deviceInfo:mPlug hmDevice:self.hmDevice successBlock:^(id data) {
        NSLog(@"%@",data);
    } hmMqttError:^(NSError *error) {
        NSLog(@"%@",error.description);
    } errorBlock:^(NSInteger fault) {
        NSLog(@"%ld",(long)fault);
    }];
}


- (void)RGBAndIndex:(NSInteger )index{
    HMRgbLight * rgb = [[HMRgbLight alloc]init];
//    if (self.isOnoff == NO) {
//        rgb.rgbOnOff = 1 ;
//        self.isOnoff = YES;
//    }else{
//        rgb.rgbOnOff = 0 ;
//        self.isOnoff = NO;
//    }
     rgb.rgbOnOff = 1 ;
//    rgb.brightness = 30;
//    注意 : 这里的属性不能同时设置，设备只能单独的识别某一类属性（比如:亮度/颜色不能一起设置）
//    rgb.colorB = 1;
//    rgb.colorG = 255;
//    rgb.colorR = 1;
//    rgb.rgbTimer.sMonth = 1;
//    rgb.rgbTimer.sDay = 2;
//    rgb.rgbTimer.sHour = 3;
//    rgb.rgbTimer.sMinutes = 4;
//    rgb.rgbTimer.eMonth = 1;
//    rgb.rgbTimer.eDay = 2;
//    rgb.rgbTimer.eHour = 3;
//    rgb.rgbTimer.eMinutes = 5;
//    rgb.rgbTimer.wf = TimeWFFri;
    [[HMMqttManager manager] setDevicePropertyWithSubDeviceType:DEVICE_TYPE_ZIGBEE_RGB subIndex:index deviceInfo:rgb hmDevice:self.hmDevice successBlock:^(id data) {
        NSLog(@"%@",data);
    } hmMqttError:^(NSError *error) {
        NSLog(@"%@",error.description);
    } errorBlock:^(NSInteger fault) {
        NSLog(@"%ld",(long)fault);
    }];
}

//一开测试
- (void)oneOnoffAndIndex:(NSInteger )index{

    HMSwitch * switch1 = [[HMSwitch alloc]init];
    if (self.isOnoff == NO) {
        switch1.onoff1 = 1;
        self.isOnoff =YES;
    }else{
        switch1.onoff1 = 0;
        self.isOnoff = NO;
    }
    
//    switch1.switchTimer1.sMonth = 1;
//    switch1.switchTimer1.sDay = 2;
//    switch1.switchTimer1.sHour = 3;
//    switch1.switchTimer1.sMinutes = 4;
//    switch1.switchTimer1.eMonth = 1;
//    switch1.switchTimer1.eDay = 2;
//    switch1.switchTimer1.eHour = 3;
//    switch1.switchTimer1.eMinutes = 5;
//    switch1.switchTimer1.wf = TimeWFFri;
    [[HMMqttManager manager] setDevicePropertyWithSubDeviceType:DEVICE_TYPE_ZIGBEE_ONE_ONOFF subIndex:index deviceInfo:switch1 hmDevice:self.hmDevice successBlock:^(id data) {
        NSLog(@"%@",data);
        
    } hmMqttError:^(NSError *error) {
        NSLog(@"%@",error.description);
    } errorBlock:^(NSInteger fault) {
        NSLog(@"%ld",(long)fault);
    }];
}
- (void)twoOnoffAndIndex:(NSInteger )index{
    HMSwitch * switch2 = [[HMSwitch alloc]init];

    if (self.isOnoff == NO) {
//        switch2.onoff1 = 1;
        switch2.onoff2 = 1;
        self.isOnoff =YES;
    }else{
//        switch2.onoff1 = 0;
        switch2.onoff2 = 0;
        self.isOnoff = NO;
    }
    [[HMMqttManager manager] setDevicePropertyWithSubDeviceType:DEVICE_TYPE_ZIGBEE_TWO_ONOFF subIndex:index deviceInfo:switch2 hmDevice:self.hmDevice successBlock:^(id data) {
        NSLog(@"%@",data);
    } hmMqttError:^(NSError *error) {
        NSLog(@"%@",error.description);
    } errorBlock:^(NSInteger fault) {
        NSLog(@"%ld",(long)fault);
    }];
}

- (void)dealloc {
    [HMMqttManager manager].delegate = nil;
    [[HMMqttManager manager] unsubscribeWithHmDevice:self.hmDevice andHmMqttError:^(NSError *error) {
    }];
}


@end
