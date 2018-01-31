//
//  HMSSBaseModel.h
//  HmMqttSdk
//
//  Created by 研发ios工程师 on 2018/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
  设备主动上报的消息模型 一般默认为 0 或者nil  
 */

@interface HMSSBaseModel : NSObject

@property (nonatomic, assign) Boolean isOnline; //设备是否在线
@property (nonatomic, assign) Boolean isBpAlarm;//低压报警
@property (nonatomic, assign) NSInteger onoff;//全设备开关状态 开关状态0(NO)关闭 ,1(YES) 打开（ 某些感应器开关状态OF,0关闭,1打开, 2防拆关闭,3防拆打开；）
@property (nonatomic, assign) NSInteger  BP;//电池电量；
@property (nonatomic, assign) NSInteger TM;//开关状态更新时间

#pragma  mark --------------温湿度------------
@property (nonatomic, strong) NSString * TP;//温度值
@property (nonatomic, strong) NSString * HY;//湿度值
@property (nonatomic, assign) NSInteger TU; //温度阈值上限;
@property (nonatomic, assign) NSInteger TL; //温度阈值上限;
@property (nonatomic, assign) NSInteger HU; //湿度阈值上限;
@property (nonatomic, assign) NSInteger HL; //湿度阈值上限;
@property (nonatomic, assign) Boolean humEnbale; //湿度使能 0为不使能 1为使能 其他值无效
@property (nonatomic, assign) Boolean tempEnbale; //温度使能 0为不使能 1为使能 其他值无效

#pragma  mark --------------RGB灯------------
@property (nonatomic, assign) NSInteger LE;
@property (nonatomic, assign) NSInteger CR;
@property (nonatomic, assign) NSInteger CG;
@property (nonatomic, assign) NSInteger CB;
//共用的开始结束时间
@property (nonatomic, assign) NSInteger sDay;      //开始日
@property (nonatomic, assign) NSInteger sMonth;    //开始月
@property (nonatomic, assign) NSInteger sHour;     //开始时
@property (nonatomic, assign) NSInteger sMinutes;  //开始分
@property (nonatomic, assign) NSInteger eDay;      //结束日
@property (nonatomic, assign) NSInteger eMonth;    //结束月
@property (nonatomic, assign) NSInteger eHour;     //结束时
@property (nonatomic, assign) NSInteger eMinutes;  //结束分
@property (nonatomic, assign) NSInteger WF; //bit0-bit6为周一至周日bit7 定时器使能 定时器单次功能与周期功能是二选一，bit0-bit6都是0为单次，否则为周期，周期月、日无效
#pragma  mark -------------- 普通插座、计量插座------------
@property (nonatomic, assign) NSInteger RO;//AC开关状态0关闭 1 打开
@property (nonatomic, assign) NSInteger UO;//USB开关状态0关闭 1 打开
@property (nonatomic, assign) NSInteger TMr;//AC开关状态更新时间
@property (nonatomic, assign) NSInteger Tmu;//USB开关状态更新时间

@property (nonatomic, assign) NSInteger WFr;//bit0-bit6为周一至周日bit7 定时器使能定时器单次功能与周期功能是二选一，bit0-bit6都是0为单次，否则为周期，周期月、日无效
@property (nonatomic, assign) NSInteger WFu;//,bit0-bit6为周一至周日bit7 定时器使能定时器单次功能与周期功能是二选一，bit0-bit6都是0为单次，否则为周期，周期月、日无效
@property (nonatomic, assign) NSInteger usbSwitch;//USB 开关
@property (nonatomic, assign) NSInteger usbwf;//USB使能位BIT7；WFu,bit0-bit6为周一至周日bit7 定时器使能定时器单次功能与周期功能是二选一，bit0-bit6都是0为单次，否则为周期，周期月、日无效
@property (nonatomic, assign) NSInteger usbsDay; //开始日
@property (nonatomic, assign) NSInteger usbsMonth; //开始月
@property (nonatomic, assign) NSInteger usbsHour; //开始时
@property (nonatomic, assign) NSInteger usbsMinutes;//开始秒
@property (nonatomic, assign) NSInteger usbeDay; //结束日
@property (nonatomic, assign) NSInteger usbeMonth; //结束月
@property (nonatomic, assign) NSInteger usbeHour; //结束时
@property (nonatomic, assign) NSInteger usbeMinutes;//结束秒
@property (nonatomic, strong) NSString * PW;//功率,单位0.1w  X10
@property (nonatomic, strong) NSString * ET;

#pragma  mark  -------------- 一路二路三路开关------------
@property (nonatomic, assign) NSInteger  TM1;//开关1时间
//@property (nonatomic, assign) NSInteger  TM2;//开关2时间
//@property (nonatomic, assign) NSInteger  TM3;//开关3时间
@property (nonatomic, assign) NSInteger WF1; //bit0-bit6为周一至周日bit7 定时器使能 定时器单次功能与周期功能是二选一，bit0-bit6都是0为单次，否则为周期，周期月、日无效
@property (nonatomic, assign) NSInteger WF2;
@property (nonatomic, assign) NSInteger WF3;

#pragma  mark  -------------- 声光警号------------
@property (nonatomic, assign) NSInteger  DT;//报警时间

#pragma  mark  -------------- 四驱灯控------------
@property (nonatomic, assign) NSInteger onoff1;
@property (nonatomic, assign) NSInteger onoff2;
@property (nonatomic, assign) NSInteger onoff3;
@property (nonatomic, assign) NSInteger onoff4;
@property (nonatomic, assign) NSInteger LEL1;//亮度值
@property (nonatomic, assign) NSInteger LEL2;
@property (nonatomic, assign) NSInteger LEL3;
@property (nonatomic, assign) NSInteger LEL4;
//CWL,冷色调，为减少字节数取值范围（2-9） 对应到设备算法X*500+2000（3000-6500，共7个档位）
@property (nonatomic, assign) NSInteger CW1;
@property (nonatomic, assign) NSInteger CW2;
@property (nonatomic, assign) NSInteger CW3;
@property (nonatomic, assign) NSInteger CW4;
@property (nonatomic, assign) NSInteger MA;


@property (nonatomic, assign) NSInteger OT;//远程开门使能开关用户开锁类型 0 - 密码开锁2- 指纹开锁 3 - 门禁卡开锁4 - APP开锁  5 为初始状态。
@property (nonatomic, assign) NSInteger ID;//用户ID。 0 为初始状态。
@property (nonatomic, assign) NSInteger IN;//用户对应昵称，默认为空
@property (nonatomic, assign) NSInteger RE;//用户远程开始使能为。0为不允许 1位允许

#pragma  mark  -------------- 空气质量(感应类 含有相关属性)-----------
@property (nonatomic, assign) NSInteger TV;//TVOC值，0x0000为0；(TV值转化为十进制为实际TV值)
@property (nonatomic, assign) NSInteger P2;//PM25值，0x0dac为35；（P2值转化为十进制后除以100为实际P2值）
@property (nonatomic, assign) NSInteger CC;//CHCO值，0x000c为0.12；（CC值转化为十进制后除以100为实际CC值）
@property (nonatomic, assign) NSInteger AQ;//AQI值，0x0023为35；(AQ值转化为十进制为实际AQ值)
@property (nonatomic, assign) NSInteger P1;//PM10值，0x000c为0.12；（P1值转化为十进制后除以100为实际P1值）
@property (nonatomic, assign) NSInteger AS;//撤布防状态，0 撤防，1，布防,该字段不能单独设置，只用于场景设置


@end
