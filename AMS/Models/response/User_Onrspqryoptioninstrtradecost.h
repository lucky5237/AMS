//请求查询期权交易成本响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryoptioninstrtradecost : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_OptionInstrTradeCost_null;//OptionInstrTradeCost是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,strong) NSNumber *HedgeFlag;//投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,strong) NSNumber *FixedMargin;//期权合约保证金不变部分
@property(nonatomic,strong) NSNumber *MiniMargin;//期权合约最小保证金
@property(nonatomic,strong) NSNumber *Royalty;//期权合约权利金
@property(nonatomic,strong) NSNumber *ExchFixedMargin;//交易所期权合约保证金不变部分
@property(nonatomic,strong) NSNumber *ExchMiniMargin;//交易所期权合约最小保证金
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码

NS_ASSUME_NONNULL_END
@end