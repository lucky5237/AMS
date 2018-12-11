//
//  Y_StockChartRightYView.h
//  BTC-Kline
//
//  Created by yate1996 on 16/5/3.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Y_StockChartGlobalVariable.h"
//#import "AMSConstant.h"

@interface Y_StockChartRightYView : UIView
@property(nonatomic,assign) CGFloat maxValue;

@property(nonatomic,assign) CGFloat middleValue;

@property(nonatomic,assign) CGFloat minValue;

@property(nonatomic,copy) NSString *minLabelText;

@property(nonatomic,assign) Y_StockChartCenterViewType type;
@property(nonatomic,assign) ChartType chartType;
@property(nonatomic,assign) BOOL isRisePer;
@end
