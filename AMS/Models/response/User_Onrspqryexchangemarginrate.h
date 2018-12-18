//请求查询交易所保证金率响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryexchangemarginrate : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_ExchangeMarginRate_null;//ExchangeMarginRate是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,strong) NSNumber *HedgeFlag;//投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,strong) NSNumber *LongMarginRatioByMoney;//多头保证金率
@property(nonatomic,strong) NSNumber *LongMarginRatioByVolume;//多头保证金费
@property(nonatomic,strong) NSNumber *ShortMarginRatioByMoney;//空头保证金率
@property(nonatomic,strong) NSNumber *ShortMarginRatioByVolume;//空头保证金费
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码

NS_ASSUME_NONNULL_END
@end