//
//  MarketDetailViewController.m
//  AMS
//  行情详情
//  Created by jianlu on 2018/11/20.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "MarketDetailViewController.h"
#import "TimeChartViewController.h"
#import "KlineViewController.h"
#import "TradeViewController.h"
#import "HandicapViewController.h"
#import "SettingMainViewController.h"
#import <RDVTabBarItem.h>
#import "QryQuotationResponseModel.h"
#import "InstumentModel.h"
@interface MarketDetailViewController()
@property(nonatomic,strong) UIBarButtonItem *menuBtnItem;
@property(nonatomic,strong) UIBarButtonItem *timeBtnItem;
@property(nonatomic,strong) UIBarButtonItem *timeLabelBtnItem;
@end
@implementation MarketDetailViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = self.model.instrument.InstrumentName;
    self.view.backgroundColor = kBackGroundColor;
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //分时图
    TimeChartViewController *timeVC = [[TimeChartViewController alloc] init];
    timeVC.useRdvTab = YES;
    timeVC.model = self.model;
    //k线图
    KlineViewController *klineVC =[[KlineViewController alloc] init];
    klineVC.useRdvTab = YES;
    klineVC.model = self.model;
    //交易
    TradeViewController *tradeVC = [[TradeViewController alloc] init];
    klineVC.useRdvTab = YES;
    tradeVC.model = self.model;
    //盘口
    HandicapViewController *handicapVC = [[HandicapViewController alloc] init];
    handicapVC.useRdvTab = YES;
    handicapVC.model = self.model;
    
    [self.tabBar setBackgroundColor:kTabBarBackGroundColor];
    self.tabBar.delegate = self;
    self.tabBar.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0,2);
    self.tabBar.layer.shadowOpacity = 1;
    self.tabBar.layer.shadowRadius = 5;
    [self setViewControllers:@[timeVC,klineVC,tradeVC,handicapVC]];
    [self customizeTabBarForController];
    [self tabBar:self.tabBar didSelectItemAtIndex:self.selectIndex];
    self.navigationController.rt_disableInteractivePop = YES;
    
}

-(void)menuBtnItemTapped:(UIBarButtonItem*) barItem{
    SettingMainViewController *settingVC = [[SettingMainViewController alloc] init];
    settingVC.hideRightButton = YES;
    [self.rdv_tabBarController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:settingVC animated:YES];
}
-(void)customizeTabBarForController{
    //    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    //    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"分时", @"K线", @"交易",@"盘口"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        [item setTitle:tabBarItemImages[index]];
        [item setTitlePositionAdjustment:UIOffsetMake(0, 4)];
        [item setBackgroundColor:kTabBarBackGroundColor];
        [item setSelectedTitleAttributes:@{NSForegroundColorAttributeName:kTabBarSelectTextColor,NSFontAttributeName:kFontSize(11)}];
        [item setUnselectedTitleAttributes:@{NSForegroundColorAttributeName:kTabBarNormalTextColor,NSFontAttributeName:kFontSize(11)}];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        if (index == self.selectIndex) {
            [self.tabBar setSelectedItem:item];
        }

        index++;
            }
}


//-(void)tabBar:(RDVTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index{
//    [super tabBar:tabBar didSelectItemAtIndex:(NSInteger)index];
//    //交易界面添加clock
//}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

#pragma mark




@end
