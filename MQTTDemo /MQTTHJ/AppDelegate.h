//
//  AppDelegate.h
//  MQTTHJ
//
//  Created by 研发ios工程师 on 2017/11/27.
//  Copyright © 2017年 研发ios工程师. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder 

@property (strong, nonatomic) UIWindow *window;

//连接mqtt
- (void)connectToMQTT;

@end
