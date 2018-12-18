//请求查询投资单元响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryinvestunit : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_InvestUnit_null;//InvestUnit是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码
@property(nonatomic,copy) NSString *InvestorUnitName;//投资者单元名称
@property(nonatomic,copy) NSString *InvestorGroupID;//投资者分组代码
@property(nonatomic,copy) NSString *CommModelID;//手续费率模板代码
@property(nonatomic,copy) NSString *MarginModelID;//保证金率模板代码
@property(nonatomic,copy) NSString *AccountID;//资金账号
@property(nonatomic,copy) NSString *CurrencyID;//币种代码

NS_ASSUME_NONNULL_END
@end