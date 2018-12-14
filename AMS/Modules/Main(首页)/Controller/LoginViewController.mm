//
//  LoginViewController.m
//  AMS
//
//  Created by jianlu on 2018/12/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginRequestModel.h"
#import "LoginResponseModel.h"
#import "SocketRequestManager.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTf;
@property (weak, nonatomic) IBOutlet UITextField *passwordTf;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)loginBtnTapped:(UIButton *)sender {
    LoginRequestModel *loginModel = [[LoginRequestModel alloc] init];
    loginModel.UserID = self.userNameTf.text;
    loginModel.Password = self.passwordTf.text;
    [[SocketRequestManager shareInstance]doLogin:loginModel];

}

-(void)didReceiveSocketData:(NSNotification *)noti{
    [super didReceiveSocketData:noti];
    NSString *response = noti.object;
    LoginResponseModel *model = (LoginResponseModel *)[LoginResponseModel yy_modelWithJSON:response];
    NSLog(@"登录响应-- %@",response);
    
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
