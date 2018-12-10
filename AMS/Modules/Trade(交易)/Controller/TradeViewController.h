//
//  TradeViewController.h
//  AMS
//
//  Created by jianlu on 2018/11/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "BaseViewController.h"
@class MarketModel;
NS_ASSUME_NONNULL_BEGIN

@interface TradeViewController : BaseViewController
@property(nonatomic,strong) MarketModel *model;
@end

NS_ASSUME_NONNULL_END
