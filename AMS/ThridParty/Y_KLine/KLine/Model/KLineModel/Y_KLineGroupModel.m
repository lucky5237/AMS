//
//  Y-KLineGroupModel.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/28.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_KLineGroupModel.h"
#import "Y_KLineModel.h"
#import "QryMinuteLineResponseModel.h"
#import "QryKLineResponseModel.h"
@implementation Y_KLineGroupModel
+ (instancetype) objectWithArray:(NSArray *)arr type:(Y_StockChartCenterViewType)type lastDayClosePrice:(NSNumber*)price{
    if (![arr isKindOfClass:[NSArray class]]) {
        NSLog(@"arr不是一个数组");
        return nil;
    }
//    NSAssert([arr isKindOfClass:[NSArray class]], @"arr不是一个数组");
    
    Y_KLineGroupModel *groupModel = [[Y_KLineGroupModel alloc]init];
    NSMutableArray *mutableArr = @[].mutableCopy;
    __block Y_KLineModel *preModel = [[Y_KLineModel alloc]init];
    
    if (type == Y_StockChartcenterViewTypeKline) {
        for (AMSList *item in arr)
        {
            Y_KLineModel *model = [Y_KLineModel new];
            model.PreviousKlineModel = preModel;
            [model initWithArray:item];
            model.ParentGroupModel = groupModel;
            [mutableArr addObject:model];
            preModel = model;
        }
    }else{
        for (AMSPeriodDatum *item in arr)
        {
            Y_KLineModel *model = [Y_KLineModel new];
            model.PreviousKlineModel = preModel;
            [model initWithTimeLineArray:item lastDayClosePrise:400];
            model.ParentGroupModel = groupModel;
            [mutableArr addObject:model];
            preModel = model;
        }
    }

    
    groupModel.models = mutableArr;
    
    if(type == Y_StockChartcenterViewTypeKline){
        //初始化第一个Model的数据
        Y_KLineModel *firstModel = mutableArr[0];
        [firstModel initFirstModel];
        
        //初始化其他Model的数据
        [mutableArr enumerateObjectsUsingBlock:^(Y_KLineModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            [model initData];
        }];
    }
   

    return groupModel;
}

+ (instancetype) objectWithArray:(NSArray *)arr type:(Y_StockChartCenterViewType)type{
    return [self objectWithArray:arr type:type lastDayClosePrice:nil];
}


@end
