//
//  HMSubDevice.hmodelArray
//  HmMqttSdk
//
//  Created by 研发ios工程师 on 2017/12/25.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMDevice.h"

@interface HMSubDevice : NSObject<NSCoding>


@property (nonatomic, strong) HMDevice * hmDevice;

/**
 设备MAC地址
 */
@property (nonatomic, strong) NSString * deviceMac;

/**
 设备的名字
 */
@property (nonatomic, strong) NSString * deviceName;

/**
 设备类型
 */
@property (nonatomic, assign) NSInteger  deviceType;

/**
 设备的index
 */
@property (nonatomic, assign) NSInteger  index;

/**
 设备是否在线
 */
@property (nonatomic, assign) Boolean    isOnline;

/**
 * 数据模型归档
 *
 * @param deviceMac  子设备的mac地址
 * @param deviceType  子设备的设备类型
 * @param index  子设备的index
 * @param deviceName  子设备的名字
 */
- (instancetype)initWithDeviceMac:(NSString *) deviceMac
                       deviceType:(NSInteger ) deviceType
                            index:(NSInteger ) index
                       deviceName:(NSString *) deviceName;

@end