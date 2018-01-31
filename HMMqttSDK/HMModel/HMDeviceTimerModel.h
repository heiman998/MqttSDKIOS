//
//  HMDeviceTimerModel.h
//  HmMqttSdk
//
//  Created by 研发ios工程师 on 2018/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMDeviceTimerModel : NSObject

/**
 开始月
 */
@property (nonatomic, assign) NSInteger sMonth;
/**
 开始日
 */
@property (nonatomic, assign) NSInteger sDay;
/**
 开始时
 */
@property (nonatomic, assign) NSInteger sHour;
/**
  开始分
 */
@property (nonatomic, assign) NSInteger sMinutes;
/**
 结束日
 */
@property (nonatomic, assign) NSInteger eDay;
/**
 结束月
 */
@property (nonatomic, assign) NSInteger eMonth;
/**
 结束时
 */
@property (nonatomic, assign) NSInteger eHour;
/**
 结束分
 */
@property (nonatomic, assign) NSInteger eMinutes;
/**
 使能位BIT7；WFu,bit0-bit6为周一至周日bit7 定时器使能定时器单次功能与周期功能是二选一，bit0-bit6都是0为单次，否则为周期，周期月、日无效
 */
@property (nonatomic, assign) NSInteger wf;

@end


