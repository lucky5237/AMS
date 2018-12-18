//请求查询投资者持仓明细响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryinvestorpositioncombinedetail : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_InvestorPositionCombineDetail_null;//InvestorPositionCombineDetail是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *TradingDay;//交易日
@property(nonatomic,copy) NSString *OpenDate;//开仓日期
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,strong) NSNumber *SettlementID;//结算编号
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *ComTradeID;//组合编号
@property(nonatomic,copy) NSString *TradeID;//撮合编号
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,strong) NSNumber *HedgeFlag;//投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,strong) NSNumber *Direction;//买卖    '0'->买;'1'->卖;
@property(nonatomic,strong) NSNumber *TotalAmt;//持仓量
@property(nonatomic,strong) NSNumber *Margin;//投资者保证金
@property(nonatomic,strong) NSNumber *ExchMargin;//交易所保证金
@property(nonatomic,strong) NSNumber *MarginRateByMoney;//保证金率
@property(nonatomic,strong) NSNumber *MarginRateByVolume;//保证金率(按手数)
@property(nonatomic,strong) NSNumber *LegID;//单腿编号
@property(nonatomic,strong) NSNumber *LegMultiple;//单腿乘数
@property(nonatomic,copy) NSString *CombInstrumentID;//组合持仓合约编码
@property(nonatomic,strong) NSNumber *TradeGroupID;//成交组号
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码

NS_ASSUME_NONNULL_END
@end