//请求查询报单手续费
#import "BaseRequestModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Reqqryinstrumentordercommrate : BaseRequestModel
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码

NS_ASSUME_NONNULL_END
@end
