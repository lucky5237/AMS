//
//  BaseViewController.h
//  AMS
//
//  Created by jianlu on 2018/10/25.
//  Copyright © 2018年 jianlu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
@property(nonatomic,assign) BOOL hideRightButton;
@property(nonatomic,assign) BOOL useRdvTab;
@property(nonatomic,strong) UIBarButtonItem *extraRightButtonItem;
@property(nonatomic,strong) UIBarButtonItem *menuBtnItem;
@end

NS_ASSUME_NONNULL_END
