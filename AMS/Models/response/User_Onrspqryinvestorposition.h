//请求查询投资者持仓响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryinvestorposition : NSObject
@property(nonatomic,strong) NSNumber *is_InvestorPosition_null;//InvestorPosition是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *PosiDirection;//持仓多空方向    '1'->净;'2'->多头;'3'->空头;
@property(nonatomic,copy) NSString *HedgeFlag;//投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,copy) NSString *PositionDate;//持仓日期    '1'->今日持仓;'2'->历史持仓;
@property(nonatomic,strong) NSNumber *YdPosition;//上日持仓
@property(nonatomic,strong) NSNumber *Position;//今日持仓
@property(nonatomic,strong) NSNumber *LongFrozen;//多头冻结
@property(nonatomic,strong) NSNumber *ShortFrozen;//空头冻结
@property(nonatomic,copy) NSString *LongFrozenAmount;//开仓冻结金额
@property(nonatomic,copy) NSString *ShortFrozenAmount;//开仓冻结金额
@property(nonatomic,strong) NSNumber *OpenVolume;//开仓量
@property(nonatomic,strong) NSNumber *CloseVolume;//平仓量
@property(nonatomic,copy) NSString *OpenAmount;//开仓金额
@property(nonatomic,copy) NSString *CloseAmount;//平仓金额
@property(nonatomic,copy) NSString *PositionCost;//持仓成本
@property(nonatomic,copy) NSString *PreMargin;//上次占用的保证金
@property(nonatomic,copy) NSString *UseMargin;//占用的保证金
@property(nonatomic,copy) NSString *FrozenMargin;//冻结的保证金
@property(nonatomic,copy) NSString *FrozenCash;//冻结的资金
@property(nonatomic,copy) NSString *FrozenCommission;//冻结的手续费
@property(nonatomic,copy) NSString *CashIn;//资金差额
@property(nonatomic,copy) NSString *Commission;//手续费
@property(nonatomic,copy) NSString *CloseProfit;//平仓盈亏
@property(nonatomic,copy) NSString *PositionProfit;//持仓盈亏
@property(nonatomic,copy) NSString *PreSettlementPrice;//上次结算价
@property(nonatomic,copy) NSString *SettlementPrice;//本次结算价
@property(nonatomic,copy) NSString *TradingDay;//交易日
@property(nonatomic,strong) NSNumber *SettlementID;//结算编号
@property(nonatomic,copy) NSString *OpenCost;//开仓成本
@property(nonatomic,copy) NSString *ExchangeMargin;//交易所保证金
@property(nonatomic,strong) NSNumber *CombPosition;//组合成交形成的持仓
@property(nonatomic,strong) NSNumber *CombLongFrozen;//组合多头冻结
@property(nonatomic,strong) NSNumber *CombShortFrozen;//组合空头冻结
@property(nonatomic,copy) NSString *CloseProfitByDate;//逐日盯市平仓盈亏
@property(nonatomic,copy) NSString *CloseProfitByTrade;//逐笔对冲平仓盈亏
@property(nonatomic,strong) NSNumber *TodayPosition;//今日持仓
@property(nonatomic,copy) NSString *MarginRateByMoney;//保证金率
@property(nonatomic,copy) NSString *MarginRateByVolume;//保证金率(按手数)
@property(nonatomic,strong) NSNumber *StrikeFrozen;//执行冻结
@property(nonatomic,copy) NSString *StrikeFrozenAmount;//执行冻结金额
@property(nonatomic,strong) NSNumber *AbandonFrozen;//放弃执行冻结
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,strong) NSNumber *YdStrikeFrozen;//执行冻结的昨仓
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end