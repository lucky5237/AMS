//请求查询经纪公司交易参数响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqrybrokertradingparams : NSObject
@property(nonatomic,strong) NSNumber *is_BrokerTradingParams_null;//BrokerTradingParams是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *MarginPriceType;//保证金价格类型    '1'->昨结算价;'2'->最新价;'3'->成交均价;'4'->开仓价;
@property(nonatomic,copy) NSString *Algorithm;//盈亏算法    '1'->浮盈浮亏都计算;'2'->浮盈不计，浮亏计;'3'->浮盈计，浮亏不计;'4'->浮盈浮亏都不计算;
@property(nonatomic,copy) NSString *AvailIncludeCloseProfit;//可用是否包含平仓盈利    '0'->包含平仓盈利;'2'->不包含平仓盈利;
@property(nonatomic,copy) NSString *CurrencyID;//币种代码
@property(nonatomic,copy) NSString *OptionRoyaltyPriceType;//期权权利金价格类型    '1'->昨结算价;'4'->开仓价;'5'->最新价与昨结算价较大值;
@property(nonatomic,copy) NSString *AccountID;//投资者帐号
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end