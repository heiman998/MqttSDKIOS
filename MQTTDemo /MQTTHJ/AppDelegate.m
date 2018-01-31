//
//  AppDelegate.mc
//  MQTTHJ
//
//  Created by 研发ios工程师 on 2017/11/27.
//  Copyright © 2017年 研发ios工程师. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "RootViewController.h"
#import "XGPush.h"//信鸽推送
#import <UserNotifications/UserNotifications.h>

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<XGPushDelegate>

@property (nonatomic, retain) NSDictionary *remoteNotification;
@property (nonatomic, assign) BOOL isLaunchedByNotification;
@property (nonatomic, assign) BOOL isBackGround;
@property (nonatomic, strong)HMDevice * hmDevice;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //开启 Debug
    [[XGPush defaultManager] setEnableDebug:YES];
    //启动信鸽推送服务
    [[XGPush defaultManager] startXGWithAppID:2200275057 appKey:@"ITNDG3352F3X" delegate:self];
    //终止信鸽推送服务
    //[[XGPush defaultManager] stopXGNotification];
    // 统计推送效果
    [[XGPush defaultManager] reportXGNotificationInfo:launchOptions];
    //获取密钥
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"ZGW_MAC_Name"] == nil) {
        [self getAeskey];
    }
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor =[UIColor whiteColor];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    LoginViewController * loginVC =[sb instantiateViewControllerWithIdentifier:@"Login"];
    self.window.rootViewController = loginVC;
    [self.window makeKeyAndVisible]; 
    return YES;
}

/**
 初始化mqtt 开启SDK
 */
- (void)connectToMQTT {
    [[HMMqttManager manager] initSDK];
    Boolean connect =  [[HMMqttManager manager] connectWithHost:MQTT_IP port:MQTT_PORT];
    if (connect == YES) {
        NSLog(@"连接成功");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"session已连接" object:nil userInfo:nil];
    }else{
        NSLog(@"连接超时");
    }
}


//第一次进入app网关配网后，获取网关mac地址，操作设备之前要获取密钥，下次进入app 建议首先获取密钥（根据网关mac地址）
- (void)getAeskey{
    
    self.hmDevice = [[HMDevice alloc]init];
    _hmDevice.pid = MQTT_PID;
    _hmDevice.factoryID = MQTT_FACTORYID;
    _hmDevice.acckey = MQTT_ACCKEY;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     _hmDevice.deviceMac = [defaults objectForKey:@"ZGW_MAC_Name"];
    [[HMMqttManager manager] subscribeWithHmDevice:_hmDevice];
    [[HMMqttManager manager] getSecretKeyWithHmDevice:_hmDevice successBlock:^(id data) {
        NSDictionary * dic = data;
        if([[dic allKeys] containsObject:@"aeskey"]){
            _hmDevice.aeskey = [dic valueForKey:@"aeskey"];
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:_hmDevice.aeskey forKey:@"hmdevice_aeskey"];
            [defaults synchronize];
        }
    } hmMqttError:^(NSError *error) {
        NSLog(@"%@",error.description);
    } coderErrorBlock:^(NSInteger fault) {
        NSLog(@"%ld",(long)fault);
    }];
}

#pragma mark - XGPushDelegate

//统计消息被点击情况
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[XGPush defaultManager] reportXGNotificationInfo:userInfo];
}

//监控开始推送服务的消息
- (void)xgPushDidFinishStart:(BOOL)isSuccess error:(NSError *)error {
    NSLog(@"%s, result %@, error %@", __FUNCTION__, isSuccess?@"OK":@"NO", error);
}

//监控停止推送服务消息
- (void)xgPushDidFinishStop:(BOOL)isSuccess error:(NSError *)error {
    NSLog(@"%s, result %@, error %@", __FUNCTION__, isSuccess?@"OK":@"NO", error);
}

//启动推送服务以后,如果注册推送成功就调用下面方法
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
   
//    NSString * result = [AppDelegate stringByData:deviceToken];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:deviceToken forKey:@"xg121_deviceToken"];
    [defaults synchronize];
//    [[XGPushTokenManager defaultTokenManager] registerDeviceToken:deviceToken];
}



// iOS 10 新增 API
// iOS 10 会走新 API, iOS 10 以前会走到老 API
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
// App 用户点击通知
// App 用户选择通知中的行为
// App 用户在通知中心清除消息
// 无论本地推送还是远程推送都会走这个回调
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center
      didReceiveNotificationResponse:(UNNotificationResponse *)response
               withCompletionHandler:(void(^)(void))completionHandler NS_AVAILABLE_IOS(10_0) {
    [[XGPush defaultManager] reportXGNotificationInfo:response.notification.request.content.userInfo];
    
    completionHandler();
}
// App 在前台弹通知需要调用这个接口
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler NS_AVAILABLE_IOS(10_0) {
    [[XGPush defaultManager] reportXGNotificationInfo:notification.request.content.userInfo];
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}
#endif

/*
 绑定标签：
 [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:@"your tag" type:XGPushTokenBindTypeTag];
 
 解绑标签
 [[XGPushTokenManager defaultTokenManager] unbindWithIdentifer:@"your tag" type:XGPushTokenBindTypeTag];
 
 绑定账号：
 [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:@"your account" type:XGPushTokenBindTypeAccount];
 
 解绑账号：
 [[XGPushTokenManager defaultTokenManager] unbindWithIdentifer:@"your account" type:XGPushTokenBindTypeAccount];
 */


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[HMMqttManager manager] unsubscribeWithHmDevice:self.hmDevice andHmMqttError:^(NSError *error) {
    }];
}

//+ (NSString *)stringByData:(NSData *)data{
//    
//    return [[[[NSString stringWithFormat:@"%@",data]
//              stringByReplacingOccurrencesOfString: @"<" withString: @""]
//             stringByReplacingOccurrencesOfString: @">" withString: @""]
//            stringByReplacingOccurrencesOfString: @" " withString: @""];
//    
//}


@end
