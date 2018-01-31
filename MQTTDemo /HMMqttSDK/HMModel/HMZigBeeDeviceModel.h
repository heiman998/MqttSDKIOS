//
//  HMZigBeeDeviceModel.h
//  HmMqttSdk
//
//  Created by 研发ios工程师 on 2018/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMDeviceTimerModel.h"


// 发送消息 设置设备回复 SE属性

@interface HMZigBeeDeviceModel : NSObject
@end

@interface HMRgbLight : NSObject
//rgb灯
/**
 RGB开关 : 开关状态0关闭 1 打开
 */
@property (nonatomic, assign) NSInteger rgbOnOff;
/**
 亮度调节 : 亮度0-100，即0x64
 */
@property (nonatomic, assign) NSInteger brightness;
/**
 颜色R :  红色值 0 - 255
 */
@property (nonatomic, assign) NSInteger colorR ;
/**
 颜色G :  绿色值
 */
@property (nonatomic, assign) NSInteger colorG;
/**
 颜色B :  蓝色值
 */
@property (nonatomic, assign) NSInteger colorB;

/**
 rgb灯的定时器
 */
@property (nonatomic, strong) HMDeviceTimerModel * rgbTimer;

@end

@interface HMPlug : NSObject
//智能插座
/**
 智能插座开关（带USB）
 */
@property (nonatomic, assign) NSInteger powerOnoff;
/**
 智能插座的定时器
 */
@property (nonatomic, strong) HMDeviceTimerModel * powerTimer;
/**
 USB 开关
 */
@property (nonatomic, assign) NSInteger usbOnoff;
/**
 USB开关的定时器
 */
@property (nonatomic, strong) HMDeviceTimerModel * usbTimer;

@end

@interface HMMetringPlug : NSObject
/**
 * 计量插座开关
 */
@property (nonatomic, assign)NSInteger metOnoff;
/**
 计量插座的定时器
 */
@property (nonatomic, strong) HMDeviceTimerModel * metTimer;

@end

@interface HMSwitch : NSObject
/**
 * 一路开关
 */
@property (nonatomic, assign)NSInteger onoff1;
/**
 一路开关定时器
 */
@property (nonatomic, strong)HMDeviceTimerModel * switchTimer1;
/**
 * 二路开关
 */
@property (nonatomic, assign)NSInteger onoff2;
/**
 二路开关定时器
 */
@property (nonatomic, strong)HMDeviceTimerModel * switchTimer2;
/**
 * 三路开关
 */
@property (nonatomic, assign)NSInteger onoff3;
/**
 三路开关定时器
 */
@property (nonatomic, strong)HMDeviceTimerModel * switchTimer3;

@end

@interface HMRelay : NSObject
/**
 继电器开关
 */
@property (nonatomic, assign)NSInteger relayOnoff;

@end

//四驱灯控
@interface HMFourLight : NSObject
/**
 * 开关状态 BIT0：一路，0为关闭，1为打开； BIT1：一路，0为关闭，1为打开； BIT2：一路，0为关闭，1为打开；BIT3：一路，0为关闭，1为打开；
 */
@property (nonatomic, assign)NSInteger onoff1;
@property (nonatomic, assign)NSInteger onoff2;
@property (nonatomic, assign)NSInteger onoff3;
@property (nonatomic, assign)NSInteger onoff4;
/**
 * 亮度值 BIT0-BIT7：一路，取值范围0-100，即0x00-0x64;BIT8-BIT15：二路，取值范围0-100，即0x00-0x64;BIT16-BIT23：三路，取值范围0-100，即0x00-0x64;BIT24-BIT31：四路，取值范围0-100，即0x00-0x64;
 */
@property (nonatomic, assign)NSInteger brightness1;
@property (nonatomic, assign)NSInteger brightness2;
@property (nonatomic, assign)NSInteger brightness3;
@property (nonatomic, assign)NSInteger brightness4;
/**
 * 冷色调，为减少字节数取值范围（0-9） 对应到设备算法X*500+2000（3000-6500，共10个档位）BIT0-BIT3：一路，取值范围为2-9;BIT4-BIT7：二路，取值范围为2-9;BIT8-BIT11：三路，取值范围为2-9;BIT12-BIT15：四路，取值范围为2-9;
 */
@property (nonatomic, assign)NSInteger cwl1;
@property (nonatomic, assign)NSInteger cwl2;
@property (nonatomic, assign)NSInteger cwl3;
@property (nonatomic, assign)NSInteger cwl4;
/**
 四驱灯控定时器
 */
@property (nonatomic, strong)HMDeviceTimerModel * flTimer1;
@property (nonatomic, strong)HMDeviceTimerModel * flTimer2;
@property (nonatomic, strong)HMDeviceTimerModel * flTimer3;
@property (nonatomic, strong)HMDeviceTimerModel * flTimer4;

@end

@interface HMSoundAndLightAlarm : NSObject
//声光警号

/**
  声光警号声音开关
 */
@property (nonatomic, assign)NSInteger slOnoff;

/**
 报警时间(时间戳)
 */
@property (nonatomic, assign)NSInteger slAlarmTime;

@end

@interface HMThp : NSObject
//温湿度设置
/**
 温度阈值上限
 */
@property (nonatomic, assign)NSInteger temUp;
/**
 温度阈值上限
 */
@property (nonatomic, assign)NSInteger temLow;
/**
 湿度阈值上限
 */
@property (nonatomic, assign)NSInteger humUp;
/**
 湿度阈值上限
 */
@property (nonatomic, assign)NSInteger humLow;
/**
 湿度使能 NO为不使能 YES为使能
 */
@property (nonatomic, assign)Boolean   humEnbale;
/**
 温度使能 NO为不使能 YES为使能
 */
@property (nonatomic, assign)Boolean   tempEnbale;
@end



#pragma mark ----------------------------------以下设备暂时无属性----------------------------------------

@interface HMAir : NSObject
//空气质量
@end

@interface HMMagneticDoor : NSObject
//门磁
@end

@interface HMWaterLeach : NSObject
//水浸
@end

@interface HMPir : NSObject
//红外转发器
@end

@interface HMSmoke : NSObject
//smoke 烟雾
@end

@interface HMGas : NSObject
//气感
@end

@interface HMCo : NSObject
//一氧化碳
@end

@interface HMSos : NSObject
//SOS报警器
@end

@interface HMSw : NSObject
//遥控器
@end

@interface HMRfirControll : NSObject
//红外遥控转发器
@end

@interface HMLampHeader : NSObject
//灯头
@end

@interface HMIlluminance : NSObject
//光照度
@end

@interface HMThermostat : NSObject
//温控器
@end

@interface HMShock : NSObject
//震动器
@end

@interface HMCurtainController : NSObject
//窗帘电机
@end



















