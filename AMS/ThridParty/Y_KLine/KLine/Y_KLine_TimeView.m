//
//  Y_KLine_TimeView.m
//  AMS
//
//  Created by jianlu on 2018/11/28.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "Y_KLine_TimeView.h"
#import "Y_KLinePositionModel.h"
#import "Y_KLineModel.h"
#import "Y_StockChartGlobalVariable.h"

@interface Y_KLine_TimeView()

@end

@implementation Y_KLine_TimeView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //如果数组为空，则不进行绘制，直接设置本view为背景
    CGContextRef context = UIGraphicsGetCurrentContext();
        //设置显示日期的区域背景颜色
        CGContextSetFillColorWithColor(context, kBackGroundColor.CGColor);
        CGContextFillRect(context, self.bounds);
    if(self.type == Y_StockChartcenterViewTypeKline){
            __block NSMutableArray *positions = @[].mutableCopy;
//            [self.needDrawKLinePositionModels enumerateObjectsUsingBlock:^(Y_KLinePositionModel * _Nonnull positionModel, NSUInteger idx, BOOL * _Nonnull stop) {
//                [positions addObject:[NSValue valueWithCGPoint:positionModel.ClosePoint]];
//            }];
            //
        
//            __block CGPoint lastDrawDatePoint = CGPointZero;//fix
            UIScrollView *scrollView = (UIScrollView *) self.superview;
//            [self.needDrawKLinePositionModels enumerateObjectsUsingBlock:^(Y_KLinePositionModel * _Nonnull positionModel, NSUInteger idx, BOOL * _Nonnull stop) {
//
//
//                CGPoint point = positionModel.LowPoint;
//                  Y_KLineModel *model = (Y_KLineModel *)self.needDrawKLineModels[idx];
//                 CGPoint drawPoint = CGPointMake(point.x - [Y_StockChartGlobalVariable kLineWidth] / 2    , 5);
//
//                if(CGPointEqualToPoint(lastDrawDatePoint, CGPointZero) || drawPoint.x - lastDrawDatePoint.x >= self.frame.size.width / 4 )
//                {
//                    [model.Date drawAtPoint:drawPoint withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10],NSForegroundColorAttributeName : klineBgLineRedColor}];
//                    lastDrawDatePoint = drawPoint;
//                }
//
//
//            }];
//        CGFloat xPositoinInMainView = originPosition.x - scrollView.contentOffset.x;
        NSInteger startIndexZero,startIndexOne,startIndexTwo,startIndexThree;
        startIndexZero = 0;
        startIndexOne= (NSInteger)(self.frame.size.width /4 ) / ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]);
        startIndexTwo= (NSInteger)(self.frame.size.width /2 ) / ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]);
        startIndexThree= (NSInteger)(self.frame.size.width*3/4 ) / ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]);
        NSArray *indexArray = @[@(startIndexZero),@(startIndexOne),@(startIndexTwo),@(startIndexThree)];
        [indexArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSNumber *index = (NSNumber*)obj;
            if (index.integerValue < self.needDrawKLineModels.count) {
                Y_KLineModel *model = self.needDrawKLineModels[index.integerValue];
//                Y_KLinePositionModel *positionModel = self.needDrawKLinePositionModels[index.integerValue];
                [model.Date drawAtPoint:CGPointMake(idx*self.frame.size.width/4,5) withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10],NSForegroundColorAttributeName : klineBgLineRedColor}];
            }
        }];

  
    }else{
    //绘制从9：00开始
        NSArray *drawStringArray = @[@"9:00",@"10:00",@"11:00",@"14:00",@"15:00"];
        [drawStringArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *str = drawStringArray[idx];
            CGFloat unitWidth = self.frame.size.width / 4;
            CGFloat width = [AMSUtil rectOfNSString:str attribute:@{NSFontAttributeName : [UIFont systemFontOfSize:10]}].size.width;
            CGPoint drawPoint = CGPointMake(idx == 0 ? 0 :(idx == drawStringArray.count - 1 ? self.frame.size.width - width : unitWidth * idx - width /2 ), 5);
            [str drawAtPoint:drawPoint withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10],NSForegroundColorAttributeName : klineBgLineRedColor}];
        }];
    }

}

- (void)draw{
    [self setNeedsDisplay];
}




@end
