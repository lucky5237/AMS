//
//  Y_KLineView.h
//  BTC-Kline
//
//  Created by yate1996 on 16/4/30.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Y_KLineModel.h"
#import "Y_StockChartConstant.h"
#import "Y_KLineMainView.h"
#import "Y_KLineVolumeView.h"
#import "Y_KLineAccessoryView.h"
#import "Y_KStockScrollView.h"
@protocol Y_KlineEventDelegete<NSObject>
@optional
-(void)y_KlineViewDidtapEvent:(Y_KlineViewType)type;
-(void)y_klineDidReachEdges:(CGPoint)location data:(Y_KLineModel*)model realX:(CGFloat)x;
-(void)y_klineDidPanEvent:(CGPoint)location data:(Y_KLineModel*)model;
@end

@interface Y_KLineView : UIView

/**
 *  主K线图
 */
@property (nonatomic, strong) Y_KLineMainView *kLineMainView;

/**
 *  成交量图
 */
@property (nonatomic, strong) Y_KLineVolumeView *kLineVolumeView;

/**
 *  副图
 */
@property (nonatomic, strong) Y_KLineAccessoryView *kLineAccessoryView;

/**
 *  第一个View的高所占比例
 */
@property (nonatomic, assign) CGFloat mainViewRatio;

/**
 *  第二个View(成交量)的高所占比例
 */
@property (nonatomic, assign) CGFloat volumeViewRatio;

/**
 *  数据
 */
@property(nonatomic, copy) NSArray<Y_KLineModel *> *kLineModels;

/**
 *  重绘
 */
- (void)reDraw;


/**
 *  K线类型
 */
@property (nonatomic, assign) Y_StockChartCenterViewType MainViewType;

/**
 *  Accessory指标种类
 */
@property (nonatomic, assign) Y_StockChartTargetLineStatus targetLineStatus;

//事件delegate
@property(nonatomic,weak) id<Y_KlineEventDelegete> delegate;

@property (nonatomic, strong) Y_KStockScrollView *scrollView;
//上一日收盘价
@property (nonatomic,strong) NSNumber *lastDayClosepPrice;
@end
