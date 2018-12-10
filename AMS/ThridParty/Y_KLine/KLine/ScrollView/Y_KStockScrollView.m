//
//  YYStockScrollView.m
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/7.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import "Y_KStockScrollView.h"
#import "Y_StockChartGlobalVariable.h"
#import <Masonry/Masonry.h>
#import "UIColor+Y_StockChart.h"
@implementation Y_KStockScrollView


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
//    if (self.isShowBgLine) {
        [self drawBgLines];
//    }
}

- (void)drawBgLines {
//    if (self.stockType == Y_StockChartcenterViewTypeTimeLine) {
//        CGContextRef ctx = UIGraphicsGetCurrentContext();
//        CGContextSetStrokeColorWithColor(ctx, [UIColor bgLineColor].CGColor);
//        CGContextSetLineWidth(ctx, 0.5);
//        CGFloat unitWidth = (self.frame.size.width - 20*2)/4;
//
//        const CGPoint line1[] = {CGPointMake(20, Y_StockChartKLineMainViewMinY),CGPointMake(20, self.frame.size.height - 20)};
//        const CGPoint line2[] = {CGPointMake(20+unitWidth, Y_StockChartKLineMainViewMinY),CGPointMake(20+unitWidth, self.frame.size.height - 20)};
//        //        const CGPoint line3[] = {CGPointMake(0, unitWidth*2),CGPointMake(self.contentSize.width, unitWidth*2)};
//        //        const CGPoint line4[] = {CGPointMake(0, unitWidth*3),CGPointMake(self.contentSize.width, unitWidth*3)};
//        //        const CGPoint line5[] = {CGPointMake(0, unitWidth*4),CGPointMake(self.contentSize.width, unitWidth*4)};
//
//
//        CGContextStrokeLineSegments(ctx, line1, 2);
//        CGContextStrokeLineSegments(ctx, line2, 2);
//        CGContextStrokePath(ctx);
//    }
    
    if (self.stockType == Y_StockChartcenterViewTypeKline) {
        //单纯的画了一下背景线
//        CGContextRef ctx = UIGraphicsGetCurrentContext();
//        CGContextSetStrokeColorWithColor(ctx, [UIColor bgLineColor].CGColor);
//        CGContextSetLineWidth(ctx, 0.5);
//        CGFloat unitWidth = (self.frame.size.width - 20*2)/4;
//
//        const CGPoint line1[] = {CGPointMake(20, Y_StockChartKLineMainViewMinY),CGPointMake(20, self.frame.size.height - 20)};
//        const CGPoint line2[] = {CGPointMake(20+unitWidth, Y_StockChartKLineMainViewMinY),CGPointMake(20+unitWidth, self.frame.size.height - 20)};
//        const CGPoint line3[] = {CGPointMake(0, unitWidth*2),CGPointMake(self.contentSize.width, unitWidth*2)};
//        const CGPoint line4[] = {CGPointMake(0, unitWidth*3),CGPointMake(self.contentSize.width, unitWidth*3)};
//        const CGPoint line5[] = {CGPointMake(0, unitWidth*4),CGPointMake(self.contentSize.width, unitWidth*4)};
       
        
//        CGContextStrokeLineSegments(ctx, line1, 2);
//        CGContextStrokeLineSegments(ctx, line2, 2);
//        CGContextStrokePath(ctx);
//        CGContextStrokeLineSegments(ctx, line3, 2);
//        CGContextStrokeLineSegments(ctx, line4, 2);
//        CGContextStrokeLineSegments(ctx, line5, 2);

    }
}



@end
