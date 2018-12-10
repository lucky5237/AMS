//
//  MarketModel.h
//  AMS
//
//  Created by jianlu on 2018/11/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarketModel : NSObject
@property(nonatomic,strong) NSNumber *marketId;
@property(nonatomic,copy) NSString *name;//名字
@property(nonatomic,strong) NSNumber *price;//最新
@property(nonatomic,strong) NSNumber *fallRise;//涨跌
@property(nonatomic,strong) NSNumber *fallRisePer;//涨跌幅
@property(nonatomic,strong) NSNumber *volume;//成交量
@property(nonatomic,strong) NSNumber *openInterest;//持仓量
@property(nonatomic,strong) NSNumber *dailyIncrement;//日增仓
@property(nonatomic,assign) BOOL isRise;//是否涨价
@property(nonatomic,assign) BOOL hasCollect;//是否涨价
@end

NS_ASSUME_NONNULL_END
