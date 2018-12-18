//请求查询监控中心用户令牌
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspquerycfmmctradingaccounttoken : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_QueryCFMMCTradingAccountToken_null;//QueryCFMMCTradingAccountToken是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码

NS_ASSUME_NONNULL_END
@end