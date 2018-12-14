//
//  QryKLineResponseModel.m
//  AMS
//
//  Created by jianlu on 2018/12/14.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "QryKLineResponseModel.h"

#define λ(decl, expr) (^(decl) { return (expr); })
#define NSNullify(x) ([x isNotEqualTo:[NSNull null]] ? x : [NSNull null])

NS_ASSUME_NONNULL_BEGIN

@interface QTQryKLineResponseModel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTMdata (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTList (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTChange
+ (NSDictionary<NSString *, QTChange *> *)values
{
    static NSDictionary<NSString *, QTChange *> *values;
    return values = values ? values : @{
        @"": [[QTChange alloc] initWithValue:@""],
    };
}

+ (QTChange *)empty { return QTChange.values[@""]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTChange.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTMa5
+ (NSDictionary<NSString *, QTMa5 *> *)values
{
    static NSDictionary<NSString *, QTMa5 *> *values;
    return values = values ? values : @{
        @"276.600000": [[QTMa5 alloc] initWithValue:@"276.600000"],
        @"276.690000": [[QTMa5 alloc] initWithValue:@"276.690000"],
        @"276.780000": [[QTMa5 alloc] initWithValue:@"276.780000"],
        @"276.870000": [[QTMa5 alloc] initWithValue:@"276.870000"],
        @"276.960000": [[QTMa5 alloc] initWithValue:@"276.960000"],
        @"277.050000": [[QTMa5 alloc] initWithValue:@"277.050000"],
    };
}

+ (QTMa5 *)the276600000 { return QTMa5.values[@"276.600000"]; }
+ (QTMa5 *)the276690000 { return QTMa5.values[@"276.690000"]; }
+ (QTMa5 *)the276780000 { return QTMa5.values[@"276.780000"]; }
+ (QTMa5 *)the276870000 { return QTMa5.values[@"276.870000"]; }
+ (QTMa5 *)the276960000 { return QTMa5.values[@"276.960000"]; }
+ (QTMa5 *)the277050000 { return QTMa5.values[@"277.050000"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTMa5.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTQryKLineResponseModel
+(NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
                                                    @"result": @"result",
                                                    @"message": @"message",
                                                    @"mdata": @"mdata",
                                                    @"ldata": @"ldata",
                                                    @"rows": @"rows",
                                                    @"total": @"total",
                                                    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return QTQryKLineResponseModelFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return QTQryKLineResponseModelFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[QTQryKLineResponseModel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _mdata = [QTMdata fromJSONDictionary:(id)_mdata];
    }
    return self;
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTQryKLineResponseModel.properties.allValues] mutableCopy];
    
    [dict addEntriesFromDictionary:@{
                                     @"mdata": [_mdata JSONDictionary],
                                     }];
    
    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return QTQryKLineResponseModelToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return QTQryKLineResponseModelToJSON(self, encoding, error);
}
@end

static id map(id collection, id (^f)(id value)) {
    id result = nil;
    if ([collection isKindOfClass:[NSArray class]]) {
        result = [NSMutableArray arrayWithCapacity:[collection count]];
        for (id x in collection) [result addObject:f(x)];
    } else if ([collection isKindOfClass:[NSDictionary class]]) {
        result = [NSMutableDictionary dictionaryWithCapacity:[collection count]];
        for (id key in collection) [result setObject:f([collection objectForKey:key]) forKey:key];
    }
    return result;
}

#pragma mark - JSON serialization

QTQryKLineResponseModel *_Nullable QTQryKLineResponseModelFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [QTQryKLineResponseModel fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

QTQryKLineResponseModel *_Nullable QTQryKLineResponseModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return QTQryKLineResponseModelFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable QTQryKLineResponseModelToData(QTQryKLineResponseModel *qryKLineResponseModel, NSError **error)
{
    @try {
        id json = [qryKLineResponseModel JSONDictionary];
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable QTQryKLineResponseModelToJSON(QTQryKLineResponseModel *qryKLineResponseModel, NSStringEncoding encoding, NSError **error)
{
    NSData *data = QTQryKLineResponseModelToData(qryKLineResponseModel, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}



@implementation QTMdata
+(NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"date": @"date",
        @"exCountryCode": @"exCountryCode",
        @"isSuspend": @"isSuspend",
        @"list": @"list",
        @"stockDayCount": @"stockDayCount",
        @"stockName": @"stockName",
        @"stockTypeCode": @"stockTypeCode",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[QTMdata alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _list = map(_list, λ(id x, [QTList fromJSONDictionary:x]));
    }
    return self;
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTMdata.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"isSuspend": _isSuspend ? @YES : @NO,
        @"list": map(_list, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTList
+(NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"amount": @"amount",
        @"change": @"change",
        @"closePrice": @"closePrice",
        @"dea": @"dea",
        @"dealBalance": @"dealBalance",
        @"dif": @"dif",
        @"displayPrecision": @"displayPrecision",
        @"emaLong": @"emaLong",
        @"emaShort": @"emaShort",
        @"highPrice": @"highPrice",
        @"lowPrice": @"lowPrice",
        @"ma10": @"ma10",
        @"ma20": @"ma20",
        @"ma30": @"ma30",
        @"ma5": @"ma5",
        @"macd": @"macd",
        @"ema12": @"ema12",
        @"ema26": @"ema26",
        @"openPrice": @"openPrice",
        @"preClosePrice": @"preClosePrice",
        @"rateOfChange": @"rateOfChange",
        @"tradeDate": @"tradeDate",
        @"turnoverRate": @"turnoverRate",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[QTList alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _change = [QTChange withValue:(id)_change];
        _dealBalance = [QTChange withValue:(id)_dealBalance];
        _displayPrecision = [QTChange withValue:(id)_displayPrecision];
        _emaLong = [QTChange withValue:(id)_emaLong];
        _emaShort = [QTChange withValue:(id)_emaShort];
        _ma5 = [QTMa5 withValue:(id)_ma5];
        _rateOfChange = [QTChange withValue:(id)_rateOfChange];
        _turnoverRate = [QTChange withValue:(id)_turnoverRate];
    }
    return self;
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTList.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"change": [_change value],
        @"dealBalance": [_dealBalance value],
        @"displayPrecision": [_displayPrecision value],
        @"emaLong": [_emaLong value],
        @"emaShort": [_emaShort value],
        @"ma5": [_ma5 value],
        @"rateOfChange": [_rateOfChange value],
        @"turnoverRate": [_turnoverRate value],
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END

