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

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTf;
@property (weak, nonatomic) IBOutlet UITextField *passwordTf;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *registerLabel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self.registerLabel zj_addTapGestureWithCallback:^(UITapGestureRecognizer *gesture) {
        NSLog(@"点击了注册按钮");
    }];

}
- (IBAction)loginBtnTapped:(UIButton *)sender {
    User_Requserlogin *loginModel = [[User_Requserlogin alloc] init];
    loginModel.UserID = self.userNameTf.text;
    loginModel.Password = self.passwordTf.text;
    [MBProgressHUD showActivityMessageInWindow:@""];
    [[SocketRequestManager shareInstance]doLogin:loginModel];
}

-(void)didReceiveSocketData:(NSNotification *)noti{
    [super didReceiveSocketData:noti];
    NSString *response = noti.object;
    NSLog(@"登录响应-- %@",response);
    User_Onrspuserlogin *model = (User_Onrspuserlogin *)[User_Onrspuserlogin yy_modelWithJSON:response];
    if(model != nil){
        [MBProgressHUD hideHUD];
//        [MBProgressHUD showSuccessMessage:@"登录成功"];
        [kUserDefaults setObject:model.UserID forKey:UserDefaults_User_ID_key];
        [self.navigationController popViewControllerAnimated:YES];
        if (self.destinationVC != nil) {
            [self.navigationController pushViewController:self.destinationVC animated:YES];
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
