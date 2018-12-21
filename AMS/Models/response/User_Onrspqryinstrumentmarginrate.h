//请求查询合约保证金率响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryinstrumentmarginrate : NSObject
@property(nonatomic,strong) NSNumber *is_InstrumentMarginRate_null;//InstrumentMarginRate是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *InvestorRange;//投资者范围    '1'->所有;'2'->投资者组;'3'->单一投资者;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *HedgeFlag;//投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,copy) NSString *LongMarginRatioByMoney;//多头保证金率
@property(nonatomic,copy) NSString *LongMarginRatioByVolume;//多头保证金费
@property(nonatomic,copy) NSString *ShortMarginRatioByMoney;//空头保证金率
@property(nonatomic,copy) NSString *ShortMarginRatioByVolume;//空头保证金费
@property(nonatomic,strong) NSNumber *IsRelative;//是否相对交易所收取
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end