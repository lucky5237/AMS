//请求查询二级代理商资金校验模式响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqrysecagentcheckmode : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_SecAgentCheckMode_null;//SecAgentCheckMode是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *CurrencyID;//币种
@property(nonatomic,copy) NSString *BrokerSecAgentID;//境外中介机构资金帐号
@property(nonatomic,strong) NSNumber *CheckSelfAccount;//是否需要校验自己的资金账户

NS_ASSUME_NONNULL_END
@end