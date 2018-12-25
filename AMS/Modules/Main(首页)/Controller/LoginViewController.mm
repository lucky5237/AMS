//
//  LoginViewController.m
//  AMS
//
//  Created by jianlu on 2018/12/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "LoginViewController.h"
#import "User_Requserlogin.h"
#import "User_Onrspuserlogin.h"
#import "SocketRequestManager.h"
#import "best_sdk_define.h"
#import "User_Reqqryinvestorposition.h"
#import "MainViewController.h"
#import "TradeViewController.h"
#import "AMSSocketManager.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTf;
@property (weak, nonatomic) IBOutlet UITextField *passwordTf;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *registerLabel;
@property (weak, nonatomic) IBOutlet UIView *userNameView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self.registerLabel zj_addTapGestureWithCallback:^(UITapGestureRecognizer *gesture) {
        NSLog(@"点击了注册按钮");
    }];
    if([kUserDefaults objectForKey:UserDefaults_User_ID_key] !=nil){
        self.userNameTf.text = [kUserDefaults objectForKey:UserDefaults_User_ID_key];
    }
    if ([kUserDefaults objectForKey:UserDefaults_User_Password_key] !=nil) {
        self.passwordTf.text = [kUserDefaults objectForKey:UserDefaults_User_Password_key];
    }
    if (self.showBack) {
        
        UIImageView *backImageView = [UIImageView zj_imageViewWithImage:kImageName(@"back")];
        [self.navigationController.navigationBar addSubview:backImageView];
        [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(9, 15));
            make.centerY.mas_equalTo(self.navigationController.navigationBar);
        }];
        [backImageView zj_addTapGestureWithCallback:^(UITapGestureRecognizer *gesture) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
}
}

- (IBAction)loginBtnTapped:(UIButton *)sender {
 
        
    
    User_Requserlogin *loginModel = [[User_Requserlogin alloc] init];
    loginModel.UserID = self.userNameTf.text;
    loginModel.Password = self.passwordTf.text;
    loginModel.BrokerID = @"9999";
    [MBProgressHUD showActivityMessageInWindow:@""];
    [[SocketRequestManager shareInstance]doLogin:loginModel];
//    if(self.showBack){
//        [(MainViewController*) kAppWindow.rootViewController setTabbarSelection:2];
//        [self dismissViewControllerAnimated:YES completion:^{
////            [(MainViewController*) kAppWindow.rootViewController setTabbarSelection:2];
//        }];
//    }else if(self.navigationController != nil){
//        if (self.destinationVC != nil) {
//            [self.navigationController pushViewController:self.destinationVC animated:YES];
//
//        }
//        [self.navigationController po:YES];
        
        
//    }
}

-(void)didReceiveSocketData:(NSNotification *)noti{
    [super didReceiveSocketData:noti];
    if ((int32)self.funtionNo.intValue == AS_SDK_USER_ONRSPUSERLOGIN) {
        User_Onrspuserlogin *model = self.response.firstObject;
        if(model != nil){
            [MBProgressHUD hideHUD];
            //        [MBProgressHUD showSuccessMessage:@"登录成功"];
            [kUserDefaults setObject:@1 forKey:UserDefaults_User_Is_Login];
            [kUserDefaults setObject:self.userNameTf.text forKey:UserDefaults_User_ID_key];
            [kUserDefaults setObject:self.passwordTf.text forKey:UserDefaults_User_Password_key];
            
            //登录之后查询一次持仓至内存中
            User_Reqqryinvestorposition *request = [[User_Reqqryinvestorposition alloc] init];
            request.BrokerID = @"9999";
            request.InvestorID = model.UserID;
            [[SocketRequestManager shareInstance] reqqryinvestorposition:request];
            if(self.navigationController != nil && [self.destinationVC isKindOfClass:[TradeViewController class]]){
                [self.navigationController popViewControllerAnimated:YES];
                if (self.destinationVC != nil) {
                    [self.navigationController pushViewController:self.destinationVC animated:YES];
                }

            }else{
                [self dismissViewControllerAnimated:YES completion:^{
                    [(MainViewController*) kAppWindow.rootViewController setTabbarSelection:2];
                }];
            }
           
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
