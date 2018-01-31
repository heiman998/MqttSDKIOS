//
//  LoginViewController.m
//  MQTTHJ
//
//  Created by 研发ios工程师 on 2017/12/13.
//  Copyright © 2017年 研发ios工程师. All rights reserved.
//

#import "LoginViewController.h"
#import "RootViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *user;

@property (weak, nonatomic) IBOutlet UITextField *passWord;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1/255.0 green:150/255.0 blue:150/255.0 alpha:0.5];
    NSDictionary *att = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:20]};
    [self.navigationController.navigationBar setTitleTextAttributes:att];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [_passWord setSecureTextEntry:YES];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentView) name:@"session已连接" object:nil];
     
}
//登陆
- (IBAction)login:(id)sender {
    
    NSString * user = self.user.text;
    NSString * passWord = self.passWord.text;
    [HMHttpManage userLoginWithUser:user password:passWord success:^(id data) {
        NSLog(@"请求成功:%@", data);
        NSString * access_token = [data valueForKey:@"access_token"];
        NSString * userId = [data valueForKey:@"userId"];
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:access_token forKey:@"access_token"];
        [defaults setObject:userId  forKey:@"userId "];
        [defaults synchronize];
        [HJAppDelegate connectToMQTT];
    } failure:^(NSError * error) {
        NSLog(@"请求失败:%@", error.description);
    }];
}
//注册
- (IBAction)onRegister:(id)sender {
    NSString * mail = @"768922975@qq.com";
    NSString * passWord = @"1234567";
    [HMHttpManage onRegisterWithUser:mail password:passWord success:^(id data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
}
//刷新凭证
- (IBAction)refreshtoken:(id)sender {
    
    [HMHttpManage refreshTokenSuccess:^(id data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
}

//忘记密码
- (IBAction)onforgetpassword:(id)sender {
    
    NSString * mail = @"123456789@qq.com";
    [HMHttpManage onForgetPasswordWithUser:mail success:^(id data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
}

-(void)presentView{
    RootViewController *rootCtl = [[RootViewController alloc] init];
    [self presentViewController:rootCtl animated:NO completion:nil];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.user resignFirstResponder];
    [self.passWord resignFirstResponder];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
