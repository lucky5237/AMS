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
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
    [self.navigationController popViewControllerAnimated:YES];
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
