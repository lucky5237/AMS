//请求查询投资者结算结果
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Reqqrysettlementinfo : NSObject
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *TradingDay;//交易日
@property(nonatomic,copy) NSString *AccountID;//投资者帐号
@property(nonatomic,copy) NSString *CurrencyID;//币种代码
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号

NS_ASSUME_NONNULL_END
@end