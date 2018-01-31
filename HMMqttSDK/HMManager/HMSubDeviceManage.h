//
//  HMSubDeviceManage.h
//  HmMqttSdk
//
//  Created by 研发ios工程师 on 2017/12/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMSubDevice.h"

@interface HMSubDeviceManage : NSObject

/**
 * 保存数据模型
 * @param modelArray   HMSubDevice：子设备list信息 保存在模型数组里
 */
+ (void)saveSubDeviceInUserDefaultsWithArray:(NSArray <HMSubDevice *> *)modelArray;

/**
 获取模型数据的信息
 */
+ (HMSubDevice *)getDeviceWithIndex:(NSInteger)index key:(NSString *)key;

@end
