//请求查询二级代理操作员银期权限响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqrysecagentacidmap : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_SecAgentACIDMap_null;//SecAgentACIDMap是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *UserID;//用户代码
@property(nonatomic,copy) NSString *AccountID;//资金账户
@property(nonatomic,copy) NSString *CurrencyID;//币种
@property(nonatomic,copy) NSString *BrokerSecAgentID;//境外中介机构资金帐号

NS_ASSUME_NONNULL_END
@end