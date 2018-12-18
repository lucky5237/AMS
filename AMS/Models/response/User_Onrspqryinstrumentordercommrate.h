//请求查询报单手续费响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryinstrumentordercommrate : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_InstrumentOrderCommRate_null;//InstrumentOrderCommRate是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,strong) NSNumber *InvestorRange;//投资者范围    '1'->所有;'2'->投资者组;'3'->单一投资者;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,strong) NSNumber *HedgeFlag;//投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,strong) NSNumber *OrderCommByVolume;//报单手续费
@property(nonatomic,strong) NSNumber *OrderActionCommByVolume;//撤单手续费
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码

NS_ASSUME_NONNULL_END
@end