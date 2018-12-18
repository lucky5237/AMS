//请求查询投资者品种/跨品种保证金响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryinvestorproductgroupmargin : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_InvestorProductGroupMargin_null;//InvestorProductGroupMargin是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *ProductGroupID;//品种/跨品种标示
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *TradingDay;//交易日
@property(nonatomic,strong) NSNumber *SettlementID;//结算编号
@property(nonatomic,strong) NSNumber *FrozenMargin;//冻结的保证金
@property(nonatomic,strong) NSNumber *LongFrozenMargin;//多头冻结的保证金
@property(nonatomic,strong) NSNumber *ShortFrozenMargin;//空头冻结的保证金
@property(nonatomic,strong) NSNumber *UseMargin;//占用的保证金
@property(nonatomic,strong) NSNumber *LongUseMargin;//多头保证金
@property(nonatomic,strong) NSNumber *ShortUseMargin;//空头保证金
@property(nonatomic,strong) NSNumber *ExchMargin;//交易所保证金
@property(nonatomic,strong) NSNumber *LongExchMargin;//交易所多头保证金
@property(nonatomic,strong) NSNumber *ShortExchMargin;//交易所空头保证金
@property(nonatomic,strong) NSNumber *CloseProfit;//平仓盈亏
@property(nonatomic,strong) NSNumber *FrozenCommission;//冻结的手续费
@property(nonatomic,strong) NSNumber *Commission;//手续费
@property(nonatomic,strong) NSNumber *FrozenCash;//冻结的资金
@property(nonatomic,strong) NSNumber *CashIn;//资金差额
@property(nonatomic,strong) NSNumber *PositionProfit;//持仓盈亏
@property(nonatomic,strong) NSNumber *OffsetAmount;//折抵总金额
@property(nonatomic,strong) NSNumber *LongOffsetAmount;//多头折抵总金额
@property(nonatomic,strong) NSNumber *ShortOffsetAmount;//空头折抵总金额
@property(nonatomic,strong) NSNumber *ExchOffsetAmount;//交易所折抵总金额
@property(nonatomic,strong) NSNumber *LongExchOffsetAmount;//交易所多头折抵总金额
@property(nonatomic,strong) NSNumber *ShortExchOffsetAmount;//交易所空头折抵总金额
@property(nonatomic,strong) NSNumber *HedgeFlag;//投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码

NS_ASSUME_NONNULL_END
@end