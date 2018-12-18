//请求查询交易所保证金率
#import "BaseRequestModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Reqqryexchangemarginrate : BaseRequestModel
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,strong) NSNumber *HedgeFlag;//投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码

NS_ASSUME_NONNULL_END
@end
