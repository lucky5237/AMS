//
//  AppDelegate+AppSevice.h
//  AMS
//
//  Created by jianlu on 2018/10/29.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (AppSevice)
-(void)setUpRootViewController;//初始化viewcontroller
-(void)listenNetworkStatus;//监听网络状态

@end

NS_ASSUME_NONNULL_END
