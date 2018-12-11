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
    if (self.stockType == Y_StockChartcenterViewTypeTimeLine) {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(ctx, [UIColor bgLineColor].CGColor);
        CGContextSetLineWidth(ctx, 0.5);
        CGFloat unitWidth = self.frame.size.width/4;
        
        const CGPoint line1[] = {CGPointMake(0, Y_StockChartKLineMainViewMinY),CGPointMake(0, self.frame.size.height - 20)};
        const CGPoint line2[] = {CGPointMake(unitWidth, Y_StockChartKLineMainViewMinY),CGPointMake(unitWidth, self.frame.size.height - 20)};
        const CGPoint line3[] = {CGPointMake(unitWidth *2, Y_StockChartKLineMainViewMinY),CGPointMake(unitWidth*2, self.frame.size.height - 20)};
        const CGPoint line4[] = {CGPointMake(unitWidth *3, Y_StockChartKLineMainViewMinY),CGPointMake(unitWidth*3, self.frame.size.height - 20)};
        const CGPoint line5[] = {CGPointMake(unitWidth *4, Y_StockChartKLineMainViewMinY),CGPointMake(unitWidth*4, self.frame.size.height - 20)};
        CGFloat lengths[] = {1,1};
        CGContextSaveGState(ctx);
        CGContextSetLineDash(ctx,0,lengths,2);
        CGContextStrokeLineSegments(ctx, line1, 2);
        CGContextStrokeLineSegments(ctx, line2, 2);
        CGContextStrokeLineSegments(ctx, line3, 2);
        CGContextStrokeLineSegments(ctx, line4, 2);
        CGContextStrokeLineSegments(ctx, line5, 2);
        CGContextStrokePath(ctx);
        CGContextRestoreGState(ctx);

    }
    
    if (self.stockType == Y_StockChartcenterViewTypeKline) {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(ctx, [UIColor bgLineColor].CGColor);
        CGContextSetLineWidth(ctx, 0.5);
        CGFloat unitWidth = self.frame.size.width/4;
        CGFloat offset = self.targetLineStatus== Y_StockChartTargetLineStatusMACD ? 0 :25;
        const CGPoint line1[] = {CGPointMake(self.contentOffset.x, Y_StockChartKLineMainViewMinY+ offset),CGPointMake(self.contentOffset.x, self.frame.size.height - 20)};
        const CGPoint line2[] = {CGPointMake(self.contentOffset.x+unitWidth, Y_StockChartKLineMainViewMinY+ offset),CGPointMake(self.contentOffset.x+unitWidth, self.frame.size.height - 20)};
        const CGPoint line3[] = {CGPointMake(self.contentOffset.x+unitWidth *2, Y_StockChartKLineMainViewMinY+ offset),CGPointMake(self.contentOffset.x+unitWidth*2, self.frame.size.height - 20)};
        const CGPoint line4[] = {CGPointMake(self.contentOffset.x+unitWidth *3, Y_StockChartKLineMainViewMinY+ offset),CGPointMake(self.contentOffset.x+unitWidth*3, self.frame.size.height - 20)};
        const CGPoint line5[] = {CGPointMake(self.contentOffset.x+unitWidth *4, Y_StockChartKLineMainViewMinY+ offset),CGPointMake(self.contentOffset.x+unitWidth*4, self.frame.size.height - 20)};
        CGFloat lengths[] = {1,1};
        CGContextSaveGState(ctx);
        CGContextSetLineDash(ctx,0,lengths,2);
        CGContextStrokeLineSegments(ctx, line1, 2);
        CGContextStrokeLineSegments(ctx, line2, 2);
        CGContextStrokeLineSegments(ctx, line3, 2);
        CGContextStrokeLineSegments(ctx, line4, 2);
        CGContextStrokeLineSegments(ctx, line5, 2);
        CGContextStrokePath(ctx);
        CGContextRestoreGState(ctx);
        
    }
}



@end
