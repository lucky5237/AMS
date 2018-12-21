//请求查询交易所保证金率响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryexchangemarginrate : NSObject
@property(nonatomic,strong) NSNumber *is_ExchangeMarginRate_null;//ExchangeMarginRate是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *HedgeFlag;//投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,copy) NSString *LongMarginRatioByMoney;//多头保证金率
@property(nonatomic,copy) NSString *LongMarginRatioByVolume;//多头保证金费
@property(nonatomic,copy) NSString *ShortMarginRatioByMoney;//空头保证金率
@property(nonatomic,copy) NSString *ShortMarginRatioByVolume;//空头保证金费
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end