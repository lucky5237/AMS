//
//  AppDelegate+AppSevice.m
//  AMS
//
//  Created by jianlu on 2018/10/29.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "AppDelegate+AppSevice.h"
#import "MainViewController.h"
#import <ECSlidingViewController.h>
#import <RealReachability.h>
#import "LeftMenuViewController.h"
#import "MarketViewController.h"
#import "OptionalViewController.h"
#import "TradeViewController.h"
#import "NewsViewController.h"
#import <RTRootNavigationController.h>
#import <JDStatusBarNotification.h>
#import <RDVTabBarController.h>
#import <Harpy.h>
#import <JQFMDB.h>
#import <JLRoutes.h>
#import <RDVTabBarItem.h>
//#import "DetailViewController.h"

@implementation AppDelegate (AppSevice)

/**
 初始化controller
 */
-(void)setUpRootViewController{
    //行情
    MarketViewController *marketVC = [[MarketViewController alloc] init];
    RTRootNavigationController *marketNavVc = [[RTRootNavigationController alloc] initWithRootViewController:marketVC];
    //自选
    OptionalViewController *optionalVC = [[OptionalViewController alloc] init];
    RTRootNavigationController *optionalNavVc = [[RTRootNavigationController alloc] initWithRootViewController:optionalVC];
    //交易
    TradeViewController *tradeVC = [[TradeViewController alloc] init];
    RTRootNavigationController *tradeNavVc = [[RTRootNavigationController alloc] initWithRootViewController:tradeVC];
    //资讯
    NewsViewController *newsVC = [[NewsViewController alloc] init];
    
    //RDV
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController.tabBar setBackgroundColor:[UIColor colorWithRed:38/255 green:38/255 blue:38/255 alpha:1]];
    [tabBarController setViewControllers:@[marketNavVc,optionalNavVc,tradeNavVc,newsVC]];
    [self customizeTabBarForController:tabBarController];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
}

/**
 监听网络清理
 */
-(void)listenNetworkStatus{
    [GLobalRealReachability startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged:) name:kRealReachabilityChangedNotification object:nil];
}

/**
 版本检查更新
 */
-(void)checkVersion{
    [[Harpy sharedInstance] setPresentingViewController:self.window.rootViewController];
    [[Harpy sharedInstance] checkVersion];
}

/**
 初始化数据库
 */
- (void)initDB{
  
}

/**
 初始化路由
 */
-(void)initRoute{
    [[JLRoutes globalRoutes] addRoute:@"/user/view/:userID" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        NSString *userID = parameters[@"userID"];
        NSLog(@"userID --- %@",userID);
        return YES;
    }];
}

/**
 监听网络发生变化之后的回调
 @param notification 通知内容
 */
-(void)networkChanged:(NSNotification*) notification{
    RealReachability *realReachaility = (RealReachability*)notification.object;
    ReachabilityStatus status = [realReachaility currentReachabilityStatus];
    NSLog(@"currentStatus:%@",@(status));
    switch (status) {
        case RealStatusNotReachable:
            [JDStatusBarNotification showWithStatus:@"当前无网络连接" dismissAfter:2 styleName:JDStatusBarStyleError];
            break;
        case RealStatusViaWiFi:
            [JDStatusBarNotification showWithStatus:@"已连接WiFi" dismissAfter:2 styleName:JDStatusBarStyleSuccess];
            break;
        case RealStatusViaWWAN:
            NSLog(@"当前有WWAN连接");
            if ([realReachaility currentWWANtype] == WWANType4G) {
                 [JDStatusBarNotification showWithStatus:@"已连接4G" dismissAfter:2 styleName:JDStatusBarStyleSuccess];
            }
            break;
        default:
            NSLog(@"未知网络连接");
            break;
    }
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
        [item setTitle:tabBarItemImages[index]];
        [item setBackgroundColor:[UIColor colorWithRed:38/255 green:38/255 blue:38/255 alpha:1]];
        [item setSelectedTitleAttributes:@{NSForegroundColorAttributeName:kRedColor,NSFontAttributeName:kFontSize(12)}];
        [item setUnselectedTitleAttributes:@{NSForegroundColorAttributeName:kWhiteColor,NSFontAttributeName:kFontSize(12)}];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
}

@end
