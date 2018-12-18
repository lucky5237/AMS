//请求查询合约手续费率响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryinstrumentcommissionrate : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_InstrumentCommissionRate_null;//InstrumentCommissionRate是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,strong) NSNumber *InvestorRange;//投资者范围    '1'->所有;'2'->投资者组;'3'->单一投资者;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,strong) NSNumber *OpenRatioByMoney;//开仓手续费率
@property(nonatomic,strong) NSNumber *OpenRatioByVolume;//开仓手续费
@property(nonatomic,strong) NSNumber *CloseRatioByMoney;//平仓手续费率
@property(nonatomic,strong) NSNumber *CloseRatioByVolume;//平仓手续费
@property(nonatomic,strong) NSNumber *CloseTodayRatioByMoney;//平今手续费率
@property(nonatomic,strong) NSNumber *CloseTodayRatioByVolume;//平今手续费
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,strong) NSNumber *BizType;//业务类型    '1'->期货;'2'->证券;
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码

NS_ASSUME_NONNULL_END
@end