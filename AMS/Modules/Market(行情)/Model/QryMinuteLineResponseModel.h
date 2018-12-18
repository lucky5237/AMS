//
//  QryMinuteLineResponse.h
//  AMS
//
//  Created by jianlu on 2018/12/16.
//  Copyright © 2018 jianlu. All rights reserved.
//

// AMSQryMinuteLineResponseModel.h

#import <Foundation/Foundation.h>

@class QryMinuteLineResponseModel;
@class QryMinuteLineMdata;
@class AMSStockInfo;
@class AMSPeriodTypeList;
@class AMSTimeSharingList;
@class AMSPeriodAxisDatum;
@class AMSPeriodDatum;
NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface QryMinuteLineResponseModel : NSObject
@property (nonatomic, assign) NSInteger result;
@property (nonatomic, copy)   NSString *message;
@property (nonatomic, strong) QryMinuteLineMdata *mdata;
@property (nonatomic, copy)   NSArray *ldata;
@property (nonatomic, copy)   NSString *rows;
@property (nonatomic, copy)   NSString *total;
@end

@interface QryMinuteLineMdata : NSObject
@property (nonatomic, copy)   NSString *refreshInterval;
@property (nonatomic, strong) AMSStockInfo *stockInfo;
@property (nonatomic, copy)   NSArray<AMSTimeSharingList *> *timeSharingList;
@property (nonatomic, assign) NSInteger timeTransactionType;
@end

@interface AMSStockInfo : NSObject
@property (nonatomic, assign) double basePrice;
@property (nonatomic, copy)   NSString *displayPrecision;
@property (nonatomic, assign) NSInteger exCountryCode;
@property (nonatomic, assign) double highPrice;
@property (nonatomic, assign) double lowPrice;
@property (nonatomic, copy)   NSString *multiplierUnit;
@property (nonatomic, copy)   NSArray *periodTypeList;
@property (nonatomic, assign) double preClosePrice;
@property (nonatomic, assign) NSInteger precision;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy)   NSString *stockCode;
@property (nonatomic, copy)   NSString *stockCodeInternal;
@property (nonatomic, copy)   NSString *stockName;
@property (nonatomic, assign) NSInteger stockTypeCode;
@end

@interface AMSPeriodTypeList : NSObject
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy)   NSString *label;
@end

@interface AMSTimeSharingList : NSObject
@property (nonatomic, copy)   NSString *endingMinute;
@property (nonatomic, assign) NSInteger endingMinuteLong;
@property (nonatomic, copy)   NSArray *periodAxisData;
@property (nonatomic, copy)   NSArray *periodData;
@property (nonatomic, assign) NSInteger periodType;
@property (nonatomic, copy)   NSString *sampleRate;
@end

@interface AMSPeriodAxisDatum : NSObject
@property (nonatomic, copy)   NSString *beginTime;
@property (nonatomic, assign) NSInteger beginTimeLong;
@property (nonatomic, copy)   NSString *endTime;
@property (nonatomic, assign) NSInteger endTimeLong;
@end

@interface AMSPeriodDatum : NSObject
@property (nonatomic, copy)   NSString *change;
@property (nonatomic, strong) NSNumber* closePrice;
@property (nonatomic, assign) NSInteger displayPrecision;
@property (nonatomic, copy)   NSString *minute;
@property (nonatomic, copy)   NSString *rateOfChange;
@property (nonatomic, assign) NSInteger volume;
@end

NS_ASSUME_NONNULL_END
