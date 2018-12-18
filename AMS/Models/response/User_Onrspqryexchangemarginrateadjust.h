//请求查询交易所调整保证金率响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryexchangemarginrateadjust : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_ExchangeMarginRateAdjust_null;//ExchangeMarginRateAdjust是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,strong) NSNumber *HedgeFlag;//投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,strong) NSNumber *LongMarginRatioByMoney;//跟随交易所投资者多头保证金率
@property(nonatomic,strong) NSNumber *LongMarginRatioByVolume;//跟随交易所投资者多头保证金费
@property(nonatomic,strong) NSNumber *ShortMarginRatioByMoney;//跟随交易所投资者空头保证金率
@property(nonatomic,strong) NSNumber *ShortMarginRatioByVolume;//跟随交易所投资者空头保证金费
@property(nonatomic,strong) NSNumber *ExchLongMarginRatioByMoney;//交易所多头保证金率
@property(nonatomic,strong) NSNumber *ExchLongMarginRatioByVolume;//交易所多头保证金费
@property(nonatomic,strong) NSNumber *ExchShortMarginRatioByMoney;//交易所空头保证金率
@property(nonatomic,strong) NSNumber *ExchShortMarginRatioByVolume;//交易所空头保证金费
@property(nonatomic,strong) NSNumber *NoLongMarginRatioByMoney;//不跟随交易所投资者多头保证金率
@property(nonatomic,strong) NSNumber *NoLongMarginRatioByVolume;//不跟随交易所投资者多头保证金费
@property(nonatomic,strong) NSNumber *NoShortMarginRatioByMoney;//不跟随交易所投资者空头保证金率
@property(nonatomic,strong) NSNumber *NoShortMarginRatioByVolume;//不跟随交易所投资者空头保证金费

NS_ASSUME_NONNULL_END
@end