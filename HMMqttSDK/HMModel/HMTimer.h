//
//  HMTimer.h
//  HmMqttSdk
//
//  Created by 研发ios工程师 on 2017/12/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 注意:这个定时器主要负责 撤防布防  不用设置开始和结束时间
 */
@interface HMTimer : NSObject
@property (nonatomic, assign)NSInteger wf; //使能位BIT7；WFu,bit0-bit6为周一至周日bit7 定时器使能定时器单次功能与周期功能是二选一，bit0-bit6都是0为单次，否则为周期，周期月、日无效
@property (nonatomic, assign)NSInteger  day;
@property (nonatomic, assign)NSInteger  month;
@property (nonatomic, assign)NSInteger  hour;
@property (nonatomic, assign)NSInteger  minutes;

@end
