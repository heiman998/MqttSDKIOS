//
//  HMGatewayModel.h
//  HmMqttSdk
//
//  Created by 研发ios工程师 on 2018/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMGatewayModel : NSObject

//-------------------------------------网关---------------------------------------

/**
 *  Alarmlevel   报警音量,范围是0-100(R/W),即0x00-0x64(R/W); 为0时关闭报警音
 */
@property (nonatomic, assign)NSInteger Alarmlevel;
/**
 *  Soundlevel   提示音音量,范围是0-100(R/W),即0x00-0x64(R/W);为0时关闭提示音
 */
@property (nonatomic, assign)NSInteger Soundlevel;
/**
 *  Betimer      报警时的时长,单位为秒,范围是0-300(R/W) 注：当被设置为0时,本地报警无效（喇叭与LED不做响应,即0x0000-0x012c
 */
@property (nonatomic, assign)NSInteger Betimer;
/**
 *  Gwlanguage   播放语音的语言,分别为CN和US两种,CN表示中文播报语音,US表示英文播报语音(R/W),即CN为0x31，US为0x32
 */
@property (nonatomic, assign)NSInteger Gwlanguage;
/**
 *  Gwlightlevel 网关灯的亮度值,范围是1-100(R/W),即0x00-0x64;为0时关闭网关灯
 */
@property (nonatomic, assign)NSInteger Gwlightlevel;
/**
 *  Gwlightonoff 网关灯的开关,0-关,1-开(R/W)
 */
@property (nonatomic, assign)NSInteger Gwlightonoff;
/**
 *   Lgtimer     网关小夜灯被触发时的亮起时长,单位为秒,范围是0-155(R/W),即0x00-0xff(R/W); 为0时即不启动
 */
@property (nonatomic, assign)NSInteger Lgtimer ;
/**
 *  Armtype      网关布防模式，0-撤防,1-外出布防,2-在家布防
 */
@property (nonatomic, assign)NSInteger Armtype ;

@end
