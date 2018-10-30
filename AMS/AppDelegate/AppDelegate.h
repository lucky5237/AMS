//
//  AppDelegate.h
//  AMS
//
//  Created by jianlu on 2018/10/23.
//  Copyright © 2018年 jianlu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AMSSocketManager;
@class ECSlidingViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AMSSocketManager *socketManager;
@property (strong, nonatomic) ECSlidingViewController *managerVc;
+(AppDelegate*) shareAppDelegate;//单例
@end

