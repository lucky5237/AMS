//请求查询执行宣告
#import "BaseRequestModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Reqqryexecorder : BaseRequestModel
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *ExecOrderSysID;//执行宣告编号
@property(nonatomic,copy) NSString *InsertTimeStart;//开始时间
@property(nonatomic,copy) NSString *InsertTimeEnd;//结束时间

NS_ASSUME_NONNULL_END
@end
