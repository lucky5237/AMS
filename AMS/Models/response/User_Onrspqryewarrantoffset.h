//请求查询仓单折抵信息响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryewarrantoffset : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_EWarrantOffset_null;//EWarrantOffset是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *TradingDay;//交易日期
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,strong) NSNumber *Direction;//买卖方向    '0'->买;'1'->卖;
@property(nonatomic,strong) NSNumber *HedgeFlag;//投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,strong) NSNumber *Volume;//数量
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码

NS_ASSUME_NONNULL_END
@end