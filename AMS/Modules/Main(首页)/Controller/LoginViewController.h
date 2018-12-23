//
//  LoginViewController.h
//  AMS
//
//  Created by jianlu on 2018/12/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : BaseViewController

@property(nonatomic,strong) BaseViewController *destinationVC;
@property(nonatomic,assign) BOOL showBack;
@end

NS_ASSUME_NONNULL_END
