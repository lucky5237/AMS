//
//  MarketDetailViewController.h
//  AMS
//
//  Created by jianlu on 2018/11/20.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <RDVTabBarController.h>
#import "Y_BollMAView.h"
@class InstumentModel;
NS_ASSUME_NONNULL_BEGIN

@interface MarketDetailViewController : RDVTabBarController
@property(nonatomic,strong) InstumentModel *model;
@property(nonatomic,copy) NSString *exchangeId;
@property(nonatomic,assign) NSInteger selectIndex;
@end

NS_ASSUME_NONNULL_END
