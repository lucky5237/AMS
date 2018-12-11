//
//  Y_KLineAccessoryView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/5/3.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_KLineAccessoryView.h"
#import "Y_KLineModel.h"

#import "UIColor+Y_StockChart.h"
#import "Y_KLineAccessory.h"
#import "Y_KLineVolumePositionModel.h"
#import "Y_KLinePositionModel.h"
#import "Y_MALine.h"
@interface Y_KLineAccessoryView()

/**
 *  需要绘制的Volume_MACD位置模型数组
 */
@property (nonatomic, strong) NSArray *needDrawKLineAccessoryPositionModels;

/**
 *  Volume_DIF位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_DIFPositions;

/**
 *  Volume_DEA位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_DEAPositions;

/**
 *  KDJ_K位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_KDJ_KPositions;

/**
 *  KDJ_D位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_KDJ_DPositions;

/**
 *  KDJ_J位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_KDJ_JPositions;

@property (nonatomic, assign) CGFloat unitValue;

@property (nonatomic, assign) CGFloat maxAssert;
@property (nonatomic, assign) CGFloat minAssert;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat minY;
@property (nonatomic, assign) CGFloat zeroY;


@end

@implementation Y_KLineAccessoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor backgroundColor];
        self.Accessory_DIFPositions = @[].mutableCopy;
        self.Accessory_DEAPositions = @[].mutableCopy;
        self.Accessory_KDJ_KPositions = @[].mutableCopy;
        self.Accessory_KDJ_DPositions = @[].mutableCopy;
        self.Accessory_KDJ_JPositions = @[].mutableCopy;

    }
    return self;
}

#pragma mark drawRect方法
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if(!self.needDrawKLineAccessoryPositionModels)
    {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, klineBgLineRedColor.CGColor);
    CGContextSetLineWidth(context, 0.5);
    UIScrollView *scrollView = (UIScrollView *)self.superview;
    const CGPoint line1[] = {CGPointMake(0, Y_StockChartKLineAccessoryViewMinY),CGPointMake(scrollView.contentSize.width, Y_StockChartKLineAccessoryViewMinY)};
    const CGPoint line2[] = {CGPointMake(0, Y_StockChartKLineAccessoryViewMaxY),CGPointMake(scrollView.contentSize.width, Y_StockChartKLineAccessoryViewMaxY)};
  
    CGFloat lengths[] = {1,1};
    CGContextSaveGState(context);
    CGContextSetLineDash(context,0,lengths,2);
    CGContextStrokeLineSegments(context, line1, 2);
    CGContextStrokeLineSegments(context, line2, 2);
    CGContextRestoreGState(context);
    
    
    /**
     *  副图，需要区分是MACD线还是KDJ线，进而选择不同的数据源和绘制方法
     */
    if(self.targetLineStatus != Y_StockChartTargetLineStatusKDJ)
    {
        /**
         MACD
         */
        Y_KLineAccessory *kLineAccessory = [[Y_KLineAccessory alloc]initWithContext:context];
        [self.needDrawKLineAccessoryPositionModels enumerateObjectsUsingBlock:^(Y_KLineVolumePositionModel * _Nonnull volumePositionModel, NSUInteger idx, BOOL * _Nonnull stop) {
            kLineAccessory.positionModel = volumePositionModel;
            kLineAccessory.kLineModel = self.needDrawKLineModels[idx];
            kLineAccessory.lineColor = self.kLineColors[idx];
            [kLineAccessory draw];
        }];
        
        Y_MALine *MALine = [[Y_MALine alloc]initWithContext:context];
        
        //画DIF线
        MALine.MAType = Y_MA5Type;
        MALine.MAPositions = self.Accessory_DIFPositions;
        [MALine draw];
        
        //画DEA线
        MALine.MAType = Y_MA20Type;
        MALine.MAPositions = self.Accessory_DEAPositions;
        [MALine draw];
        
//        const CGPoint line3[] = {CGPointMake(0, self.zeroY),CGPointMake(scrollView.contentSize.width, self.zeroY)};
//         CGContextStrokeLineSegments(context, line3, 2);
        NSDictionary *style = @{NSFontAttributeName:kFontSize(11),NSForegroundColorAttributeName:klineBgLineRedColor};
        CGPoint zeroPoint = CGPointMake(0,self.zeroY - [AMSUtil rectOfNSString:@"0.00" attribute:style].size.height);
        [@"0.00" drawAtPoint:zeroPoint withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11],NSForegroundColorAttributeName : klineBgLineRedColor}];
    } else {
        /**
        KDJ
         */
        Y_MALine *MALine = [[Y_MALine alloc]initWithContext:context];
        
        //画KDJ_K线
        MALine.MAType = Y_MA5Type;
        MALine.MAPositions = self.Accessory_KDJ_KPositions;
        [MALine draw];
        
        //画KDJ_D线
        MALine.MAType = Y_MA20Type;
        MALine.MAPositions = self.Accessory_KDJ_DPositions;
        [MALine draw];
        
        //画KDJ_J线
        MALine.MAType = -1;
        MALine.MAPositions = self.Accessory_KDJ_JPositions;
        [MALine draw];
    }
    
}

#pragma mark - 公有方法
#pragma mark 绘制volume方法
- (void)draw
{
    NSInteger kLineModelcount = self.needDrawKLineModels.count;
    NSInteger kLinePositionModelCount = self.needDrawKLinePositionModels.count;
    NSInteger kLineColorCount = self.kLineColors.count;
    NSAssert(self.needDrawKLineModels && self.needDrawKLinePositionModels && self.kLineColors && kLineColorCount == kLineModelcount && kLinePositionModelCount == kLineModelcount, @"数据异常，无法绘制Volume");
    self.needDrawKLineAccessoryPositionModels = [self private_convertToKLinePositionModelWithKLineModels:self.needDrawKLineModels];
    [self setNeedsDisplay];
}

#pragma mark - 私有方法
#pragma mark 根据KLineModel转换成Position数组
- (NSArray *)private_convertToKLinePositionModelWithKLineModels:(NSArray *)kLineModels
{
    CGFloat minY = Y_StockChartKLineAccessoryViewMinY;
    CGFloat maxY = Y_StockChartKLineAccessoryViewMaxY;
    
    __block CGFloat minValue = CGFLOAT_MAX;
    __block CGFloat maxValue = CGFLOAT_MIN;
    
    NSMutableArray *volumePositionModels = @[].mutableCopy;

    if(self.targetLineStatus != Y_StockChartTargetLineStatusAccessoryClose && self.targetLineStatus != Y_StockChartTargetLineStatusKDJ)
    {
        [kLineModels enumerateObjectsUsingBlock:^(Y_KLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if(model.DIF)
            {
                if(model.DIF.floatValue < minValue) {
                    minValue = model.DIF.floatValue;
                }
                if(model.DIF.floatValue > maxValue) {
                    maxValue = model.DIF.floatValue;
                }
            }
            
            if(model.DEA)
            {
                if (minValue > model.DEA.floatValue) {
                    minValue = model.DEA.floatValue;
                }
                if (maxValue < model.DEA.floatValue) {
                    maxValue = model.DEA.floatValue;
                }
            }
            if(model.MACD)
            {
                if (minValue > model.MACD.floatValue) {
                    minValue = model.MACD.floatValue;
                }
                if (maxValue < model.MACD.floatValue) {
                    maxValue = model.MACD.floatValue;
                }
            }
        }];
        
        self.maxAssert = maxValue;
        self.minAssert = minValue;
        
        CGFloat unitValue = (maxValue - minValue) / (maxY - minY);
        if (unitValue == 0.f) {
            unitValue = 0.01f;
        }
        self.unitValue = unitValue;
        self.zeroY = Y_StockChartKLineAccessoryViewMiddleY;
        
        [self.Accessory_DIFPositions removeAllObjects];
        [self.Accessory_DEAPositions removeAllObjects];
        
        [kLineModels enumerateObjectsUsingBlock:^(Y_KLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            Y_KLinePositionModel *kLinePositionModel = self.needDrawKLinePositionModels[idx];
            CGFloat xPosition = kLinePositionModel.HighPoint.x;
            
            
            
            CGFloat yPosition = -(model.MACD.floatValue - 0)/unitValue + Y_StockChartKLineAccessoryViewMiddleY;
            
//            CGFloat yPosition = ABS(minY + (model.MACD.floatValue - minValue)/unitValue);
            
            CGPoint startPoint = CGPointMake(xPosition, yPosition);
            
            CGPoint endPoint = CGPointMake(xPosition,Y_StockChartKLineAccessoryViewMiddleY);
            Y_KLineVolumePositionModel *volumePositionModel = [Y_KLineVolumePositionModel modelWithStartPoint:startPoint endPoint:endPoint];
            [volumePositionModels addObject:volumePositionModel];
            
            //MA坐标转换
            CGFloat DIFY = maxY;
            CGFloat DEAY = maxY;
            if(unitValue > 0.0000001)
            {
                if(model.DIF)
                {
                    DIFY = -(model.DIF.floatValue - 0)/unitValue + Y_StockChartKLineAccessoryViewMiddleY;
//                    DIFY = maxY - (model.DIF.floatValue - minValue)/unitValue;
                }
                
            }
            if(unitValue > 0.0000001)
            {
                if(model.DEA)
                {
                    DEAY = -(model.DEA.floatValue - 0)/unitValue + Y_StockChartKLineAccessoryViewMiddleY;
//                    DEAY = maxY - (model.DEA.floatValue - minValue)/unitValue;

                }
            }
            
            NSAssert(!isnan(DIFY) && !isnan(DEAY), @"出现NAN值");
            
            CGPoint DIFPoint = CGPointMake(xPosition, DIFY);
            CGPoint DEAPoint = CGPointMake(xPosition, DEAY);
            
            if(model.DIF)
            {
                [self.Accessory_DIFPositions addObject: [NSValue valueWithCGPoint: DIFPoint]];
            }
            if(model.DEA)
            {
                [self.Accessory_DEAPositions addObject: [NSValue valueWithCGPoint: DEAPoint]];
            }
        }];
    } else {
        [kLineModels enumerateObjectsUsingBlock:^(Y_KLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if(model.KDJ_K)
            {
                if (minValue > model.KDJ_K.floatValue) {
                    minValue = model.KDJ_K.floatValue;
                }
                if (maxValue < model.KDJ_K.floatValue) {
                    maxValue = model.KDJ_K.floatValue;
                }
            }
            
            if(model.KDJ_D)
            {
                if (minValue > model.KDJ_D.floatValue) {
                    minValue = model.KDJ_D.floatValue;
                }
                if (maxValue < model.KDJ_D.floatValue) {
                    maxValue = model.KDJ_D.floatValue;
                }
            }
            if(model.KDJ_J)
            {
                if (minValue > model.KDJ_J.floatValue) {
                    minValue = model.KDJ_J.floatValue;
                }
                if (maxValue < model.KDJ_J.floatValue) {
                    maxValue = model.KDJ_J.floatValue;
                }
            }
        }];
        
        CGFloat unitValue = (maxValue - minValue) / (maxY - minY);
        
        [self.Accessory_KDJ_KPositions removeAllObjects];
        [self.Accessory_KDJ_DPositions removeAllObjects];
        [self.Accessory_KDJ_JPositions removeAllObjects];
        
        [kLineModels enumerateObjectsUsingBlock:^(Y_KLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            Y_KLinePositionModel *kLinePositionModel = self.needDrawKLinePositionModels[idx];
            CGFloat xPosition = kLinePositionModel.HighPoint.x;
            
            //MA坐标转换
            CGFloat KDJ_K_Y = maxY;
            CGFloat KDJ_D_Y = maxY;
            CGFloat KDJ_J_Y = maxY;
            if(unitValue > 0.0000001)
            {
                if(model.KDJ_K)
                {
                    KDJ_K_Y = maxY - (model.KDJ_K.floatValue - minValue)/unitValue;
                }
                
            }
            if(unitValue > 0.0000001)
            {
                if(model.KDJ_D)
                {
                    KDJ_D_Y = maxY - (model.KDJ_D.floatValue - minValue)/unitValue;
                }
            }
            if(unitValue > 0.0000001)
            {
                if(model.KDJ_J)
                {
                    KDJ_J_Y = maxY - (model.KDJ_J.floatValue - minValue)/unitValue;
                }
            }
            
            NSAssert(!isnan(KDJ_K_Y) && !isnan(KDJ_D_Y) && !isnan(KDJ_J_Y), @"出现NAN值");
            
            CGPoint KDJ_KPoint = CGPointMake(xPosition, KDJ_K_Y);
            CGPoint KDJ_DPoint = CGPointMake(xPosition, KDJ_D_Y);
            CGPoint KDJ_JPoint = CGPointMake(xPosition, KDJ_J_Y);

            
            if(model.KDJ_K)
            {
                [self.Accessory_KDJ_KPositions addObject: [NSValue valueWithCGPoint: KDJ_KPoint]];
            }
            if(model.KDJ_D)
            {
                [self.Accessory_KDJ_DPositions addObject: [NSValue valueWithCGPoint: KDJ_DPoint]];
            }
            if(model.KDJ_J)
            {
                [self.Accessory_KDJ_JPositions addObject: [NSValue valueWithCGPoint: KDJ_JPoint]];
            }
        }];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(kLineAccessoryViewCurrentMaxValue:minValue:)])
    {
        [self.delegate kLineAccessoryViewCurrentMaxValue:maxValue minValue:minValue];
    }
    return volumePositionModels;
}

-(CGFloat) getYValue:(CGFloat)yPosition{
    if (yPosition<= CGRectGetMaxY(self.frame) -Y_StockChartKLineAccessoryViewMinY && yPosition >= CGRectGetMinY(self.frame) + Y_StockChartKLineAccessoryViewMinY) {
        return self.maxAssert - (yPosition - CGRectGetMinY(self.frame) - Y_StockChartKLineAccessoryViewMinY) * self.unitValue;
    }
    return .0f;
}
@end
