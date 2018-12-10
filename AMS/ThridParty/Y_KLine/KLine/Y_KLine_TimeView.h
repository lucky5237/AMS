//
//  Y_KLine_TimeView.h
//  AMS
//
//  Created by jianlu on 2018/11/28.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Y_StockChartConstant.h"

NS_ASSUME_NONNULL_BEGIN
@class Y_KLineModel;

@interface Y_KLine_TimeView : UIView
/**
 * 需要绘制的K线模型数组
 */
@property (nonatomic, strong) NSArray *needDrawKLineModels;

/**
 * 需要绘制的K线位置数组
 */
@property (nonatomic, strong) NSArray *needDrawKLinePositionModels;
@property(nonatomic,assign) Y_StockChartCenterViewType type;

-(void)draw;
@end

NS_ASSUME_NONNULL_END
