//
//  SceneViewController.m
//  MQTTHJ
//
//  Created by 研发ios工程师 on 2017/12/13.
//  Copyright © 2017年 研发ios工程师. All rights reserved.
//

#import "SceneViewController.h"

@interface SceneViewController ()

@property (nonatomic,strong)NSString * sceneId;

@end

@implementation SceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"场景相关测试";
}

/**
count = 2;
limit = 100;
list =     (
            {
                id = 18605;
                isOnline = 1;
                mac = 142f1201008d1500;
                productId = 68;
                subIndex = 16900;
            },
            {
                id = 18606;
                isOnline = 1;
                lastData = "2018-01-12 16:43:36";
                mac = 965e2e1fc9435000;
                productId = 67;
                subIndex = 4701;
            }
            );
*/
//创建场景
- (IBAction)setscene:(id)sender {
    
    NSString * sceneName = @"老胡的Scene";
    NSString * sceneIcon = @"device_pressed_icon";
    NSString * countTime = @"1";
//    下面是写死的，到时候在设备列表中获取
    NSDictionary * dic1 = @{@"deviceId":@18600,
                            @"subIndex":@29200,
                            @"dataEndpoint":@ {HmP(RO):@1,
                                HmP(RO):@1
                            }
                            };
    NSDictionary * dic2 = @{@"deviceId":@18600,@"subIndex":@28501,@"dataEndpoint":@ {@"RO":@1}};
    NSArray * arr1 = @[dic1,dic2];
    
    [HMHttpManage onSceneCreateWithSceneName:sceneName sceneIcon:sceneIcon countTime:countTime execList:arr1 success:^(id data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.sceneId =  [NSString stringWithFormat:@"%@",[dic valueForKey:@"sceneId"]];
        NSLog(@"服务器返回场景信息--%@",dic);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view makeToast:@"创建场景成功"];
        });
    } failure:^(NSError *error) {
    }];
}
//执行场景
- (IBAction)doScene:(id)sender {
    
    [HMHttpManage onSceneExecuteWithSceneID:self.sceneId success:^(id data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        NSLog(@"----执行场景成功----");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view makeToast:@"执行场景成功"];
        });
    } failure:^(NSError *error) {
        NSLog(@"----执行场景失败----");
    }];
}

- (IBAction)deleteScene:(id)sender {
    
    [HMHttpManage onSceneDeleceWithSceneID:self.sceneId success:^(id data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        NSLog(@"----删除场景成功----");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view makeToast:@"删除场景成功"];
        });
    } failure:^(NSError *error) {
        NSLog(@"----获取场景失败----");
    }];
}



- (IBAction)getScene:(id)sender {
    
    [HMHttpManage onSceneGetIDWithSceneID:self.sceneId success:^(id data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        NSLog(@"----获取场景成功----");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view makeToast:@"获取场景成功"];
        });
    } failure:^(NSError *error) {
        NSLog(@"----获取场景失败----");
    }];
}

//创建联动
- (IBAction)onLinkCreate:(id)sender {
    NSString * linkName = @"老胡的联动";
    NSString * countTime = @"1";
    BOOL checkEn = true;
    NSDictionary * dic = @{
                           @"type":@0,
                           @"deviceId":@135112,
                           @"subId":@135113,
                           @"dataEndpoint":@ {HmP(RO):@1,HmP(RO):@1},
                           @"data":@"xxxxx",
                           @"ts":@"1999-12-03 14:22:55",
                           @"wf":@255,
                           @"timeZone":@8.5
                           };
    NSDictionary * dic1 = @{
                            @"type":@0,
                            @"deviceId":@135112,
                            @"subId":@135113,
                            @"dataEndpoint":@ {HmP(RO):@1,HmP(RO):@1},
                            @"data":@"xxxxx",
                            @"ts":@"1999-12-03 14:22:55",
                            @"te":@"1999-12-03 14:22:55",
                            @"wf":@255,
                            @"timeZone":@8.5
                            };
    NSArray * checkList = @[dic1];
    
    NSDictionary * dic2 = @{
                            @"type": @0,
                            @"sceneID":@111,//场景ID
                            @"deviceID":@12345,//设备ID
                            @"subID":@11111,//子设备ID
                            @"dataEndpoint":@ {HmP(RO):@1,HmP(RO):@1},
                            @"data":@"xxxxx",
                            @"timeZone":@8.5
                            };
    NSArray *execList = @[dic2];
    [HMHttpManage onLinkCreateWithLinkName:linkName checkEn:checkEn countTime:countTime conList:dic checkList:checkList execList:execList success:^(id data) {
        NSLog(@"创建联动成功消息：%@",data);
    } failure:^(NSError *error) {
        NSLog(@"创建联动失败");
    }];
}

//删除场景联动
- (IBAction)deleteLinkScene:(id)sender {
    
    [HMHttpManage onLinkDeleceWithLinkID:self.sceneId success:^(id data) {
        NSLog(@"删除联动成功");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view makeToast:@"删除联动成功"];
        });
    } failure:^(NSError *error) {
        NSLog(@"删除联动失败");
    }];
}

//查询单个场景联动
- (IBAction)findSingleLink:(id)sender {
    [HMHttpManage onLinkGetIDWithLinkID:self.sceneId success:^(id data) {
        NSLog(@"场景联动消息：%@",data);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view makeToast:@"查询单个场景成功"];
        });
    } failure:^(NSError *error) {
        NSLog(@"查询单个联动场景失败");
    }];
}
//联动使能
- (IBAction)linkEnable:(id)sender {
    [HMHttpManage onLinkEnableAndSuccess:^(id data) {
    } failure:^(NSError *error) {
    }];
}








@end
