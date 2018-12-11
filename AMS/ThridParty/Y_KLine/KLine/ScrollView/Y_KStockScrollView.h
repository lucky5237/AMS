//
//  YYStockScrollView.h
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/7.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Y_StockChartGlobalVariable.h"
@interface Y_KStockScrollView : UIScrollView


@property (nonatomic, assign) Y_StockChartCenterViewType stockType;
@property (nonatomic, assign) Y_StockChartTargetLineStatus targetLineStatus;
@property (nonatomic, assign) BOOL isShowBgLine;
@end
