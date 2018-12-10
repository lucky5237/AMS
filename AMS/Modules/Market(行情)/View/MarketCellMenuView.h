//
//  MarketCellMenuView.h
//  AMS
//
//  Created by jianlu on 2018/11/14.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarketCellMenuView : UIView

@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIButton *goTradeBtn;
@property(nonatomic,assign) BOOL isShow;
@end

NS_ASSUME_NONNULL_END
