//请求查询预埋单
#import "BaseRequestModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Reqqryparkedorder : BaseRequestModel
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码

NS_ASSUME_NONNULL_END
@end
