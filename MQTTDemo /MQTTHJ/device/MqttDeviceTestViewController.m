
//
//  MqttDeviceTestViewController.m
//  MQTTHJ
//
//  Created by huMac on 2017/12/14.
//  Copyright © 2017年 研发ios工程师. All rights reserved.
//

#import "MqttDeviceTestViewController.h"
#import "MqttDeviceTableViewCell.h"


@interface MqttDeviceTestViewController ()<UITableViewDelegate,UITableViewDataSource,HMMQTTDelegate>
@property (weak, nonatomic) IBOutlet UITableView *testTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *subscrib;
@property (nonatomic, strong) HMDevice *  hmDevice;
@property (nonatomic, strong) NSMutableArray * messageArray;
@property (nonatomic ,strong) NSMutableDictionary * dic;
@property (nonatomic, assign)BOOL isOnline;
@end

@implementation MqttDeviceTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [HMMqttManager manager].delegate = self;
    self.testTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.testTableView.separatorStyle = NO;
    self.hmDevice = [[HMDevice alloc]init];
    self.hmDevice.timeZone = @"-3.00";
    self.hmDevice.pid = 10000;
    self.hmDevice.factoryID = 1000;
    self.hmDevice.acckey = MQTT_ACCKEY;
    self.hmDevice.aeskey = [[NSUserDefaults standardUserDefaults] valueForKey:@"hmdevice_aeskey"];
    self.dic = [NSMutableDictionary dictionary];
    self.navigationItem.title = @"设置网关";
    self.isOnline = NO;
}

-(NSMutableArray *)messageArray{
    if (!_messageArray) {
        _messageArray = [NSMutableArray array];
    }
    return _messageArray;
}

-(void)configureWithData:(id)data{
    self.hmDevice.deviceMac = data;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[HMMqttManager manager] subscribeLastWordsWithHmDevice:self.hmDevice andHmMqttError:^(NSError *error) {
                if (error) {
                    NSLog(@"订阅遗言失败了");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.view makeToast:@"订阅遗言失败"];
                    });
                }else{
                    NSLog(@"订阅遗言成功了");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.view makeToast:@"订阅遗言成功"];
                    });
                }
            }] ;
        });
    });
}
//订阅
- (IBAction)subscribeAction:(id)sender {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[HMMqttManager manager] subscribeWithHmDevice:self.hmDevice andHmMqttError:^(NSError *error) {
                if (error) {
                    NSLog(@"订阅主题失败了");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.view makeToast:@"订阅主题成功"];
                    });
                }else{
                    NSLog(@"订阅主题成功了");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.view makeToast:@"订阅主题成功"];
                    });
                }
            }] ;
        });
    });
}

- (IBAction)cleanMessage:(id)sender {
    
    self.messageArray = nil;
    [self.testTableView reloadData];
}
#pragma mark mqttDelegate

- (void)mqttNewMessageData:(BOOL)isOnline{
    if (isOnline == YES) {
        self.navigationItem.title = @"网关在线";
    }else{
        self.navigationItem.title = @"网关离线";
    }
}

#pragma mark Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.messageArray.count==0) return 1;
    return [self.messageArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MqttDeviceTableViewCell * cell= [tableView dequeueReusableCellWithIdentifier:@"Devices"];
    if(!cell) {
        cell = [[MqttDeviceTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Devices"];
    }
    if(self.messageArray.count == 0){
        cell.sendLable.text = @"无数据发送";
        cell.receiveLable.text = @"无数据返回";
        cell.titleLable.text = @"编码";
    }else{
        NSDictionary * dicData = [self.messageArray objectAtIndex:indexPath.row];
        cell.sendLable.text = @"------------- !!!!!！ ------------";
        cell.receiveLable.text = [NSString stringWithFormat:@"%@",dicData[@"recive"]];
        cell.titleLable.text = [NSString stringWithFormat:@"%@",dicData[@"title"]];
        cell.sendLable.numberOfLines = 0;
        cell.receiveLable.numberOfLines = 0;
    }
    return cell;
}

- (IBAction)mqttTest:(UIButton*)sender {
 
    if (sender.tag == 1) {
        [self showActionWithMainframe];
    }else if (sender.tag == 2 ){
        [self  setDeviceProperty];
    }else if (sender.tag == 3 ){
        [self addZigBeeDevice];
    }
}


- (void)addZigBeeDevice{
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:@"ZigBee设备入网模式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * addDevice  = [UIAlertAction actionWithTitle:@"添加子设备" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[HMMqttManager manager] addSubDevice:YES hmDevice:self.hmDevice successBlock:^(id data) {
            
            [self showMessageWith:data];
        } hmMqttError:^(NSError *error) {
            NSLog(@"%@",error.description);
        } errorBlock:^(NSInteger fault) {
            NSLog(@"%ld",(long)fault);
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [actionSheetController addAction:addDevice];
    [actionSheetController addAction:cancelAction];
    [self presentViewController:actionSheetController animated:YES completion:nil];
}

- (void)showActionWithMainframe{
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:@"获取设备属性" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * mainframeInfo= [UIAlertAction actionWithTitle:@"获取设备的版本信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.dic setObject:@"获取版本信息" forKey:@"title"];
        [[HMMqttManager manager] getDeviceEditionInformationWithHmDevice:self.hmDevice successBlock:^(id data) {
            [self showMessageWith:data];
        } hmMqttError:^(NSError *error) {
            NSLog(@"%@",error.description);
        } coderErrorBlock:^(NSInteger fault) {
            NSLog(@"%ld",(long)fault);
        }];
    }];
    
    UIAlertAction *aes128 = [UIAlertAction actionWithTitle:@"获取秘钥" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.dic setObject:@"秘钥" forKey:@"title"];
        [[HMMqttManager manager] getSecretKeyWithHmDevice:self.hmDevice successBlock:^(id data) {
            NSDictionary * dic = data;
            if([[dic allKeys] containsObject:@"aeskey"]){
                self.hmDevice.aeskey = [dic valueForKey:@"aeskey"];
                NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
                NSString * macName = self.hmDevice.aeskey ;
                [defaults setObject:macName forKey:@"hmdevice_aeskey"];
                [defaults synchronize];
            }
            [self showMessageWith:data];
        } hmMqttError:^(NSError *error) {
            NSLog(@"%@",error.description);
        } coderErrorBlock:^(NSInteger fault) {
            NSLog(@"%ld",(long)fault);
        }];
        

    }];

    UIAlertAction * baseinfo  = [UIAlertAction actionWithTitle:@"获取网关参数信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.dic setObject:@"获取网关参数信息" forKey:@"title"];
        [[HMMqttManager manager] getGatewayParametersWithHmDevice:self.hmDevice successBlock:^(id data) {
             [self showMessageWith:data];
        } hmMqttError:^(NSError *error) {
             NSLog(@"%@",error.description);
        } errorBlock:^(NSInteger fault) {
             NSLog(@"%ld",(long)fault);
        }];
    }];
    UIAlertAction * gwSafe  = [UIAlertAction actionWithTitle:@"获取布撤防定时器" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.dic setObject:@"获取布撤防定时器" forKey:@"title"];
        [[HMMqttManager manager] getAlarmTimerInformationWithHmDevice:self.hmDevice successBlock:^(id data) {
            [self showMessageWith:data];
        } hmMqttError:^(NSError *error) {
             NSLog(@"%@",error.description);
        } errorBlock:^(NSInteger fault) {
             NSLog(@"%ld",(long)fault);
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [actionSheetController addAction:gwSafe];
    [actionSheetController addAction:mainframeInfo];
    [actionSheetController addAction:baseinfo];
    [actionSheetController addAction:aes128];
    [actionSheetController addAction:cancelAction];
    [self presentViewController:actionSheetController animated:YES completion:nil];
}

- (void)setDeviceProperty{
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:@"设置设备及网关属性" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * setMainframeInfo = [UIAlertAction actionWithTitle:@"设置网关信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        HMGatewayModel * gatewayInfo = [[HMGatewayModel alloc]init];
        gatewayInfo.Alarmlevel = 0;
        gatewayInfo.Soundlevel = 76;
        gatewayInfo.Betimer = 30;
        gatewayInfo.Gwlanguage = 0x31;
        gatewayInfo.Gwlightlevel = 44;
        gatewayInfo.Gwlightonoff = 0;
        gatewayInfo.Lgtimer = 30;
        gatewayInfo.Armtype = 1;
        [self.dic setObject:@"设置网关信息" forKey:@"title"];
        [[HMMqttManager manager] setGatewayParametersWithInfo:gatewayInfo HmDevice:self.hmDevice successBlock:^(id data) {
             [self showMessageWith:data];
        } hmMqttError:^(NSError *error) {
             NSLog(@"%@",error.description);
        } errorBlock:^(NSInteger fault) {
             NSLog(@"%ld",(long)fault);
        }];
    }];
    
    UIAlertAction * setTimeZone = [UIAlertAction actionWithTitle:@"设置时区" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.dic setObject:@"设置时区" forKey:@"title"];
        [[HMMqttManager manager] setTimerZoneWithHmDevice:self.hmDevice successBlock:^(id data) {
            [self showMessageWith:data];
        } hmMqttError:^(NSError *error) {
            NSLog(@"%@",error.description);
        } errorBlock:^(NSInteger fault) {
            NSLog(@"%ld",(long)fault);
        }];
    }];
    UIAlertAction * lightOnoff = [UIAlertAction actionWithTitle:@"一键控制ZigBee灯" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.dic setObject:@"一键控制ZigBee灯" forKey:@"title"];
        [[HMMqttManager manager] setLightSwitchWithonoff:1 hmDevice:self.hmDevice successBlock:^(id data) {
            [self showMessageWith:data];
        } hmMqttError:^(NSError *error) {
            NSLog(@"%@",error.description);
        } errorBlock:^(NSInteger fault) {
            NSLog(@"%ld",(long)fault);
        }];
    }];
    
    UIAlertAction * gwSafe  = [UIAlertAction actionWithTitle:@"设置布撤防定时器" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         [self.dic setObject:@"设置布撤防定时器" forKey:@"title"];
          HMTimer * timer = [[HMTimer alloc]init];
          timer.month = 0x07;timer.day = 0x01;timer.hour=0x01;timer.minutes=0x00;timer.wf = 0x01;
        [[HMMqttManager manager] setAlarmTimerWithWitType:0 andHmTimer:timer hmDevice:self.hmDevice successBlock:^(id data) {
            [self showMessageWith:data];
        } hmMqttError:^(NSError *error) {
            NSLog(@"%@",error.description);
        } errorBlock:^(NSInteger fault) {
            NSLog(@"%ld",(long)fault);
        }];
        
    }];

    
    UIAlertAction * upgradeDevice  = [UIAlertAction actionWithTitle:@"设备固件升级" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.dic setObject:@"固件升级" forKey:@"title"];
        [[HMMqttManager manager] updateFirmwareWithDeviceType:0x01 enable:YES zigBeeType:DEVICE_TYPE_ZIGBEE_RGB hmDevice:self.hmDevice successBlock:^(id data) {
            [self showMessageWith:data];
        } hmMqttError:^(NSError *error) {
            NSLog(@"%@",error.description);
        } errorBlock:^(NSInteger fault) {
            NSLog(@"%ld",(long)fault);
        }];
    }];
    UIAlertAction * setIP = [UIAlertAction actionWithTitle:@"设置网关IP" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          [self.dic setObject:@"网关IP" forKey:@"title"];
        [[HMMqttManager manager] setGatewayIp:MQTT_IP hmDevice:self.hmDevice successBlock:^(id data) {
            [self showMessageWith:data];
        } hmMqttError:^(NSError *error) {
            NSLog(@"%@",error.description);
        } errorBlock:^(NSInteger fault) {
            NSLog(@"%ld",(long)fault);
        }];
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [actionSheetController addAction:gwSafe];
    [actionSheetController addAction:lightOnoff];
    [actionSheetController addAction:setMainframeInfo];
    [actionSheetController addAction:setTimeZone];
    [actionSheetController addAction:upgradeDevice];
    [actionSheetController addAction:setIP];
    
    [actionSheetController addAction:cancelAction];
    
    [self presentViewController:actionSheetController animated:YES completion:nil];
}

- (void)dealloc {
    [HMMqttManager manager].delegate = nil;
    [[HMMqttManager manager] unsubscribeWithHmDevice:self.hmDevice andHmMqttError:^(NSError *error) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showMessageWith:(NSData *)data{
    NSLog(@"data-------%@",data);
    [self.dic setValue:data forKey:@"recive"];
    NSDictionary * dic1 = [self.dic copy];
    [self.view makeToast:@"返回消息成功"];
    [self.messageArray insertObject:dic1  atIndex:0];
    [self.testTableView reloadData];
    [self.dic removeAllObjects];
    
}

@end
