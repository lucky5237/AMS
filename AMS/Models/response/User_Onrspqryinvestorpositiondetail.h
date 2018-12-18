//请求查询投资者持仓明细响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryinvestorpositiondetail : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_InvestorPositionDetail_null;//InvestorPositionDetail是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,strong) NSNumber *HedgeFlag;//投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,strong) NSNumber *Direction;//买卖    '0'->买;'1'->卖;
@property(nonatomic,copy) NSString *OpenDate;//开仓日期
@property(nonatomic,copy) NSString *TradeID;//成交编号
@property(nonatomic,strong) NSNumber *Volume;//数量
@property(nonatomic,strong) NSNumber *OpenPrice;//开仓价
@property(nonatomic,copy) NSString *TradingDay;//交易日
@property(nonatomic,strong) NSNumber *SettlementID;//结算编号
@property(nonatomic,strong) NSNumber *TradeType;//成交类型    '#'->组合持仓拆分为单一持仓,初始化不应包含该类型的持仓;'0'->普通成交;'1'->期权执行;'2'->OTC成交;'3'->期转现衍生成交;'4'->组合衍生成交;
@property(nonatomic,copy) NSString *CombInstrumentID;//组合合约代码
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,strong) NSNumber *CloseProfitByDate;//逐日盯市平仓盈亏
@property(nonatomic,strong) NSNumber *CloseProfitByTrade;//逐笔对冲平仓盈亏
@property(nonatomic,strong) NSNumber *PositionProfitByDate;//逐日盯市持仓盈亏
@property(nonatomic,strong) NSNumber *PositionProfitByTrade;//逐笔对冲持仓盈亏
@property(nonatomic,strong) NSNumber *Margin;//投资者保证金
@property(nonatomic,strong) NSNumber *ExchMargin;//交易所保证金
@property(nonatomic,strong) NSNumber *MarginRateByMoney;//保证金率
@property(nonatomic,strong) NSNumber *MarginRateByVolume;//保证金率(按手数)
@property(nonatomic,strong) NSNumber *LastSettlementPrice;//昨结算价
@property(nonatomic,strong) NSNumber *SettlementPrice;//结算价
@property(nonatomic,strong) NSNumber *CloseVolume;//平仓量
@property(nonatomic,strong) NSNumber *CloseAmount;//平仓金额
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码

NS_ASSUME_NONNULL_END
@end