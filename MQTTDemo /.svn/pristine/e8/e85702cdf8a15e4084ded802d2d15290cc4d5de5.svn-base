//
//  ViewController.m
//  MQTTHJ
//
//  Created by 研发ios工程师 on 2017/11/27.
//  Copyright © 2017年 研发ios工程师. All rights reserved.
//


#import "ViewController.h"
#import "HmUtils.h"
#import "HMMQTTSdkEncoder.h"
#import "HmMqttSdk.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *topicText;

@property (weak, nonatomic) IBOutlet UITextField *messageTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     MQTT_CONNECTION.delegate = self;
}
- (IBAction)subscribeAction:(id)sender {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [MQTT_CONNECTION subscribeToTopic: @"1000/10000/845DD76814C6/C" atLevel:MQTTQosLevelAtLeastOnce subscribeHandler:^(NSError *error, NSArray<NSNumber *> *gQoss) {
                
                if (error) {
                    NSLog(@"Subscription failed 订阅失败：%@",error.localizedDescription);
                    dispatch_async(dispatch_get_main_queue(),^{
                    });
                } else {
                    NSLog(@"Subscription sucessfull! 订阅成功 Granted Qos：%@",gQoss);
                    dispatch_async(dispatch_get_main_queue(),^{
                    });
                }
            }];
        });
    });
}


- (IBAction)messageSendAction:(id)sender {
    
    
    HMMQTTSdkEncoder *encoder = [[HMMQTTSdkEncoder alloc] init];
    HMDevice * device = [[HMDevice alloc]init];
    device.acckey =nil;
    device.aeskey = nil;
    NSData *data = [encoder  getData:0x3000 andDevice:device];
    NSLog(@"data : %@",data);
    NSData *data1 = [encoder setTimerZone:@"+3.00" andDevice:device];
    NSLog(@"data1 : %@",data1);
    //0x33,0x01,0x3b,0x00,0x34,0x00,0x0f,0x30,0x00,0xff,0xff,0x30,0x21,0x00,0x01,0x30,0x04,0x00,0x03,0xff,0xff,0x31
   
    //NSData * messageData = [self convertHexStrToData:self.messageTextView.text];
    
    HMGatewayInfo * gatewayInfo = [[HMGatewayInfo alloc]init];
    gatewayInfo.Alarmlevel = 0;
    gatewayInfo.Soundlevel = 76;
    gatewayInfo.Betimer = 30;
    gatewayInfo.Gwlanguage = 0x31;
    gatewayInfo.Gwlightlevel = 44;
    gatewayInfo.Gwlightonoff = 0;
    gatewayInfo.Lgtimer = 30;
    gatewayInfo.Armtype = 1;
    NSData * data2 = [encoder getGatewayInfo:gatewayInfo andDevice:device];
    NSLog(@"data2 : %@",data2);
    
    [MQTT_CONNECTION publishData:data1 onTopic:@"1000/10000/845DD76814C6/E"];
  }

- (void)newMessage:(MQTTSession *)session
              data:(NSData *)data
           onTopic:(NSString *)topic
               qos:(MQTTQosLevel)qos
          retained:(BOOL)retained
               mid:(unsigned int)mid {
    
    NSMutableDictionary * deviceProp = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"topic:%@,  data:%@",topic,deviceProp);
    NSLog(@"获取MQTT数据：%@",data);
//    设备信息：<33023700 34002330 00fff130 22000130 00001700 01845dd7 6814c600 01032003 e8002710 00010002 0001>
//    时区      33023700 34001030 00fff130 22000130 02000400 01012c
    
//    //获取系统当前时间
//    NSDate *currentDate = [NSDate date];
//    //用于格式化NSDate对象
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    //设置格式：zzz表示时区
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    //NSDate转NSString
//    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
//
//    NSString * string = [[NSString alloc] initWithData:data encoding:NSUTF16StringEncoding];
//
//    NSDictionary * dictionary = @{@"topic":topic,
//                                  @"data":data,
//                                  @"dataString":string,
//                                  @"qos":@(qos),
//                                  @"retained":@(retained),
//                                  @"mid":@(mid),
//                                  @"date":currentDateString
//                                  };
//    NSLog(@" dictionary: %@",dictionary);
    
}

/**
 十六进制字符转换为NSData
 */
- (NSData *)convertHexStrToData:(NSString *)dataStr {
    if (!dataStr || [dataStr length] == 0) {
        return nil;
    }
    
    NSArray * tempArr = [dataStr componentsSeparatedByString:@" "];
    NSMutableString * str = [NSMutableString string];
    for (NSString * tempStr in tempArr) {
        [str appendString:tempStr];
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    NSLog(@"hexdata: %@", hexData);
    return hexData;
}


- (void)dealloc {
    
    MQTT_CONNECTION.delegate = nil;
    [MQTT_CONNECTION unsubscribeTopic:self.topicText.text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 HMMQTTSdkEncoder *encoder = [[HMMQTTSdkEncoder alloc] init];
 NSData *data = [encoder  getData:0x3000];
 NSString * timerZone =@"+8.00";
 NSData *data1 = [encoder setTimerZone:timerZone];
 //    3000fff2 30210001 30020004 ffff0320
 //    0x3000 0xfff2 0x3021 0x0001 0x3002 0x0004 0xffff 0x012c
 HMGatewayInfo * gatewayInfo = [[HMGatewayInfo alloc]init];
 gatewayInfo.Alarmlevel = 0;
 gatewayInfo.Soundlevel = 76;
 gatewayInfo.Betimer = 30;
 gatewayInfo.Gwlanguage = 0x31;
 gatewayInfo.Gwlightlevel = 44;
 gatewayInfo.Gwlightonoff = 0;
 gatewayInfo.Lgtimer = 30;
 gatewayInfo.Armtype = 1;
 NSData * data2 = [encoder getGatewayInfo:gatewayInfo];
 NSData * data3 = [encoder addSubDevice:YES];
 NSData * data4 = [encoder upDatairmware:0x03 enable:YES type:0x31];
 HMRgbLight * rgb = [[HMRgbLight alloc]init];
 rgb.onOff = 0x01;
 rgb.brightness = 0x64;
 rgb.colorR = 0xffff;
 rgb.colorG = 0xffff;
 rgb.colorB = 0xffff;
 rgb.sDay = 0x01;
 rgb.sMonth = 0x07;
 rgb.sHour = 0x0c;
 rgb.sMinutes = 0x00;
 rgb.eDay = 0x01;
 rgb.eMonth = 0x07;
 rgb.eHour = 0x0c;
 rgb.eMinutes = 0x00;
 rgb.wf = 0xff;
 NSData * data5 = [encoder setDevicePropertyWithIndex:1 deviceIndex:30 deviceInfo:rgb];
 HMRelay *relay = [[HMRelay alloc]init];
 relay.onoff = 1;
 NSData * data6 = [encoder setDevicePropertyWithIndex:6 deviceIndex:20 deviceInfo:relay];
 HMPlug * plug = [[HMPlug alloc] init];
 plug.powerSwitch = 1;
 plug.powerwf = 2;
 plug.powersMonth = 1;
 plug.powersDay = 23;
 plug.powersHour = 14;
 plug.powersMinutes = 14;
 plug.powereMonth = 1;
 plug.powereDay = 24;
 plug.powereHour = 14;
 plug.powereMinutes = 14;
 
 plug.usbSwitch = 1;
 plug.usbwf = 2;
 plug.usbsMonth = 1;
 plug.usbsDay = 23;
 plug.usbsHour = 14;
 plug.usbsMinutes = 14;
 plug.usbeMonth = 1;
 plug.usbeDay = 24;
 plug.usbeHour = 14;
 plug.usbeMinutes = 14;
 
 NSData * data7 = [encoder setDevicePropertyWithIndex:67 deviceIndex:23 deviceInfo:plug];
 
 HMSwitch * eswitch = [[HMSwitch alloc]init];
 eswitch.onoff1 = 0x01;
 eswitch.sMonth1 = 0x07;
 eswitch.sDay1 = 0x01;
 eswitch.sHour1 = 0x0c;
 eswitch.sMinutes1 = 0x00;
 eswitch.eMonth1 = 0x07;
 eswitch.eDay1 = 0x02;
 eswitch.eHour1 = 0x0c;
 eswitch.eMinutes1 = 0x00;
 eswitch.wf1 = 0xff;
 
 eswitch.onoff2 = 0x01;
 eswitch.sMonth2 = 0x07;
 eswitch.sDay2 = 0x01;
 eswitch.sHour2 = 0x0c;
 eswitch.sMinutes2 = 0x00;
 eswitch.eMonth2 = 0x07;
 eswitch.eDay2 = 0x02;
 eswitch.eHour2 = 0x0c;
 eswitch.eMinutes2 = 0x00;
 eswitch.wf2 = 0xff;
 
 NSData *data8 = [encoder setDevicePropertyWithIndex:2 deviceIndex:22 deviceInfo:eswitch];
 NSData *data9 = [encoder setDevicePropertyWithIndex:3 deviceIndex:23 deviceInfo:eswitch];
 HMSoundAndLightAlarm * alarm = [[HMSoundAndLightAlarm alloc]init];
 alarm.onoff = 1;
 alarm.alarmTimer = 0x3c;
 NSData * data10 = [encoder setDevicePropertyWithIndex:23 deviceIndex:24 deviceInfo:alarm];
 
 HMFourLight * fourl = [[HMFourLight alloc]init];
 fourl.onoff1= 1; fourl.onoff2= 1; fourl.onoff3= 1; fourl.onoff4= 0;
 fourl.brightness1 = 100;fourl.brightness2 = 90;fourl.brightness3 = 20;fourl.brightness4 = 0;
 fourl.cwl1 = 2;fourl.cwl2 = 3;fourl.cwl3 = 4;fourl.cwl4 = 5;
 NSData * data11 = [encoder setDevicePropertyWithIndex:10 deviceIndex:25 deviceInfo:fourl];
 HMThp * thp = [[HMThp alloc]init];
 thp.humUp = 0x076c;thp.humLow = 0x8064;
 thp.temUp = 0x0064;thp.temLow = 0x0384;
 thp.humEnbale = YES;
 thp.tempEnbale = YES;
 NSData * data12 = [encoder setDevicePropertyWithIndex:21 deviceIndex:26 deviceInfo:thp];
 NSLog(@"data:%@ data1:%@ data2:%@ data3:%@ data4:%@ data5:%@ data6:%@  data7:%@ data8: %@ data9: %@ data10:%@ data11:%@ data12:%@ ",data,data1,data2,data3,data4,data5 ,data6,data7,data8,data9,data10,data11,data12);
 */
@end
