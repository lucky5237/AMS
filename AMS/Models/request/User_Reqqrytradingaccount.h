//请求查询资金账户
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Reqqrytradingaccount : NSObject
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *CurrencyID;//币种代码
@property(nonatomic,copy) NSString *BizType;//业务类型    '1'->期货;'2'->证券;
@property(nonatomic,copy) NSString *AccountID;//投资者帐号
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号

NS_ASSUME_NONNULL_END
@end