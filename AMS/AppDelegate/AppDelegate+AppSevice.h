//
//  AppDelegate+AppSevice.h
//  AMS
//
//  Created by jianlu on 2018/10/29.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN
@class User_Onrtnorder;
@class User_Onrtntrade;

@interface AppDelegate (AppSevice)
-(void)setUpRootViewController;//初始化viewcontroller
-(void)listenNetworkStatus;//监听网络状态
-(void)checkVersion;//版本检查更新
-(void)initDB;//数据库操作
-(void)initRoute;//初始化路由
-(void)initConfig;//初始化配置
-(void)initSocketConnect;//初始化socket连接
-(void)dealOrderInsertResponse:(User_Onrtnorder*)model;//报单通知
-(void)dealOrderTradeResponse:(User_Onrtntrade*)model;//成交通知
-(void)dealOrderPosition:(NSArray *)models;//处理持仓
@end

NS_ASSUME_NONNULL_END
