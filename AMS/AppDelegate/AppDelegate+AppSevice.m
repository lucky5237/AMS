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

@implementation AppDelegate (AppSevice)

/**
 初始化controller
 */
-(void)setUpRootViewController{
    //首页controller
    MainViewController *mainVc = [[MainViewController alloc] init];
    mainVc.view.backgroundColor = [UIColor greenColor];
    UINavigationController *navVc = [[UINavigationController alloc] initWithRootViewController:mainVc];
    //管理controller
    ECSlidingViewController *managerVc = [[ECSlidingViewController alloc] initWithTopViewController:navVc];
    //左边controller
    UITableViewController *leftVc = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    leftVc.view.backgroundColor = [UIColor redColor];
    //右边controller
    UITableViewController *rightVc = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    rightVc.view.backgroundColor = [UIColor blueColor];
    managerVc.underLeftViewController = leftVc;
    managerVc.underRightViewController = rightVc;
    managerVc.anchorRightPeekAmount = 100;
    managerVc.anchorLeftPeekAmount = 100;
    [mainVc.view addGestureRecognizer:managerVc.panGesture];
    
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
            NSLog(@"当前无网络连接");
            break;
        case RealStatusViaWiFi:
            NSLog(@"当前有WiFi连接");
            break;
        case RealStatusViaWWAN:
            NSLog(@"当前有WWAN连接");
            break;
        default:
            NSLog(@"未知网络连接");
            break;
    }
}

@end
