//
//  Enum.h
//  HmMqttSdk
//
//  Created by mac on 2017/11/29.
//  Copyright © 2017年 mac. All rights reserved.
//


#ifndef Enum_h
#define Enum_h

#pragma mark ----------------------------企业ID宏定义-------------------------------------
/**
 企业ID  (写自己的企业ID , 字符串类型，可更改)
 */
#define COMPANY_ID         @"1000"


#pragma mark ----------------------------设备类型枚举-------------------------------------
typedef NS_ENUM(NSInteger, DEVICE_TYPE) {
    
    DEVICE_TYPE_DEVICE_NONE = 0,
    
    DEVICE_TYPE_ZIGBEE_RGB = 1,                          //ZIGBEE RGB灯
    DEVICE_TYPE_ZIGBEE_ONE_ONOFF = 2,                    //ZIGBEE 一路开关
    DEVICE_TYPE_ZIGBEE_TWO_ONOFF = 3,                    //ZIGBEE 二路开关
    DEVICE_TYPE_ZIGBEE_THREE_ONOFF = 4,                  //ZIGBEE 三路开关
    DEVICE_TYPE_ZIGBEE_RC = 5,                           //ZIGBEE 红外转发器
    DEVICE_TYPE_ZIGBEE_RELAY = 6,                        //ZIGBEE 继电器
    DEVICE_TYPE_ZIGBEE_BRIGHT_SWITCH = 7,                //调光开关
    DEVICE_TYPE_ZIGBEE_LAMP_HEADER = 8,                  //灯头
    DEVICE_TYPE_ZIGBEE_SCENE_SWITCH = 9,                 //情景开关
    DEVICE_TYPE_ZIGBEE_FOUR_WHEEL = 10,                  //四驱灯控
    
    DEVICE_TYPE_ZIGBEE_DOORS = 17,                       //ZIGBEE 门磁
    DEVICE_TYPE_ZIGBEE_WATER = 18,                       //ZIGBEE 水浸
    DEVICE_TYPE_ZIGBEE_PIR = 19,                         //ZIGBEE 红外
    DEVICE_TYPE_ZIGBEE_SMOKE = 20,                       //ZIGBEE 烟感
    DEVICE_TYPE_ZIGBEE_THP = 21,                         //ZIGBEE 温湿度
    DEVICE_TYPE_ZIGBEE_GAS = 22,                         //ZIGBEE 气感
    DEVICE_TYPE_ZIGBEE_SOUND_AND_LIGHT_ALARM = 23,       //ZIGBEE 声光警号
    
    DEVICE_TYPE_ZIGBEE_CO = 24,                          //ZIGBEE 一氧化碳探测器
    DEVICE_TYPE_ZIGBEE_ILLUMINANCE = 25,                 //ZIGBEE 光照度
    DEVICE_TYPE_ZIGBEE_AIR = 26,                         //ZIGBEE 空气质量
    DEVICE_TYPE_ZIGBEE_THERMOSTAT = 27,                  //ZIGBEE 温控器
    DEVICE_TYPE_ZIGBEE_SHOCK = 28,                       //ZIGBEE 震动
    
    DEVICE_TYPE_ZIGBEE_SOS = 49,                         //ZIGBEE SOS报警器
    DEVICE_TYPE_ZIGBEE_SW = 50,                          //ZIGBEE 遥控器
    DEVICE_TYPE_ZIGBEE_PLUGIN = 67,                      //ZIGBEE 普通插座
    DEVICE_TYPE_ZIGBEE_METRTING_PLUGIN = 68,             //ZIGBEE 计量插座
    DEVICE_TYPE_ZIGBEE_CURTAIN_CONTROLLER = 69,                     ///ZIGBEE 窗帘电机
    DEVICE_TYPE_ZIGBEE_INTELLIGENT_DOOR_LOCK  = 70,                  ///ZIGBEE 智能门锁
    
    ///Wifi设备
    DEVICE_TYPE_WIFI_RC = 100,                  //红外遥控转发器
    DEVICE_TYPE_WIFI_GATEWAY = 769,             //智能网关
    DEVICE_TYPE_WIFI_GATEWAY_HS1GW_NEW = 770,   //新小网关
    DEVICE_TYPE_WIFI_GATEWAY_HS2GW = 771,       //大网关
    DEVICE_TYPE_WIFI_PLUGIN = 1041,             //智能插座
    DEVICE_TYPE_WIFI_METRTING_PLUGIN = 1042,    //计量插座
    DEVICE_TYPE_WIFI_AIR = 1043,                //空气质量
    DEVICE_TYPE_WIFI_GAS = 1044,                //气感
    DEVICE_TYPE_WIFI_IPC = 2049,                //摄像头
    
};

#pragma mark ----------------------------定时器WF枚举---------------------------------------

typedef NS_ENUM(NSInteger, TimeWF) {
    
    TimeWFMon = 1,
    TimeWFTue = 2,
    TimeWFWen = 4,
    TimeWFThu = 8,
    TimeWFFri = 16,
    TimeWFSat = 32,
    TimeWFSun = 64,
};


#pragma mark ----------------------------动作类型枚举---------------------------------------

typedef NS_ENUM(NSInteger, ACTION_TYPE) {
    
    ACTION_CONTROL = 1,                    //控制请求
    ACTION_CONTROL_ACK = 2,                //控制请求回应
    ACTION_REPORT = 3,                     //设备主动上报
    ACTION_EVENT = 4,                      //事件
    ACTION_ALARM = 5,                      //报警
    ACTION_FAULT = 6,                      //故障
    ACTION_COERCION_OTA = 7,               //强制性升级
    ACTION_COERCION_OTA_ACK = 8,           //强制升级回复
    ACTION_OTA = 9,                        //手动升级
    ACTION_OTA_ACK = 10,                   //手动升级回复
    ACTION_SENDKEY = 11,                   //上报密匙
    ACTION_SENDLIST = 12,                  //发送子设备列表信息
    ACTION_GETDEVICEID = 13,               //获取设备id
    ACTION_GETDEVICEID_ACK = 14,           //获取设备id回复
    ACTION_GETTIME = 15,                   //获取时间
    ACTION_GETTIME_ACK = 16,               //获取时间回复
    ACTION_SCEN = 17,                      //执行场景
    ACTION_SCENE_ACK = 18,                 //执行场景回复
    ACTION_LINKAGE = 19,                   //执行联动
    ACTION_LINKAGE_ACK = 20,               //执行联动回复
    ACTION_SUB_ONLINE = 21,                //子设备在线状态
    ACTION_ONLINE = 22 ,                   //模块上线
    ACTION_DISCONNECT = 23,                //模块断开连接
    ACTION_DISCONNET = 33,                 //连接断开
};

#pragma mark ----------------------------数据类型枚举-------------------------------------

typedef NS_ENUM(NSInteger, DATA_TYPE) {
    
    DATA_TYPE_ACTION = 51,                     //动作
    DATA_TYPE_PASS = 52,                       //透传数据
    DATA_TYPE_POINT = 53,                      //数据端点值
    DATA_TYPE_RESULT = 54,                     //处理结果(1为成功0为失败)
    DATA_TYPE_ENCRYPT_TYPE = 55,               //加密类型
    DATA_TYPE_LIST = 56,                       //上传的子模块列表
    DATA_TYPE_TIESTAMP = 57,                   //获取时间回复的时间戳
};

#pragma mark ----------------------------编解码错误码---------------------------------------

typedef NS_ENUM(NSInteger, RC) {
    
    RC_SUCCESS = 0x0001,                                    //成功
    RC_UNKNOWN_ERROR = 0x0000,                              //未知错误
    RC_PARAMETER_ERROR = 0x0003,                            //参数错误
    RC_DECRYPTION_FAILURE = 0x0004,                         //解密失败 (明文回复)
    RC_THE_OID_DOES_NOT_EXIST = -3,                         //不存在该OID
    RC_CID_DOES_NOT_EXIST = -4,                             //CID不存在
    RC_PL_CANNOT_BE_EMPTY = -5,                             //PL中不能为空
    RC_TEID_CANNOT_BE_EMPTY = -6,                           //TEID不能为空
    RC_WIFI_GAS_PREHEATING = 10000,                         //WiFi气感预热中
    RC_APP_SEND = 0xffff,                                   //app发送
};

#pragma mark ------------------------------数据端点---------------------------------------

typedef NS_ENUM(NSInteger, HMPOINT) {
    
    alarm_msg   = 101,
    BP          = 102,
    message     = 103,
    check       = 104,
    OL          = 105,
    key         = 106,
    deviceId    = 107,
    mac         = 108,
    alarmTime   = 109,
    sub_index   = 110,
    BA          = 111,
    OP          = 112,
    AS          = 113,
    OF          = 114,
    HY          = 115,
    TP          = 116,
    HU          = 117,
    HL          = 118,
    TU          = 119,
    TL          = 120,
    LE          = 121,
    CR          = 122,
    CG          = 123,
    CB          = 124,
    RO          = 125,
    UO          = 126,
    PW          = 127,
    ET          = 128,
    TM          = 129,
    OF1         = 130,
    OF2         = 131,
    OF3         = 132,
    TV          = 133,
    P2          = 134,
    CC          = 135,
    AQ          = 136,
    P1          = 137,
    LEL         = 138,
    CWL         = 139,
    AL          = 140,
    SL          = 141,
    BT          = 142,
    LG          = 143,
    LL          = 144,
    LO          = 145,
    LT          = 146,
    AT          = 147,
    RD          = 148,
    HO          = 149,
    bL          = 150,
    url         = 151,
    size        = 152,
    soft_version    = 153,
    md5             = 154,
    ota_id          = 155,
    firmware_type   = 156,
    OF4             = 157,
    is_remove       = 158,
    temp_too_high   = 159,
    count           = 160,
    LEL1            = 161,
    LEL2            = 162,
    LEL3            = 163,
    LEL4            = 164,
    CWL1            = 165,
    CWL2            = 166,
    CWL3            = 167,
    CWL4            = 168,
    
};

#endif /* Enum_h */


