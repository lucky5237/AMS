//资金账户口令更新请求
#import "BaseRequestModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Reqtradingaccountpasswordupdate : BaseRequestModel
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *AccountID;//投资者帐号
@property(nonatomic,copy) NSString *OldPassword;//原来的口令
@property(nonatomic,copy) NSString *NewPassword;//新的口令
@property(nonatomic,copy) NSString *CurrencyID;//币种代码

NS_ASSUME_NONNULL_END
@end
