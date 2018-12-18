//
//  QryKLineResponseModel.h
//  AMS
//
//  Created by jianlu on 2018/12/16.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QryKLineResponseModel;
@class QryKLineMdata;
@class AMSList;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface QryKLineResponseModel : NSObject
@property (nonatomic, assign) NSInteger result;
@property (nonatomic, copy)   NSString *message;
@property (nonatomic, strong) QryKLineMdata *mdata;
@property (nonatomic, copy)   NSArray *ldata;
@property (nonatomic, copy)   NSString *rows;
@property (nonatomic, copy)   NSString *total;
@end

@interface QryKLineMdata : NSObject
@property (nonatomic, copy)   NSString *date;
@property (nonatomic, assign) NSInteger exCountryCode;
@property (nonatomic, assign) BOOL isSuspend;
@property (nonatomic, copy)   NSArray *list;
@property (nonatomic, assign) NSInteger stockDayCount;
@property (nonatomic, copy)   NSString *stockName;
@property (nonatomic, assign) NSInteger stockTypeCode;
@end

@interface AMSList : NSObject
@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, copy)   NSString *change;
@property (nonatomic, assign) double closePrice;
@property (nonatomic, copy)   NSString *dea;
@property (nonatomic, copy)   NSString *dealBalance;
@property (nonatomic, copy)   NSString *dif;
@property (nonatomic, copy)   NSString *displayPrecision;
@property (nonatomic, copy)   NSString *emaLong;
@property (nonatomic, copy)   NSString *emaShort;
@property (nonatomic, assign) double highPrice;
@property (nonatomic, assign) double lowPrice;
@property (nonatomic, copy)   NSString *ma10;
@property (nonatomic, copy)   NSString *ma20;
@property (nonatomic, copy)   NSString *ma30;
@property (nonatomic, copy)   NSString *ma5;
@property (nonatomic, copy)   NSString *macd;
@property (nonatomic, copy)   NSString *ema12;
@property (nonatomic, copy)   NSString *ema26;
@property (nonatomic, assign) double openPrice;
@property (nonatomic, copy)   id preClosePrice;
@property (nonatomic, copy)   NSString *rateOfChange;
@property (nonatomic, copy)   NSString *tradeDate;
@property (nonatomic, copy)   NSString *turnoverRate;
@end

NS_ASSUME_NONNULL_END
