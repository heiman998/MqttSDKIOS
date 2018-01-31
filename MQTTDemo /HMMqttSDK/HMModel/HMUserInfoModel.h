//
//  HMUserInfoModel.h
//  HmMqttSdk
//
//  Created by 研发ios工程师 on 2018/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMUserInfoModel : NSObject

//---------------------------------------------用户------------------------------------------
/**
 用户id
 */
@property (nonatomic, assign)NSInteger userId;
/**
 昵称
 */
@property (nonatomic, strong)NSString  * nickName;
/**
 年龄
 */
@property (nonatomic, assign)NSInteger age;
/**
 性别
 */
@property (nonatomic, assign)NSInteger sex;
/**
 国家
 */
@property (nonatomic, strong)NSString  * country;
/**
 省份
 */
@property (nonatomic, strong)NSString  * provice;
/**
 城市
 */
@property (nonatomic, strong)NSString  * city;
/**
 头像资源地址
 */
@property (nonatomic, strong)NSString  * avatar;
/**
 调用凭证
 */
@property (nonatomic, strong)NSString  * token;


@end
