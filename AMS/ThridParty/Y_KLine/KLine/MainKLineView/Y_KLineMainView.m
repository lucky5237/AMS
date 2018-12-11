//
//  Y_KLineMainView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/30.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_KLineMainView.h"
#import "UIColor+Y_StockChart.h"

#import "Y_KLine.h"
#import "Y_MALine.h"
#import "Y_KLinePositionModel.h"
#import "Y_StockChartGlobalVariable.h"
#import "Masonry.h"
@interface Y_KLineMainView()

/**
 *  需要绘制的model数组
 */
@property (nonatomic, strong) NSMutableArray <Y_KLineModel *> *needDrawKLineModels;

/**
 *  需要绘制的model位置数组
 */
@property (nonatomic, strong) NSMutableArray *needDrawKLinePositionModels;

/**
 *  Index开始X的值
 */
@property (nonatomic, assign) NSInteger startXPosition;

/**
 *  旧的contentoffset值
 */
@property (nonatomic, assign) CGFloat oldContentOffsetX;

/**
 *  旧的缩放值
 */
@property (nonatomic, assign) CGFloat oldScale;

@property (nonatomic, strong) NSMutableArray *MA5Positions;
@property (nonatomic, strong) NSMutableArray *MA10Positions;
@property (nonatomic, strong) NSMutableArray *MA20Positions;
@property (nonatomic, strong) NSMutableArray *MA40Positions;
@property (nonatomic, strong) NSMutableArray *MA60Positions;
@property (nonatomic, strong) NSMutableArray *AVERAGEPositions;
/**
 *  MA7位置数组
 */
@property (nonatomic, strong) NSMutableArray *MA7Positions;

/**
 *  MA30位置数组
 */
@property (nonatomic, strong) NSMutableArray *MA30Positions;

/**
 *  BOLL_MB位置数组
 */
@property (nonatomic, strong) NSMutableArray *BOLL_MBPositions;

/**
 *  BOLL_UP位置数组
 */
@property (nonatomic, strong) NSMutableArray *BOLL_UPPositions;

/**
 *  BOLL_DN位置数组
 */
@property (nonatomic, strong) NSMutableArray *BOLL_DNPositions;

@property (nonatomic, assign) CGFloat unitValue;

@property (nonatomic, assign) CGFloat maxAssert;
@property (nonatomic, assign) CGFloat minAssert;


@end

@implementation Y_KLineMainView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.needDrawKLineModels = @[].mutableCopy;
        self.needDrawKLinePositionModels = @[].mutableCopy;
        self.MA5Positions = @[].mutableCopy;
        self.MA10Positions = @[].mutableCopy;
        self.MA20Positions = @[].mutableCopy;
        self.MA40Positions = @[].mutableCopy;
        self.MA60Positions = @[].mutableCopy;
        self.BOLL_UPPositions = @[].mutableCopy;
        self.BOLL_DNPositions = @[].mutableCopy;
        self.BOLL_MBPositions = @[].mutableCopy;
        self.AVERAGEPositions = @[].mutableCopy;
        
        self.needDrawStartIndex = 0;
        self.oldContentOffsetX = 0;
        self.oldScale = 0;
    }
    return self;
}

#pragma mark - 绘图相关方法

#pragma mark drawRect方法
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
        [self.parentScrollView layoutIfNeeded];
        [self.parentScrollView setNeedsDisplay];
    }
    //如果数组为空，则不进行绘制，直接设置本view为背景
    CGContextRef context = UIGraphicsGetCurrentContext();
    if(!self.kLineModels)
    {
        CGContextClearRect(context, rect);
        CGContextSetFillColorWithColor(context, [UIColor backgroundColor].CGColor);
        CGContextFillRect(context, rect);
        return;
    }
    
    //设置View的背景颜色
    NSMutableArray *kLineColors = @[].mutableCopy;
    //    CGContextClearRect(context, rect);
    //    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    //    CGContextFillRect(context, rect);
    
    
    if (self.MainViewType == Y_StockChartcenterViewTypeTimeLine) {
        //        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, klineBgLineRedColor.CGColor);
        CGContextSetLineWidth(context, 0.5);
        CGFloat unitHeight = (Y_StockChartKLineMainViewMaxY - Y_StockChartKLineMainViewMinY) / 6;
        
        const CGPoint line1[] = {CGPointMake(0, Y_StockChartKLineMainViewMinY),CGPointMake(self.parentScrollView.contentSize.width, Y_StockChartKLineMainViewMinY)};
        const CGPoint line2[] = {CGPointMake(0, Y_StockChartKLineMainViewMinY+unitHeight),CGPointMake(self.parentScrollView.contentSize.width, Y_StockChartKLineMainViewMinY+unitHeight)};
        const CGPoint line3[] = {CGPointMake(0,Y_StockChartKLineMainViewMinY+ unitHeight*2),CGPointMake(self.parentScrollView.contentSize.width, Y_StockChartKLineMainViewMinY+unitHeight*2)};
        const CGPoint line4[] = {CGPointMake(0, Y_StockChartKLineMainViewMinY+unitHeight*3),CGPointMake(self.parentScrollView.contentSize.width, Y_StockChartKLineMainViewMinY+unitHeight*3)};
        const CGPoint line5[] = {CGPointMake(0, Y_StockChartKLineMainViewMinY+unitHeight*4),CGPointMake(self.parentScrollView.contentSize.width, Y_StockChartKLineMainViewMinY+unitHeight*4)};
        const CGPoint line6[] = {CGPointMake(0, Y_StockChartKLineMainViewMinY+unitHeight*5),CGPointMake(self.parentScrollView.contentSize.width, Y_StockChartKLineMainViewMinY+unitHeight*5)};
        
        const CGPoint line7[] = {CGPointMake(0, Y_StockChartKLineMainViewMaxY),CGPointMake(self.parentScrollView.contentSize.width,Y_StockChartKLineMainViewMaxY)};
        
        CGFloat lengths[] = {1,1};
        CGContextStrokeLineSegments(context, line1, 2);
        CGContextSaveGState(context);
        CGContextSetLineDash(context,0,lengths,2);
        CGContextStrokeLineSegments(context, line2, 2);
        CGContextStrokeLineSegments(context, line3, 2);
        CGContextRestoreGState(context);
        CGContextStrokeLineSegments(context, line4, 2);
        CGContextSaveGState(context);
        CGContextSetLineDash(context,0,lengths,2);
        CGContextStrokeLineSegments(context, line5, 2);
        CGContextStrokeLineSegments(context, line6, 2);
        CGContextRestoreGState(context);
        CGContextStrokeLineSegments(context, line7, 2);

    }else{
        CGContextSetStrokeColorWithColor(context, klineBgLineRedColor.CGColor);
        CGContextSetLineWidth(context, 0.5);
        CGFloat unitHeight = (Y_StockChartKLineMainViewMaxY - Y_StockChartKLineMainViewMinY) / 2;
        const CGPoint lineTop[] = {CGPointMake(0, Y_StockChartKLineMainViewMinY),CGPointMake(self.parentScrollView.contentSize.width, Y_StockChartKLineMainViewMinY)};
        const CGPoint lineMiddle[] = {CGPointMake(0, Y_StockChartKLineMainViewMinY+unitHeight),CGPointMake(self.parentScrollView.contentSize.width, Y_StockChartKLineMainViewMinY+unitHeight)};
        const CGPoint lineBottom[] = {CGPointMake(0, Y_StockChartKLineMainViewMaxY),CGPointMake(self.parentScrollView.contentSize.width,Y_StockChartKLineMainViewMaxY)};
        CGFloat lengths[] = {1,1};
        CGContextSaveGState(context);
        CGContextSetLineDash(context,0,lengths,2);
        CGContextStrokeLineSegments(context, lineTop, 2);
        CGContextStrokeLineSegments(context, lineMiddle, 2);
        CGContextStrokeLineSegments(context, lineBottom, 2);
        CGContextRestoreGState(context);
    }
    
    
    Y_MALine *MALine = [[Y_MALine alloc]initWithContext:context];
    
    if(self.MainViewType == Y_StockChartcenterViewTypeKline)
    {
        Y_KLine *kLine = [[Y_KLine alloc]initWithContext:context];
        kLine.maxY = Y_StockChartKLineMainViewMaxY;
        
        [self.needDrawKLinePositionModels enumerateObjectsUsingBlock:^(Y_KLinePositionModel * _Nonnull kLinePositionModel, NSUInteger idx, BOOL * _Nonnull stop) {
            kLine.kLinePositionModel = kLinePositionModel;
            kLine.kLineModel = self.needDrawKLineModels[idx];
            UIColor *kLineColor = [kLine draw];
            [kLineColors addObject:kLineColor];
        }];
        
        if (self.targetLineStatus == Y_StockChartTargetLineStatusBOLL) {
            // 画BOLL MB线 标准线
            MALine.MAType = Y_BOLL_MB;
            MALine.BOLLPositions = self.BOLL_MBPositions;
            [MALine draw];
            
            // 画BOLL UP 上浮线
            MALine.MAType = Y_BOLL_UP;
            MALine.BOLLPositions = self.BOLL_UPPositions;
            [MALine draw];
            
            // 画BOLL DN下浮线
            MALine.MAType = Y_BOLL_DN;
            MALine.BOLLPositions = self.BOLL_DNPositions;
            [MALine draw];
            
        } else if ( self.targetLineStatus == Y_StockChartTargetLineStatusMA){
            
            //画MA5线
            MALine.MAType = Y_MA5Type;
            MALine.MAPositions = self.MA5Positions;
            [MALine draw];
            
            //画MA10线
            MALine.MAType = Y_MA10Type;
            MALine.MAPositions = self.MA10Positions;
            [MALine draw];
            
            //画MA20线
            MALine.MAType = Y_MA20Type;
            MALine.MAPositions = self.MA20Positions;
            [MALine draw];
            
            //画MA40线
            MALine.MAType = Y_MA40Type;
            MALine.MAPositions = self.MA40Positions;
            [MALine draw];
            
            //画MA60线
            MALine.MAType = Y_MA60Type;
            MALine.MAPositions = self.MA60Positions;
            [MALine draw];
            
        }
    } else {
        __block NSMutableArray *positions = @[].mutableCopy;
        [self.needDrawKLinePositionModels enumerateObjectsUsingBlock:^(Y_KLinePositionModel * _Nonnull positionModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UIColor *strokeColor = kWhiteColor;
            if (idx >= 1) {
                Y_KLineModel *preModel = self.needDrawKLineModels[idx - 1];
                Y_KLineModel *currentModel = self.needDrawKLineModels[idx];
                if (currentModel.price.floatValue > preModel.price.floatValue) {
                    strokeColor = [UIColor increaseColor];
                }else if (currentModel.price.floatValue < preModel.price.floatValue){
                    strokeColor = [UIColor decreaseColor];
                }
            }
            [kLineColors addObject:strokeColor];
            [positions addObject:[NSValue valueWithCGPoint:positionModel.pricePoint]];
        }];
        MALine.MAPositions = positions;
        MALine.MAType = -1;
        [MALine draw];
        
        MALine.AVERAGEPositions = self.AVERAGEPositions;
        MALine.MAType = Y_AVERAGET;
        [MALine draw];
        
    }
    
    
    if(self.delegate && kLineColors.count > 0)
    {
        if([self.delegate respondsToSelector:@selector(kLineMainViewCurrentNeedDrawKLineColors:)])
        {
            [self.delegate kLineMainViewCurrentNeedDrawKLineColors:kLineColors];
        }
    }
}

#pragma mark - 公有方法

#pragma mark 重新设置相关数据，然后重绘
- (void)drawMainView{
    NSAssert(self.kLineModels, @"kLineModels不能为空");
    //提取需要的kLineModel
    [self private_extractNeedDrawModels];
    //转换model为坐标model
    [self private_convertToKLinePositionModelWithKLineModels];
    
    //间接调用drawRect方法
    [self setNeedsDisplay];
}

/**
 *  更新MainView的宽度
 */
- (void)updateMainViewWidth{
    
    CGFloat kLineViewWidth = self.parentScrollView.bounds.size.width;
    if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
        //根据stockModels的个数和间隔和K线的宽度计算出self的宽度，并设置contentsize
        kLineViewWidth = self.kLineModels.count * [Y_StockChartGlobalVariable kLineWidth] + (self.kLineModels.count + 1) * [Y_StockChartGlobalVariable kLineGap];
        
        if(kLineViewWidth < self.parentScrollView.bounds.size.width) {
            kLineViewWidth = self.parentScrollView.bounds.size.width;
        }
        
        if (self.pinchStartIndex)
        {
            CGFloat new_x = self.pinchStartIndex * ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]) + [Y_StockChartGlobalVariable kLineGap];
            [self.parentScrollView setContentOffset:CGPointMake(new_x, 0) animated:NO];
        }
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.parentScrollView);
        make.left.equalTo(self.parentScrollView).offset(self.parentScrollView.contentOffset.x);
    }];
    
    
    [self layoutIfNeeded];
    
    //更新scrollview的contentsize
    self.parentScrollView.contentSize = CGSizeMake(kLineViewWidth, self.parentScrollView.contentSize.height);
    
}

/**
 *  长按的时候根据原始的x位置获得精确的x的位置
 */
- (CGFloat)getExactXPositionWithOriginXPosition:(CGPoint)originPosition{
    CGFloat xPositoinInMainView = originPosition.x - self.parentScrollView.contentOffset.x;
    NSInteger startIndex;
    if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
        startIndex= (NSInteger)((xPositoinInMainView - [self xPosition]) / ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]));
    }else{
        startIndex = 0;
    }
    NSInteger arrCount = self.needDrawKLinePositionModels.count;
    for (NSInteger index = startIndex > 0 ? startIndex - 1 : 0; index < arrCount; ++index) {
        Y_KLinePositionModel *kLinePositionModel = self.needDrawKLinePositionModels[index];
        CGFloat minX,maxX;
        if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
            minX = kLinePositionModel.HighPoint.x - ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]/2);
            maxX = kLinePositionModel.HighPoint.x + ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]/2);
        }else{
            minX = kLinePositionModel.HighPoint.x - (Y_StockTimeLineViewVolumeGap + [Y_StockChartGlobalVariable timeLineVolumeWidth]/2);
            maxX = kLinePositionModel.HighPoint.x + (Y_StockTimeLineViewVolumeGap + [Y_StockChartGlobalVariable timeLineVolumeWidth]/2);
        }
       
        
        if(xPositoinInMainView > minX && xPositoinInMainView < maxX)
        {
            if(self.delegate && [self.delegate respondsToSelector:@selector(kLineMainViewLongPressKLinePositionModel:kLineModel:originalPosition:)])
            {
                [self.delegate kLineMainViewLongPressKLinePositionModel:self.needDrawKLinePositionModels[index] kLineModel:self.needDrawKLineModels[index] originalPosition:originPosition];
            }
            return kLinePositionModel.HighPoint.x;
        }
        
    }
    return 0.f;
}

#pragma mark 私有方法
//提取需要绘制的数组
- (NSArray *)private_extractNeedDrawModels{
    
    if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
        CGFloat lineGap = [Y_StockChartGlobalVariable kLineGap];
        CGFloat lineWidth = [Y_StockChartGlobalVariable kLineWidth];
        
        //数组个数
        CGFloat scrollViewWidth = self.parentScrollView.frame.size.width;
        NSInteger needDrawKLineCount = (scrollViewWidth - lineGap)/(lineGap+lineWidth);
        
        //起始位置
        NSInteger needDrawKLineStartIndex ;
        
        if(self.pinchStartIndex > 0) {
            needDrawKLineStartIndex = self.pinchStartIndex;
            _needDrawStartIndex = self.pinchStartIndex;
            self.pinchStartIndex = -1;
        } else {
            needDrawKLineStartIndex = [self getNeedDrawStartIndexWithScroll:YES];
        }
        
        [self.needDrawKLineModels removeAllObjects];
        
        //赋值数组
        if(needDrawKLineStartIndex < self.kLineModels.count)
        {
            if(needDrawKLineStartIndex + needDrawKLineCount < self.kLineModels.count)
            {
                [self.needDrawKLineModels addObjectsFromArray:[self.kLineModels subarrayWithRange:NSMakeRange(needDrawKLineStartIndex, needDrawKLineCount)]];
            } else{
                [self.needDrawKLineModels addObjectsFromArray:[self.kLineModels subarrayWithRange:NSMakeRange(needDrawKLineStartIndex, self.kLineModels.count - needDrawKLineStartIndex)]];
            }
        }
    }else{
        [self.needDrawKLineModels removeAllObjects];
        [self.needDrawKLineModels addObjectsFromArray:self.kLineModels];
    }
    
    //响应代理
    if(self.delegate && [self.delegate respondsToSelector:@selector(kLineMainViewCurrentNeedDrawKLineModels:)])
    {
        [self.delegate kLineMainViewCurrentNeedDrawKLineModels:self.needDrawKLineModels];
    }
    return self.needDrawKLineModels;
}

#pragma mark 将model转化为Position模型
- (NSArray *)private_convertToKLinePositionModelWithKLineModels{
    if(!self.needDrawKLineModels)
    {
        return nil;
    }
    
    NSArray *kLineModels = self.needDrawKLineModels;
    
    //计算最小单位
    Y_KLineModel *firstModel = kLineModels.firstObject;
    __block CGFloat minAssert;
    __block CGFloat maxAssert;
    
    if (self.MainViewType == Y_StockChartcenterViewTypeTimeLine) {
        minAssert = firstModel.price.floatValue;
        maxAssert = firstModel.price.floatValue;
    }else{
        minAssert = firstModel.Low.floatValue;
        maxAssert = firstModel.High.floatValue;
    }
    
    [kLineModels enumerateObjectsUsingBlock:^(Y_KLineModel * _Nonnull kLineModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
            if(kLineModel.High.floatValue > maxAssert)
            {
                maxAssert = kLineModel.High.floatValue;
            }
            if(kLineModel.Low.floatValue < minAssert)
            {
                minAssert = kLineModel.Low.floatValue;
            }
            
            if (self.targetLineStatus == Y_StockChartTargetLineStatusBOLL) {
                
                if(kLineModel.BOLL_MB)
                {
                    if (minAssert > kLineModel.BOLL_MB.floatValue) {
                        minAssert = kLineModel.BOLL_MB.floatValue;
                    }
                    if (maxAssert < kLineModel.BOLL_MB.floatValue) {
                        maxAssert = kLineModel.BOLL_MB.floatValue;
                    }
                }
                if(kLineModel.BOLL_UP)
                {
                    if (minAssert > kLineModel.BOLL_UP.floatValue) {
                        minAssert = kLineModel.BOLL_UP.floatValue;
                    }
                    if (maxAssert < kLineModel.BOLL_UP.floatValue) {
                        maxAssert = kLineModel.BOLL_UP.floatValue;
                    }
                }
                
                if(kLineModel.BOLL_DN)
                {
                    if (minAssert > kLineModel.BOLL_DN.floatValue) {
                        minAssert = kLineModel.BOLL_DN.floatValue;
                    }
                    if (maxAssert < kLineModel.BOLL_DN.floatValue) {
                        maxAssert = kLineModel.BOLL_DN.floatValue;
                    }
                }
                
            } else if(self.targetLineStatus == Y_StockChartTargetLineStatusMA){
                
                if(kLineModel.MA5)
                {
                    if (minAssert > kLineModel.MA5.floatValue) {
                        minAssert = kLineModel.MA5.floatValue;
                    }
                    if (maxAssert < kLineModel.MA5.floatValue) {
                        maxAssert = kLineModel.MA5.floatValue;
                    }
                }
                if(kLineModel.MA10)
                {
                    if (minAssert > kLineModel.MA10.floatValue) {
                        minAssert = kLineModel.MA10.floatValue;
                    }
                    if (maxAssert < kLineModel.MA10.floatValue) {
                        maxAssert = kLineModel.MA10.floatValue;
                    }
                }
                if(kLineModel.MA20)
                {
                    if (minAssert > kLineModel.MA20.floatValue) {
                        minAssert = kLineModel.MA20.floatValue;
                    }
                    if (maxAssert < kLineModel.MA20.floatValue) {
                        maxAssert = kLineModel.MA20.floatValue;
                    }
                }
                if(kLineModel.MA40)
                {
                    if (minAssert > kLineModel.MA40.floatValue) {
                        minAssert = kLineModel.MA40.floatValue;
                    }
                    if (maxAssert < kLineModel.MA40.floatValue) {
                        maxAssert = kLineModel.MA40.floatValue;
                    }
                }
                if(kLineModel.MA60)
                {
                    if (minAssert > kLineModel.MA60.floatValue) {
                        minAssert = kLineModel.MA60.floatValue;
                    }
                    if (maxAssert < kLineModel.MA60.floatValue) {
                        maxAssert = kLineModel.MA60.floatValue;
                    }
                }
            }
        }else{
            if(kLineModel.price.floatValue > maxAssert)
            {
                maxAssert = kLineModel.price.floatValue;
            }
            if(kLineModel.price.floatValue < minAssert)
            {
                minAssert = kLineModel.price.floatValue;
            }
            if (kLineModel.average) {
                if (minAssert > kLineModel.average.floatValue) {
                    minAssert = kLineModel.average.floatValue;
                }
                if (maxAssert < kLineModel.average.floatValue) {
                    maxAssert = kLineModel.average.floatValue;
                }
            }
        }
    }];
    
    self.maxAssert = maxAssert;
    self.minAssert = minAssert;
    
    CGFloat minY = Y_StockChartKLineMainViewMinY;
    CGFloat maxY = Y_StockChartKLineMainViewMaxY;
    CGFloat unitValue = (maxAssert - minAssert)/(maxY - minY);
    if (unitValue == 0) {
        unitValue = 0.01f;
    }
    self.unitValue = unitValue;
    
    [self.needDrawKLinePositionModels removeAllObjects];
    
    [self.MA5Positions removeAllObjects];
    [self.MA10Positions removeAllObjects];
    [self.MA20Positions removeAllObjects];
    [self.MA40Positions removeAllObjects];
    [self.MA60Positions removeAllObjects];
    [self.AVERAGEPositions removeAllObjects];
    [self.BOLL_MBPositions removeAllObjects];
    [self.BOLL_UPPositions removeAllObjects];
    [self.BOLL_DNPositions removeAllObjects];
    
    NSInteger kLineModelsCount = kLineModels.count;
    for (NSInteger idx = 0 ; idx < kLineModelsCount; ++idx)
    {
        //K线坐标转换
        Y_KLineModel *kLineModel = kLineModels[idx];
        //        CGFloat xPosition = [self xPosition] + idx * ([Y_StockChartGlobalVariable kLineWidth] + [Y_StockChartGlobalVariable kLineGap]);
        CGFloat xPosition = 0.f;
        if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
            xPosition = [self xPosition] + idx * ([Y_StockChartGlobalVariable kLineWidth] + [Y_StockChartGlobalVariable kLineGap]);
        }else if(self.MainViewType == Y_StockChartcenterViewTypeTimeLine){
            xPosition = Y_StockTimeLineViewVolumeGap +idx * ([Y_StockChartGlobalVariable timeLineVolumeWidth] + Y_StockTimeLineViewVolumeGap);
        }
        
        
        if (xPosition > self.parentScrollView.contentSize.width) {
            NSLog(@"当前需要绘制 超出边界----- %f",xPosition);
        }
        if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
            CGPoint openPoint = CGPointMake(xPosition, ABS(maxY - (kLineModel.Open.floatValue - minAssert)/unitValue));
            CGFloat closePointY = ABS(maxY - (kLineModel.Close.floatValue - minAssert)/unitValue);
            if(ABS(closePointY - openPoint.y) < Y_StockChartKLineMinThick)
            {
                if(openPoint.y > closePointY)
                {
                    openPoint.y = closePointY + Y_StockChartKLineMinThick;
                } else if(openPoint.y < closePointY)
                {
                    closePointY = openPoint.y + Y_StockChartKLineMinThick;
                } else {
                    if(idx > 0)
                    {
                        Y_KLineModel *preKLineModel = kLineModels[idx-1];
                        if(kLineModel.Open.floatValue > preKLineModel.Close.floatValue)
                        {
                            openPoint.y = closePointY + Y_StockChartKLineMinThick;
                        } else {
                            closePointY = openPoint.y + Y_StockChartKLineMinThick;
                        }
                    } else if(idx+1 < kLineModelsCount){
                        
                        //idx==0即第一个时
                        Y_KLineModel *subKLineModel = kLineModels[idx+1];
                        if(kLineModel.Close.floatValue < subKLineModel.Open.floatValue)
                        {
                            openPoint.y = closePointY + Y_StockChartKLineMinThick;
                        } else {
                            closePointY = openPoint.y + Y_StockChartKLineMinThick;
                        }
                    }
                }
            }
            
            CGPoint closePoint = CGPointMake(xPosition, closePointY);
            CGPoint highPoint = CGPointMake(xPosition, ABS(maxY - (kLineModel.High.floatValue - minAssert)/unitValue));
            CGPoint lowPoint = CGPointMake(xPosition, ABS(maxY - (kLineModel.Low.floatValue - minAssert)/unitValue));
            
            Y_KLinePositionModel *kLinePositionModel = [Y_KLinePositionModel modelWithOpen:openPoint close:closePoint high:highPoint low:lowPoint];
            [self.needDrawKLinePositionModels addObject:kLinePositionModel];
            if(_targetLineStatus == Y_StockChartTargetLineStatusMA){
                if (kLineModel.MA5.floatValue > 0.f) {
                    [self.MA5Positions addObject: [NSValue valueWithCGPoint:CGPointMake(xPosition, ABS(maxY - (kLineModel.MA5.floatValue - minAssert)/unitValue))]];
                }
                
                if (kLineModel.MA10.floatValue > 0.f) {
                    [self.MA10Positions addObject: [NSValue valueWithCGPoint:CGPointMake(xPosition, ABS(maxY - (kLineModel.MA10.floatValue - minAssert)/unitValue))]];
                }
                
                if (kLineModel.MA20.floatValue > 0.f) {
                    [self.MA20Positions addObject: [NSValue valueWithCGPoint:CGPointMake(xPosition, ABS(maxY - (kLineModel.MA20.floatValue - minAssert)/unitValue))]];
                }
                
                if (kLineModel.MA40.floatValue > 0.f) {
                    [self.MA40Positions addObject: [NSValue valueWithCGPoint:CGPointMake(xPosition, ABS(maxY - (kLineModel.MA40.floatValue - minAssert)/unitValue))]];
                }
                
                if (kLineModel.MA60.floatValue > 0.f) {
                    [self.MA60Positions addObject: [NSValue valueWithCGPoint:CGPointMake(xPosition, ABS(maxY - (kLineModel.MA60.floatValue - minAssert)/unitValue))]];
                }
            }
            
            if(_targetLineStatus == Y_StockChartTargetLineStatusBOLL){
                //BOLL坐标转换
                
                if (kLineModel.BOLL_MB.floatValue > 0.f) {
                    [self.BOLL_MBPositions addObject:[NSValue valueWithCGPoint:CGPointMake(xPosition, maxY - (kLineModel.BOLL_MB.floatValue - minAssert)/unitValue)]];
                }
                
                if (kLineModel.BOLL_UP.floatValue > 0.f) {
                    [self.BOLL_UPPositions addObject:[NSValue valueWithCGPoint:CGPointMake(xPosition, maxY - (kLineModel.BOLL_UP.floatValue - minAssert)/unitValue)]];
                }
                if (kLineModel.BOLL_DN.floatValue > 0.f) {
                    [self.BOLL_DNPositions addObject:[NSValue valueWithCGPoint:CGPointMake(xPosition, maxY - (kLineModel.BOLL_DN.floatValue - minAssert)/unitValue)]];
                }
                
            }
        }
        
        if (self.MainViewType == Y_StockChartcenterViewTypeTimeLine) {
            
            CGPoint pricePoint = CGPointMake(xPosition, maxY - (kLineModel.price.floatValue - minAssert)/unitValue);
            Y_KLinePositionModel *kLinePositionModel = [Y_KLinePositionModel modelWithOpen:pricePoint close:pricePoint high:pricePoint low:pricePoint];
            kLinePositionModel.pricePoint = pricePoint;
            [self.needDrawKLinePositionModels addObject:kLinePositionModel];
            if (kLineModel.average.floatValue > 0.f) {
                [self.AVERAGEPositions addObject:[NSValue valueWithCGPoint:CGPointMake(xPosition, maxY - (kLineModel.average.floatValue - minAssert)/unitValue)]];
            }
        }
    }
    //响应代理方法
    if(self.delegate)
    {
        if([self.delegate respondsToSelector:@selector(kLineMainViewCurrentMaxPrice:minPrice:)])
        {
            [self.delegate kLineMainViewCurrentMaxPrice:maxAssert minPrice:minAssert];
        }
        if([self.delegate respondsToSelector:@selector(kLineMainViewCurrentNeedDrawKLinePositionModels:)])
        {
            [self.delegate kLineMainViewCurrentNeedDrawKLinePositionModels:self.needDrawKLinePositionModels];
        }
    }
    return self.needDrawKLinePositionModels;
}

static char *observerContext = NULL;
#pragma mark 添加所有事件监听的方法
- (void)private_addAllEventListener{
    //KVO监听scrollview的状态变化
    [_parentScrollView addObserver:self forKeyPath:Y_StockChartContentOffsetKey options:NSKeyValueObservingOptionNew context:observerContext];
}
#pragma mark - setter,getter方法
- (NSInteger)xPosition {
    //    NSInteger leftArrCount = [self startIndex];
    //    CGFloat startXPosition = (leftArrCount + 1) * [Y_StockChartGlobalVariable kLineGap] + leftArrCount * [Y_StockChartGlobalVariable kLineWidth] + [Y_StockChartGlobalVariable kLineWidth]/2;
    //    return startXPosition;
    return [Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]/2;
}

- (NSInteger)startIndex {
    CGFloat offsetX = self.parentScrollView.contentOffset.x < 0 ? 0 : self.parentScrollView.contentOffset.x;
    
    NSUInteger leftCount = ABS(offsetX) / ([Y_StockChartGlobalVariable kLineWidth] + [Y_StockChartGlobalVariable kLineGap]);
    
    if (leftCount > self.kLineModels.count) {
        leftCount = self.kLineModels.count - 1;
    }
    return leftCount;
}

- (NSInteger)needDrawStartIndex{
    CGFloat scrollViewOffsetX = self.parentScrollView.contentOffset.x < 0 ? 0 : self.parentScrollView.contentOffset.x;
    NSUInteger leftArrCount = ABS(scrollViewOffsetX - [Y_StockChartGlobalVariable kLineGap]) / ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]);
    _needDrawStartIndex = leftArrCount;
    return _needDrawStartIndex;
}

- (NSInteger)getNeedDrawStartIndexWithScroll:(BOOL)scorll
{
    if (scorll)
    {
        CGFloat scrollViewOffsetX = self.parentScrollView.contentOffset.x < 0 ? 0 : self.parentScrollView.contentOffset.x;
        NSUInteger leftArrCount = ABS(scrollViewOffsetX - [Y_StockChartGlobalVariable kLineGap]) / ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]);
        
        _needDrawStartIndex = leftArrCount;
    }
    
    return _needDrawStartIndex;
}

- (void)setKLineModels:(NSArray *)kLineModels{
    _kLineModels = kLineModels;
    [self updateMainViewWidth];
}

#pragma mark - 系统方法
#pragma mark 已经添加到父view的方法,设置父scrollview
- (void)didMoveToSuperview{
    _parentScrollView = (UIScrollView *)self.superview;
    [self private_addAllEventListener];
    [super didMoveToSuperview];
}

#pragma mark KVO监听实现
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if([keyPath isEqualToString:Y_StockChartContentOffsetKey])
    {
        //        CGFloat difValue = ABS(self.parentScrollView.contentOffset.x - self.oldContentOffsetX);
        //        if(difValue >= [Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth])
        //        {
        //            self.oldContentOffsetX = self.parentScrollView.contentOffset.x;
        [self drawMainView];
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.parentScrollView).offset(self.parentScrollView.contentOffset.x);
            make.width.equalTo(self.parentScrollView);
        }];
        //        }
    }
}

-(CGFloat) getYValue:(CGFloat)yPosition{
    if (yPosition<= CGRectGetMaxY(self.frame) -Y_StockChartKLineMainViewMinY && yPosition >= CGRectGetMinY(self.frame) + Y_StockChartKLineMainViewMinY) {
        return self.maxAssert - (yPosition - CGRectGetMinY(self.frame) - Y_StockChartKLineMainViewMinY) * self.unitValue;
    }
    return .0f;
}

#pragma mark - dealloc
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 移除所有监听
- (void)removeAllObserver{
    [_parentScrollView removeObserver:self forKeyPath:Y_StockChartContentOffsetKey context:observerContext];
}

@end
