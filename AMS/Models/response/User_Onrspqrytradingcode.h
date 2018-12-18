//请求查询交易编码响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqrytradingcode : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_TradingCode_null;//TradingCode是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *ClientID;//客户代码
@property(nonatomic,strong) NSNumber *IsActive;//是否活跃
@property(nonatomic,strong) NSNumber *ClientIDType;//交易编码类型    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,copy) NSString *BranchID;//营业部编号
@property(nonatomic,strong) NSNumber *BizType;//业务类型    '1'->期货;'2'->证券;
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码

NS_ASSUME_NONNULL_END
@end