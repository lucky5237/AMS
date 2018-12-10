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
#import <JDStatusBarNotification.h>
#import <Harpy.h>
#import <JQFMDB.h>
#import <JLRoutes.h>


@implementation AppDelegate (AppSevice)

/**
 初始化controller
 */
-(void)setUpRootViewController{
   

    MainViewController *mainVC = [[MainViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = mainVC;
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

@end
