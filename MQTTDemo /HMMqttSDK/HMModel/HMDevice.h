//
//  HMDevice.h
//  HmMqttSdk
//
//  Created by 研发ios工程师 on 2017/12/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMDevice : NSObject

//注：该类可用于任意设备，也可自己创建类似的类
/**
 设备mac地址
 */
@property (nonatomic, copy)   NSString * deviceMac;
/**
 设备名称
 */
@property (nonatomic, copy)   NSString * deviceName;
/**
 硬件版本号
 */
@property (nonatomic, copy)   NSString * hardwareVer;
/**
 软件版本号
 */
@property (nonatomic, copy)   NSString * softwareVer;
/**
 zigbee协调器
 */
@property (nonatomic, copy)   NSString * zSoftwareVer;
/**
 时区 时区 若设置东时区”+”;若设置西时区”-” 例如，设置东时区 :"+3.00"
 */
@property (nonatomic, copy)   NSString * timeZone;
/**
 公钥
 */
@property (nonatomic, copy)   NSString * acckey;
/**
 私钥
 */
@property (nonatomic, copy)   NSString * aeskey;

/**
 设备在线状态 0 不在线 1为在线
 */
@property (nonatomic, assign) NSInteger  deviceStates;
/**
 设备id
 */
@property (nonatomic, assign) NSInteger  deviceID;
/**
 产品id
 */
@property (nonatomic, assign) NSInteger  pid;
/**
 厂商ID （注：一般跟企业id一样的）
 */
@property (nonatomic, assign) NSInteger  factoryID ;
/**
 设备类型
 */
@property (nonatomic, assign) NSInteger  type;
/**
 设备是否初始化
 */
@property (nonatomic, assign) Boolean    isInit;
/**
 是否是子设备
 */
@property (nonatomic, assign) Boolean    isSub;
/**
 协议版本号，目前为2
 */
@property (nonatomic, assign) Byte       version ;

@end
