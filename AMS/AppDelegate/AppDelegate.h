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
#import "ConfigModel.h"
#import <RDVTabBarController.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property(nonatomic,strong)RDVTabBarController *rdvTabBarController;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AMSSocketManager *socketManager;
@property (strong, nonatomic) ECSlidingViewController *managerVc;
@property (strong, nonatomic) ConfigModel *configModel;
+(AppDelegate*) shareAppDelegate;//单例
-(void)setTabBarHidden:(BOOL)push;
@end

