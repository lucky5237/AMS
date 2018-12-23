//
//  BaseViewController.m
//  AMS
//
//  Created by jianlu on 2018/10/25.
//  Copyright © 2018年 jianlu. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "SettingMainViewController.h"
#import "LoginViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.backgroundColor = kBackGroundColor;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = kNavBackGroundColor;
    self.navigationController.navigationBar.tintColor = kWhiteColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:kFontSize(18)}];
    if (_useRdvTab) {
        self.rdv_tabBarController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:kImageName(@"back") style:UIBarButtonItemStylePlain target:self action:@selector(backButtonItemTapped:)];
        self.rdv_tabBarController.navigationController.navigationBar.backIndicatorImage = [UIImage new];
        self.rdv_tabBarController.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage new];
    }else{
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:kImageName(@"back") style:UIBarButtonItemStylePlain target:self action:@selector(backButtonItemTapped:)];
        self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
        self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage new];
    }
    [kNotificationCenter addObserver:self selector:@selector(didConnectSocket:) name:SOCKET_DID_CONNECT_NOTIFICATION_NAME object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [kNotificationCenter addObserver:self selector:@selector(didReceiveSocketData:) name:SOCKET_NAME_DEFAULT object:nil];
    [kNotificationCenter addObserver:self selector:@selector(didResponseErrorOccurs:) name:SOCKET_RESPONSE_ERROR_NOTIFICATION_NAME object:nil];
    if (!_hideRightButton) {
        //添加导航栏右侧菜单栏
//        if (_extraRightButtonItem != nil) {
//            self.navigationItem.rightBarButtonItems = @[_extraRightButtonItem,self.menuBtnItem];
//        }else{
        if (_useRdvTab) {
            self.rdv_tabBarController.navigationItem.rightBarButtonItem = self.menuBtnItem;
        }else{
            self.navigationItem.rightBarButtonItem = self.menuBtnItem;
        }
        
//        }
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [kNotificationCenter removeObserver:self name:SOCKET_NAME_DEFAULT object:nil];
    [kNotificationCenter removeObserver:self name:SOCKET_RESPONSE_ERROR_NOTIFICATION_NAME object:nil];
    if (!_hideRightButton) {
        if (_useRdvTab) {
            self.rdv_tabBarController.navigationItem.rightBarButtonItem = nil;
        }else{
            self.navigationItem.rightBarButtonItem = nil;
        }
    }
}
-(UIBarButtonItem *)menuBtnItem{
    if (!_menuBtnItem) {
        _menuBtnItem = [[UIBarButtonItem alloc] initWithImage:kImageName(@"菜单") style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonItemTapped:)];
    }
    return _menuBtnItem;
}

-(void)rightButtonItemTapped:(UIBarButtonItem*) barItem{
    SettingMainViewController *settingVC = [[SettingMainViewController alloc] init];
    settingVC.hideRightButton = YES;
    [self.rdv_tabBarController setHidesBottomBarWhenPushed:YES];
    if (_useRdvTab) {
        [self.rdv_tabBarController.navigationController pushViewController:settingVC animated:YES];
    }else{
        [self.navigationController pushViewController:settingVC animated:YES];
    }
}

-(void)backButtonItemTapped:(UIBarButtonItem *) barItem{
    if (self.popToRoot) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)didReceiveSocketData:(NSNotification *)noti{
    
    NSLog(@"%@收到通知",NSStringFromClass([self class]));
//    NSData *data = (NSData*) noti;
    NSDictionary *responseData = noti.object;
    self.funtionNo = [responseData objectForKey:@"functionNo"];
    self.response = [responseData objectForKey:@"response"];
}

-(void)didResponseErrorOccurs:(NSNotification *)noti{
//    [MBProgressHUD hideHUD];
    NSLog(@"%@答复出错",NSStringFromClass([self class]));
    NSDictionary *errorData = noti.object;
    NSString *errorMsg = [errorData objectForKey:@"errorMsg"];
    [MBProgressHUD showErrorMessage:errorMsg];
}

-(void)didConnectSocket:(NSNotification *)noti{
    NSString *tag = noti.object;
    NSLog(@"socket（%@）连接成功",tag);
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
