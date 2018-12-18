//请求查询保证金监管系统经纪公司资金账户密钥
#import "BaseRequestModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Reqqrycfmmctradingaccountkey : BaseRequestModel
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码

NS_ASSUME_NONNULL_END
@end
