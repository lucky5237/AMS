//查询最大报单数量响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspquerymaxordervolume : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_QueryMaxOrderVolume_null;//QueryMaxOrderVolume是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,strong) NSNumber *Direction;//买卖方向    '0'->买;'1'->卖;
@property(nonatomic,strong) NSNumber *OffsetFlag;//开平标志    '0'->开仓;'1'->平仓;'2'->强平;'3'->平今;'4'->平昨;'5'->强减;'6'->本地强平;
@property(nonatomic,strong) NSNumber *HedgeFlag;//投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,strong) NSNumber *MaxVolume;//最大允许报单数量
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码

NS_ASSUME_NONNULL_END
@end