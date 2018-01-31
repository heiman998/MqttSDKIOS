//
//  UIView+Toast.h
//  SmartHome
//
//  Created by 研发ios工程师 on 2017/10/19.
//  Copyright © 2017年 深圳海曼科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Toast)
// each makeToast method creates a view and displays it as toast
- (void)makeToast:(NSString *)message;

@end
