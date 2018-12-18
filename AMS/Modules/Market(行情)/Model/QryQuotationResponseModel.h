// AMSQryQuotationResponse.h

#import <Foundation/Foundation.h>

@class QryQuotationResponseModel;
@class AMSLdatum;
@class QryQuotationTimeDescription;
@class QryQuotationMdata;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface QryQuotationResponseModel : NSObject
@property (nonatomic, copy)   NSArray *ldata;
@property (nonatomic, strong) QryQuotationMdata *mdata;
@property (nonatomic, copy)   NSString *message;
@property (nonatomic, assign) NSInteger result;
@property(nonatomic,copy) NSString *rows;
@property(nonatomic,copy) NSString *total;
@end

@interface AMSLdatum : NSObject
@property (nonatomic, copy)   NSString *afterHoursLatestPrice;
@property (nonatomic, copy)   NSString *afterHoursPriceChange;
@property (nonatomic, copy)   NSString *afterHoursPriceChangeRate;
@property (nonatomic, copy)   NSString *amplitude;
@property (nonatomic, copy)   NSString *bps;
@property (nonatomic, copy)   NSString *buyAmount1;
@property (nonatomic, copy)   NSString *buyAmount10;
@property (nonatomic, copy)   NSString *buyAmount2;
@property (nonatomic, copy)   NSString *buyAmount3;
@property (nonatomic, copy)   NSString *buyAmount4;
@property (nonatomic, copy)   NSString *buyAmount5;
@property (nonatomic, copy)   NSString *buyAmount6;
@property (nonatomic, copy)   NSString *buyAmount7;
@property (nonatomic, copy)   NSString *buyAmount8;
@property (nonatomic, copy)   NSString *buyAmount9;
@property (nonatomic, copy)   NSString *buyPrice1;
@property (nonatomic, copy)   NSString *buyPrice10;
@property (nonatomic, copy)   NSString *buyPrice2;
@property (nonatomic, copy)   NSString *buyPrice3;
@property (nonatomic, copy)   NSString *buyPrice4;
@property (nonatomic, copy)   NSString *buyPrice5;
@property (nonatomic, copy)   NSString *buyPrice6;
@property (nonatomic, copy)   NSString *buyPrice7;
@property (nonatomic, copy)   NSString *buyPrice8;
@property (nonatomic, copy)   NSString *buyPrice9;
@property (nonatomic, copy)   NSString *circulateAmount;
@property (nonatomic, copy)   NSString *circulationValue;
@property (nonatomic, copy)   NSString *closeOrOpenTime;
@property (nonatomic, copy)   NSString *currentAmount;
@property (nonatomic, copy)   NSString *date;
@property (nonatomic, assign) NSInteger dealAmount;
@property (nonatomic, copy)   NSString *dealBalance;
@property (nonatomic, copy)   NSString *displayPrecision;
@property (nonatomic, copy)   NSString *downPrice;
@property (nonatomic, copy)   NSString *dynamicPbRate;
@property (nonatomic, copy)   NSString *entrustDifference;
@property (nonatomic, copy)   NSString *entrustRate;
@property (nonatomic, copy)   NSString *eps;
@property (nonatomic, copy)   NSString *exCountryCode;
@property (nonatomic, assign) BOOL isForbidBuy;
@property (nonatomic, copy)   NSString *highPrice;
@property (nonatomic, assign) BOOL isHolding;
@property (nonatomic, copy)   NSString *innerDisk;
@property (nonatomic, copy)   NSString *latestPrice;
@property (nonatomic, copy)   NSString *lotSize;
@property (nonatomic, copy)   NSString *lowPrice;
@property (nonatomic, copy)   NSString *marketValue;
@property (nonatomic, assign) NSInteger minuteDealAmount;
@property (nonatomic, copy)   NSString *multiplier;
@property (nonatomic, copy)   NSString *multiplierUnit;
@property (nonatomic, copy)   NSString *nextDownPrice;
@property (nonatomic, copy)   NSString *nextUpPrice;
@property (nonatomic, copy)   NSString *openPrice;
@property (nonatomic, copy)   NSString *outerDisk;
@property (nonatomic, copy)   NSString *peRate;
@property (nonatomic, assign) NSInteger precision;
@property (nonatomic, copy)   NSString *preclosePrice;
@property (nonatomic, copy)   NSString *priceChange;
@property (nonatomic, copy)   NSString *priceChangeRate;
@property (nonatomic, copy)   NSString *saleAmount1;
@property (nonatomic, copy)   NSString *saleAmount10;
@property (nonatomic, copy)   NSString *saleAmount2;
@property (nonatomic, copy)   NSString *saleAmount3;
@property (nonatomic, copy)   NSString *saleAmount4;
@property (nonatomic, copy)   NSString *saleAmount5;
@property (nonatomic, copy)   NSString *saleAmount6;
@property (nonatomic, copy)   NSString *saleAmount7;
@property (nonatomic, copy)   NSString *saleAmount8;
@property (nonatomic, copy)   NSString *saleAmount9;
@property (nonatomic, copy)   NSString *salePrice1;
@property (nonatomic, copy)   NSString *salePrice10;
@property (nonatomic, copy)   NSString *salePrice2;
@property (nonatomic, copy)   NSString *salePrice3;
@property (nonatomic, copy)   NSString *salePrice4;
@property (nonatomic, copy)   NSString *salePrice5;
@property (nonatomic, copy)   NSString *salePrice6;
@property (nonatomic, copy)   NSString *salePrice7;
@property (nonatomic, copy)   NSString *salePrice8;
@property (nonatomic, copy)   NSString *salePrice9;
@property (nonatomic, copy)   NSString *serverTime;
@property (nonatomic, copy)   NSString *staticPbRate;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy)   NSString *stockCode;
@property (nonatomic, copy)   NSString *stockCodeInternal;
@property (nonatomic, assign) NSInteger stockExchangeCode;
@property (nonatomic, copy)   NSString *stockName;
@property (nonatomic, copy)   NSString *stockTypeCode;
@property (nonatomic, assign) BOOL isSupportFinancing;
@property (nonatomic, copy)   NSString *supportShanghaiStockConnect;
@property (nonatomic, copy)   NSString *supportShenzhenStockConnect;
@property (nonatomic, assign) NSInteger supportShortSale;
@property (nonatomic, assign) BOOL isSuspend;
@property (nonatomic, copy)   NSString *tick;
@property (nonatomic, copy)   NSArray<QryQuotationTimeDescription *> *timeDescriptions;
@property (nonatomic, copy)   NSString *totalShares;
@property (nonatomic, copy)   NSString *tradeMins;
@property (nonatomic, copy)   NSString *turnoverRatio;
@property (nonatomic, copy)   NSString *upPrice;
@property (nonatomic, assign) BOOL isUpdated;
@property (nonatomic, copy)   NSString *volRatio;
@property (nonatomic, strong) NSNumber *openInterest;
@property (nonatomic, strong) NSNumber *priceTick;

//自己增加的字段
@property (nonatomic, assign) BOOL hasCollect;
@end

@interface QryQuotationTimeDescription : NSObject
@property (nonatomic, copy)   NSString *categoryName;
@property (nonatomic, assign) NSInteger checkTime;
@property (nonatomic, assign) NSInteger openOrCloseType;
@property (nonatomic, assign) NSInteger time;
@end

@interface QryQuotationMdata : NSObject
@property (nonatomic, assign) BOOL isAfterHours;
@property (nonatomic, assign) BOOL isTradeDate;
@property (nonatomic, copy)   NSString *refreshInterval;
@end

NS_ASSUME_NONNULL_END
