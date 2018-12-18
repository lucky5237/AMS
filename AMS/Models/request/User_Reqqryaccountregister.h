//请求查询银期签约关系
#import "BaseRequestModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Reqqryaccountregister : BaseRequestModel
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *AccountID;//投资者帐号
@property(nonatomic,copy) NSString *BankID;//银行编码
@property(nonatomic,copy) NSString *BankBranchID;//银行分支机构编码
@property(nonatomic,copy) NSString *CurrencyID;//币种代码

NS_ASSUME_NONNULL_END
@end
