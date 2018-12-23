//
//  TradeViewController.h
//  AMS
//
//  Created by jianlu on 2018/11/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "BaseViewController.h"
@class InstumentModel;
NS_ASSUME_NONNULL_BEGIN

@interface TradeViewController : BaseViewController
@property(nonatomic,strong) InstumentModel *model;
@end

NS_ASSUME_NONNULL_END
