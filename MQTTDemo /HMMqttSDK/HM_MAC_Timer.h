//
//  HM_MAC_Timer.h
//  HmMqttSdk
//
//  Created by 研发ios工程师 on 2018/1/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HM_MAC_Timer : NSObject

//获取当前时间的时间戳
+ (NSString*)getTime;
//时间戳转时间
+ (NSString *)switchTime:(NSString *)timeStr;
//时间转时间戳
+ (NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;
//时间戳转时间 format你想要的格式 (@"YYYY-MM-dd hh:mm:ss")
+ (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;
@end
