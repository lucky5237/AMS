//
//  TimeChartViewController.h
//  AMS
//  分时图
//  Created by jianlu on 2018/11/20.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class InstumentModel;
@interface TimeChartViewController : BaseViewController
@property(nonatomic,strong) InstumentModel *model;
@end

NS_ASSUME_NONNULL_END
