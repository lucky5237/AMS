//
//  UIColor+Y_StockChart.h
//  BTC-Kline
//
//  Created by yate1996 on 16/4/30.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Y_StockChart)

/**
 *  根据十六进制转换成UIColor
 *
 *  @param hex UIColor的十六进制
 *
 *  @return 转换后的结果
 */
+(UIColor *)colorWithRGBHex:(UInt32)hex;


/**
 *  所有图表的背景颜色
 */
+(UIColor *)backgroundColor;

/**
 *  辅助背景色
 */
+(UIColor *)assistBackgroundColor;

/**
 *  涨的颜色
 */
+(UIColor *)increaseColor;


/**
 *  跌的颜色
 */
+(UIColor *)decreaseColor;

/**
 *  主文字颜色
 */
+(UIColor *)mainTextColor;

/**
 *  辅助文字颜色
 */
+(UIColor *)assistTextColor;

/**
 *  分时线下面的成交量线的颜色
 */
+(UIColor *)timeLineVolumeLineColor;

/**
 *  分时线界面线的颜色
 */
+(UIColor *)timeLineLineColor;

/**
 *  长按时线的颜色
 */
+(UIColor *)longPressLineColor;

/**
 *  ma7的颜色
 */
+(UIColor *)ma7Color;

/**
 *  ma5的颜色
 */
+(UIColor *)ma5Color;

/**
 *  ma10的颜色
 */
+(UIColor *)ma10Color;

/**
 *  ma20的颜色
 */
+(UIColor *)ma20Color;

/**
 *  ma40的颜色
 */
+(UIColor *)ma40Color;

/**
 *  ma60的颜色
 */
+(UIColor *)ma60Color;

/**
 *  ma30颜色
 */
+(UIColor *)ma30Color;

/**
 *  BOLL_MB颜色
 */
+(UIColor *)BOLL_MBColor;

/**
 *  BOLL_UP颜色
 */
+(UIColor *)BOLL_UPColor;

/**
 *  BOLL_DN颜色
 */
+(UIColor *)BOLL_DNColor;

/**
 *  背景线颜色
 */
+(UIColor *)bgLineColor;

@end
