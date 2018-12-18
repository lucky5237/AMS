//请求查询投资者持仓响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryinvestorposition : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_InvestorPosition_null;//InvestorPosition是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,strong) NSNumber *PosiDirection;//持仓多空方向    '1'->净;'2'->多头;'3'->空头;
@property(nonatomic,strong) NSNumber *HedgeFlag;//投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,strong) NSNumber *PositionDate;//持仓日期    '1'->今日持仓;'2'->历史持仓;
@property(nonatomic,strong) NSNumber *YdPosition;//上日持仓
@property(nonatomic,strong) NSNumber *Position;//今日持仓
@property(nonatomic,strong) NSNumber *LongFrozen;//多头冻结
@property(nonatomic,strong) NSNumber *ShortFrozen;//空头冻结
@property(nonatomic,strong) NSNumber *LongFrozenAmount;//开仓冻结金额
@property(nonatomic,strong) NSNumber *ShortFrozenAmount;//开仓冻结金额
@property(nonatomic,strong) NSNumber *OpenVolume;//开仓量
@property(nonatomic,strong) NSNumber *CloseVolume;//平仓量
@property(nonatomic,strong) NSNumber *OpenAmount;//开仓金额
@property(nonatomic,strong) NSNumber *CloseAmount;//平仓金额
@property(nonatomic,strong) NSNumber *PositionCost;//持仓成本
@property(nonatomic,strong) NSNumber *PreMargin;//上次占用的保证金
@property(nonatomic,strong) NSNumber *UseMargin;//占用的保证金
@property(nonatomic,strong) NSNumber *FrozenMargin;//冻结的保证金
@property(nonatomic,strong) NSNumber *FrozenCash;//冻结的资金
@property(nonatomic,strong) NSNumber *FrozenCommission;//冻结的手续费
@property(nonatomic,strong) NSNumber *CashIn;//资金差额
@property(nonatomic,strong) NSNumber *Commission;//手续费
@property(nonatomic,strong) NSNumber *CloseProfit;//平仓盈亏
@property(nonatomic,strong) NSNumber *PositionProfit;//持仓盈亏
@property(nonatomic,strong) NSNumber *PreSettlementPrice;//上次结算价
@property(nonatomic,strong) NSNumber *SettlementPrice;//本次结算价
@property(nonatomic,copy) NSString *TradingDay;//交易日
@property(nonatomic,strong) NSNumber *SettlementID;//结算编号
@property(nonatomic,strong) NSNumber *OpenCost;//开仓成本
@property(nonatomic,strong) NSNumber *ExchangeMargin;//交易所保证金
@property(nonatomic,strong) NSNumber *CombPosition;//组合成交形成的持仓
@property(nonatomic,strong) NSNumber *CombLongFrozen;//组合多头冻结
@property(nonatomic,strong) NSNumber *CombShortFrozen;//组合空头冻结
@property(nonatomic,strong) NSNumber *CloseProfitByDate;//逐日盯市平仓盈亏
@property(nonatomic,strong) NSNumber *CloseProfitByTrade;//逐笔对冲平仓盈亏
@property(nonatomic,strong) NSNumber *TodayPosition;//今日持仓
@property(nonatomic,strong) NSNumber *MarginRateByMoney;//保证金率
@property(nonatomic,strong) NSNumber *MarginRateByVolume;//保证金率(按手数)
@property(nonatomic,strong) NSNumber *StrikeFrozen;//执行冻结
@property(nonatomic,strong) NSNumber *StrikeFrozenAmount;//执行冻结金额
@property(nonatomic,strong) NSNumber *AbandonFrozen;//放弃执行冻结
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,strong) NSNumber *YdStrikeFrozen;//执行冻结的昨仓
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码

NS_ASSUME_NONNULL_END
@end