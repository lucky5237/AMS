//请求查询组合合约安全系数响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqrycombinstrumentguard : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_CombInstrumentGuard_null;//CombInstrumentGuard是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,strong) NSNumber *(null);//(null)
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码

NS_ASSUME_NONNULL_END
@end