//
//  AppDelegate.m
//  AMS
//
//  Created by jianlu on 2018/10/23.
//  Copyright © 2018年 jianlu. All rights reserved.
//

#import "AppDelegate.h"

#import "AppDelegate+AppSevice.h"
#import <JLRoutes.h>
#import <JPFPSStatus.h>
#import "ConfigModel.h"
#import <RDVTabBarController.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

/**
 单例获取appDelegate
 @return appDelegate实例
 */
+(AppDelegate *)shareAppDelegate{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

-(NSMutableArray *)guadanOrderArray{
    if (!_guadanOrderArray) {
        _guadanOrderArray = [[NSMutableArray alloc] init];
    }
    return _guadanOrderArray;
}

-(NSMutableArray *)weituoOrderArray{
    if (!_weituoOrderArray) {
        _weituoOrderArray = [[NSMutableArray alloc] init];
    }
    return _weituoOrderArray;
}

-(NSMutableArray *)chengjiaoOrderArray{
    if (!_chengjiaoOrderArray) {
        _chengjiaoOrderArray = [[NSMutableArray alloc] init];
    }
    return _chengjiaoOrderArray;
}

-(NSMutableArray *)chicangOrderArray{
    if (!_chicangOrderArray) {
        _chicangOrderArray = [[NSMutableArray alloc] init];
    }
    return _chicangOrderArray;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //添加socket连接
    [self initSocketConnect];
//    [NSThread sleepForTimeInterval:2];
    [self initConfig];;
    [self initDB];
    //    [self checkVersion];
    [self listenNetworkStatus];
//    [self initRoute];
    #if defined(DEBUG)||defined(_DEBUG)
        [[JPFPSStatus sharedInstance] open];
    #endif
    [self setUpRootViewController];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    // 实现如下代码，才能使程序处于后台时被杀死，调用applicationWillTerminate:方法
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^(){}];
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
     NSLog(@"applicationWillTerminate");
    [kUserDefaults setObject:@0 forKey:UserDefaults_User_Is_Login];
//    [kUserDefaults setObject:nil forKey:UserDefaults_User_ID_key];
//    [kUserDefaults setObject:nil forKey:UserDefaults_User_Password_key];
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [JLRoutes routeURL:url];
}

-(void)setTabBarHidden:(BOOL)push{
    self.rdvTabBarController.hidesBottomBarWhenPushed = push;
}




@end
