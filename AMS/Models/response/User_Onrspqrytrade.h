//请求查询成交响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqrytrade : NSObject
@property(nonatomic,strong) NSNumber *is_Trade_null;//Trade是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *OrderRef;//报单引用
@property(nonatomic,copy) NSString *UserID;//用户代码
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *TradeID;//成交编号
@property(nonatomic,copy) NSString *Direction;//买卖方向    '0'->买;'1'->卖;
@property(nonatomic,copy) NSString *OrderSysID;//报单编号
@property(nonatomic,copy) NSString *ParticipantID;//会员代码
@property(nonatomic,copy) NSString *ClientID;//客户代码
@property(nonatomic,copy) NSString *TradingRole;//交易角色    '1'->代理;'2'->自营;'3'->做市商;
@property(nonatomic,copy) NSString *ExchangeInstID;//合约在交易所的代码
@property(nonatomic,copy) NSString *OffsetFlag;//开平标志    '0'->开仓;'1'->平仓;'2'->强平;'3'->平今;'4'->平昨;'5'->强减;'6'->本地强平;
@property(nonatomic,copy) NSString *HedgeFlag;//投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,copy) NSString *Price;//价格
@property(nonatomic,strong) NSNumber *Volume;//数量
@property(nonatomic,copy) NSString *TradeDate;//成交时期
@property(nonatomic,copy) NSString *TradeTime;//成交时间
@property(nonatomic,copy) NSString *TradeType;//成交类型    '#'->组合持仓拆分为单一持仓,初始化不应包含该类型的持仓;'0'->普通成交;'1'->期权执行;'2'->OTC成交;'3'->期转现衍生成交;'4'->组合衍生成交;
@property(nonatomic,copy) NSString *PriceSource;//成交价来源    '0'->前成交价;'1'->买委托价;'2'->卖委托价;
@property(nonatomic,copy) NSString *TraderID;//交易所交易员代码
@property(nonatomic,copy) NSString *OrderLocalID;//本地报单编号
@property(nonatomic,copy) NSString *ClearingPartID;//结算会员编号
@property(nonatomic,copy) NSString *BusinessUnit;//业务单元
@property(nonatomic,strong) NSNumber *SequenceNo;//序号
@property(nonatomic,copy) NSString *TradingDay;//交易日
@property(nonatomic,strong) NSNumber *SettlementID;//结算编号
@property(nonatomic,strong) NSNumber *BrokerOrderSeq;//经纪公司报单编号
@property(nonatomic,copy) NSString *TradeSource;//成交来源    '0'->来自交易所普通回报;'1'->来自查询;
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end