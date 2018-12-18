//请求查询资金账户
#import "BaseRequestModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Reqqrysecagenttradingaccount : BaseRequestModel
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *CurrencyID;//币种代码
@property(nonatomic,strong) NSNumber *BizType;//业务类型    '1'->期货;'2'->证券;
@property(nonatomic,copy) NSString *AccountID;//投资者帐号

NS_ASSUME_NONNULL_END
@end
