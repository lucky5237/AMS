//
//  OrderPriceSettingViewController.h
//  AMS
//
//  Created by jianlu on 2018/11/14.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderPriceSettingViewController : BaseTableViewController
@property(nonatomic,assign) OrderPlaceSettingType type;
@property(nonatomic,copy) NSString *navTitle;
@end

NS_ASSUME_NONNULL_END
