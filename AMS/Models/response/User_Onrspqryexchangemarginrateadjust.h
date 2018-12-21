//请求查询交易所调整保证金率响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryexchangemarginrateadjust : NSObject
@property(nonatomic,strong) NSNumber *is_ExchangeMarginRateAdjust_null;//ExchangeMarginRateAdjust是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *HedgeFlag;//投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,copy) NSString *LongMarginRatioByMoney;//跟随交易所投资者多头保证金率
@property(nonatomic,copy) NSString *LongMarginRatioByVolume;//跟随交易所投资者多头保证金费
@property(nonatomic,copy) NSString *ShortMarginRatioByMoney;//跟随交易所投资者空头保证金率
@property(nonatomic,copy) NSString *ShortMarginRatioByVolume;//跟随交易所投资者空头保证金费
@property(nonatomic,copy) NSString *ExchLongMarginRatioByMoney;//交易所多头保证金率
@property(nonatomic,copy) NSString *ExchLongMarginRatioByVolume;//交易所多头保证金费
@property(nonatomic,copy) NSString *ExchShortMarginRatioByMoney;//交易所空头保证金率
@property(nonatomic,copy) NSString *ExchShortMarginRatioByVolume;//交易所空头保证金费
@property(nonatomic,copy) NSString *NoLongMarginRatioByMoney;//不跟随交易所投资者多头保证金率
@property(nonatomic,copy) NSString *NoLongMarginRatioByVolume;//不跟随交易所投资者多头保证金费
@property(nonatomic,copy) NSString *NoShortMarginRatioByMoney;//不跟随交易所投资者空头保证金率
@property(nonatomic,copy) NSString *NoShortMarginRatioByVolume;//不跟随交易所投资者空头保证金费
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end