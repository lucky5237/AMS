//
//  MainViewController.m
//  AMS
//
//  Created by jianlu on 2018/10/26.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "MainViewController.h"
#import <RDVTabBarController.h>
#import <RDVTabBarItem.h>
#import "MarketViewController.h"
#import "OptionalViewController.h"
#import "TradeViewController.h"
#import "NewsViewController.h"
@interface MainViewController ()
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //行情
    MarketViewController *marketVC = [[MarketViewController alloc] init];
    RTContainerNavigationController *marketNavVc = [[RTContainerNavigationController alloc] initWithRootViewController:marketVC];
    //自选
    MarketViewController *optionalVC = [[MarketViewController alloc] init];
    optionalVC.isOption = YES;
    RTContainerNavigationController *optionalNavVc = [[RTContainerNavigationController alloc] initWithRootViewController:optionalVC];
    //交易
    TradeViewController *tradeVC = [[TradeViewController alloc] init];
    RTContainerNavigationController *tradeNavVc = [[RTContainerNavigationController alloc] initWithRootViewController:tradeVC];
    //资讯
    NewsViewController *newsVC = [[NewsViewController alloc] init];
    RTContainerNavigationController *newsNavVc = [[RTContainerNavigationController alloc] initWithRootViewController:newsVC];
    [self.tabBar setBackgroundColor:kTabBarBackGroundColor];
    self.tabBar.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0,2);
    self.tabBar.layer.shadowOpacity = 1;
    self.tabBar.layer.shadowRadius = 5;
    [self setViewControllers:@[marketNavVc,optionalNavVc,tradeNavVc,newsNavVc]];
    [self customizeTabBarForController:self];
    
}

/**
 自定义tabbar样式
 
 @param tabBarController 设置的tabBarController
 */
-(void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    //    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    //    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"行情", @"自选", @"交易",@"资讯"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setTitlePositionAdjustment:UIOffsetMake(0, 4)];
        [item setTitle:tabBarItemImages[index]];
        [item setBackgroundColor:kTabBarBackGroundColor];
        [item setSelectedTitleAttributes:@{NSForegroundColorAttributeName:kTabBarSelectTextColor,NSFontAttributeName:kFontSize(11)}];
        [item setUnselectedTitleAttributes:@{NSForegroundColorAttributeName:kTabBarNormalTextColor,NSFontAttributeName:kFontSize(11)}];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
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
