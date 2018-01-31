//
//  MqttDeviceTableViewCell.h
//  MQTTHJ
//
//  Created by 研发ios工程师 on 2017/12/14.
//  Copyright © 2017年 研发ios工程师. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MqttDeviceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *sendLable;

@property (weak, nonatomic) IBOutlet UILabel *receiveLable;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@end
