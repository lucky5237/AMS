// Generated with quicktype
// For more options, try https://app.quicktype.io

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTMdata;
@class QTList;
@class QTChange;
@class QTMa5;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTChange : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTChange *)empty;
@end

@interface QTMa5 : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTMa5 *)the276600000;
+ (QTMa5 *)the276690000;
+ (QTMa5 *)the276780000;
+ (QTMa5 *)the276870000;
+ (QTMa5 *)the276960000;
+ (QTMa5 *)the277050000;
@end

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, assign) NSInteger result;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) QTMdata *mdata;
@property (nonatomic, copy) NSArray *ldata;
@property (nonatomic, copy) NSString *rows;
@property (nonatomic, copy) NSString *total;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTMdata : NSObject
@property (nonatomic, copy) NSString *date;
@property (nonatomic, assign) NSInteger exCountryCode;
@property (nonatomic, assign) BOOL isSuspend;
@property (nonatomic, copy) NSArray<QTList *> *list;
@property (nonatomic, assign) NSInteger stockDayCount;
@property (nonatomic, copy) NSString *stockName;
@property (nonatomic, assign) NSInteger stockTypeCode;
@end

@interface QTList : NSObject
@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, assign) QTChange *change;
@property (nonatomic, assign) double closePrice;
@property (nonatomic, copy) NSString *dea;
@property (nonatomic, assign) QTChange *dealBalance;
@property (nonatomic, copy) NSString *dif;
@property (nonatomic, assign) QTChange *displayPrecision;
@property (nonatomic, assign) QTChange *emaLong;
@property (nonatomic, assign) QTChange *emaShort;
@property (nonatomic, assign) double highPrice;
@property (nonatomic, assign) double lowPrice;
@property (nonatomic, copy) NSString *ma10;
@property (nonatomic, copy) NSString *ma20;
@property (nonatomic, copy) NSString *ma30;
@property (nonatomic, assign) QTMa5 *ma5;
@property (nonatomic, copy) NSString *macd;
@property (nonatomic, copy) NSString *ema12;
@property (nonatomic, copy) NSString *ema26;
@property (nonatomic, assign) double openPrice;
@property (nonatomic, copy) id preClosePrice;
@property (nonatomic, assign) QTChange *rateOfChange;
@property (nonatomic, copy) NSString *tradeDate;
@property (nonatomic, assign) QTChange *turnoverRate;
@end

NS_ASSUME_NONNULL_END

