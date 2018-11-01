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
#import <RTRootNavigationController.h>
#import <JDStatusBarNotification.h>

@implementation AppDelegate (AppSevice)

/**
 初始化controller
 */
-(void)setUpRootViewController{
    //首页controller
    MainViewController *mainVc = [[MainViewController alloc] init];
    mainVc.view.backgroundColor = [UIColor greenColor];
    RTRootNavigationController *navVc = [[RTRootNavigationController alloc] initWithRootViewController:mainVc];
//    navVc.navigationBar.translucent = NO;
    //管理controller
    ECSlidingViewController *managerVc = [[ECSlidingViewController alloc] initWithTopViewController:navVc];
    //左边controller
    LeftMenuViewController *leftVc = [[LeftMenuViewController alloc] init];
    leftVc.view.backgroundColor = kWhiteColor;
    //右边controller
    UITableViewController *rightVc = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    rightVc.view.backgroundColor = [UIColor blueColor];
    managerVc.underLeftViewController = leftVc;
    managerVc.underRightViewController = rightVc;
    managerVc.anchorRightPeekAmount = 100;
    managerVc.anchorLeftPeekAmount = 100;
//    [mainVc.view addGestureRecognizer:managerVc.panGesture];
    
    self.managerVc = managerVc;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = managerVc;
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

@end
