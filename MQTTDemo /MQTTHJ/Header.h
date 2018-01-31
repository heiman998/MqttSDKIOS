//
//  Header.h
//  MQTTHJ
//
//  Created by 研发ios工程师 on 2017/11/27.
//  Copyright © 2017年 研发ios工程师. All rights reserved.
//

#ifndef Header_h
#define Header_h
#endif /* Header_h */
// 本地 #define MQTT_IP @"192.158.1.170"
//#define MQTT_IP @"119.29.224.84"
// 云端 mqtt地址119.29.224.84:1883
#define MQTT_IP @"119.29.224.84"
#define MQTT_PORT 1883 // 不是字符串
#define MQTT_ACCKEY @"bd17df6d548211e7"
#define MQTT_PID 1000
#define MQTT_FACTORYID 10000
#define HTTP_USER @"1587@qq.com"
#define HTTP_PASSWORD @"12345"
#define HTTPAppLogin @"http://47.88.192.21:80/SmartHome/v1/login"
#define HTTPUserSubsList @"http://47.88.192.21:80/SmartHome/v1/login"

//#define MQTT_CONNECTION ([(AppDelegate *)[[UIApplication sharedApplication] delegate] session])
#define HJAppDelegate    ((AppDelegate *)[UIApplication sharedApplication].delegate)


#define ENCRYPT_EABLE YES
