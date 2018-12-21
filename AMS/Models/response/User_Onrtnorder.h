//报单通知
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrtnorder : NSObject
@property(nonatomic,strong) NSNumber *is_Order_null;//Order是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *OrderRef;//报单引用
@property(nonatomic,copy) NSString *UserID;//用户代码
@property(nonatomic,copy) NSString *OrderPriceType;//报单价格条件    '1'->任意价;'2'->限价;'3'->最优价;'4'->最新价;'5'->最新价浮动上浮1个ticks;'6'->最新价浮动上浮2个ticks;'7'->最新价浮动上浮3个ticks;'8'->卖一价;'9'->卖一价浮动上浮1个ticks;'A'->卖一价浮动上浮2个ticks;'B'->卖一价浮动上浮3个ticks;'C'->买一价;'D'->买一价浮动上浮1个ticks;'E'->买一价浮动上浮2个ticks;'F'->买一价浮动上浮3个ticks;'G'->五档价;
@property(nonatomic,copy) NSString *Direction;//买卖方向    '0'->买;'1'->卖;
@property(nonatomic,copy) NSString *CombOffsetFlag;//组合开平标志
@property(nonatomic,copy) NSString *CombHedgeFlag;//组合投机套保标志
@property(nonatomic,copy) NSString *LimitPrice;//价格
@property(nonatomic,strong) NSNumber *VolumeTotalOriginal;//数量
@property(nonatomic,copy) NSString *TimeCondition;//有效期类型    '1'->立即完成，否则撤销;'2'->本节有效;'3'->当日有效;'4'->指定日期前有效;'5'->撤销前有效;'6'->集合竞价有效;
@property(nonatomic,copy) NSString *GTDDate;//GTD日期
@property(nonatomic,copy) NSString *VolumeCondition;//成交量类型    '1'->任何数量;'2'->最小数量;'3'->全部数量;
@property(nonatomic,strong) NSNumber *MinVolume;//最小成交量
@property(nonatomic,copy) NSString *ContingentCondition;//触发条件    '1'->立即;'2'->止损;'3'->止赢;'4'->预埋单;'5'->最新价大于条件价;'6'->最新价大于等于条件价;'7'->最新价小于条件价;'8'->最新价小于等于条件价;'9'->卖一价大于条件价;'A'->卖一价大于等于条件价;'B'->卖一价小于条件价;'C'->卖一价小于等于条件价;'D'->买一价大于条件价;'E'->买一价大于等于条件价;'F'->买一价小于条件价;'H'->买一价小于等于条件价;
@property(nonatomic,copy) NSString *StopPrice;//止损价
@property(nonatomic,copy) NSString *ForceCloseReason;//强平原因    '0'->非强平;'1'->资金不足;'2'->客户超仓;'3'->会员超仓;'4'->持仓非整数倍;'5'->违规;'6'->其它;'7'->自然人临近交割;
@property(nonatomic,strong) NSNumber *IsAutoSuspend;//自动挂起标志
@property(nonatomic,copy) NSString *BusinessUnit;//业务单元
@property(nonatomic,strong) NSNumber *RequestID;//请求编号
@property(nonatomic,copy) NSString *OrderLocalID;//本地报单编号
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *ParticipantID;//会员代码
@property(nonatomic,copy) NSString *ClientID;//客户代码
@property(nonatomic,copy) NSString *ExchangeInstID;//合约在交易所的代码
@property(nonatomic,copy) NSString *TraderID;//交易所交易员代码
@property(nonatomic,strong) NSNumber *InstallID;//安装编号
@property(nonatomic,copy) NSString *OrderSubmitStatus;//报单提交状态    '0'->已经提交;'1'->撤单已经提交;'2'->修改已经提交;'3'->已经接受;'4'->报单已经被拒绝;'5'->撤单已经被拒绝;'6'->改单已经被拒绝;
@property(nonatomic,strong) NSNumber *NotifySequence;//报单提示序号
@property(nonatomic,copy) NSString *TradingDay;//交易日
@property(nonatomic,strong) NSNumber *SettlementID;//结算编号
@property(nonatomic,copy) NSString *OrderSysID;//报单编号
@property(nonatomic,copy) NSString *OrderSource;//报单来源    '0'->来自参与者;'1'->来自管理员;
@property(nonatomic,copy) NSString *OrderStatus;//报单状态    '0'->全部成交;'1'->部分成交还在队列中;'2'->部分成交不在队列中;'3'->未成交还在队列中;'4'->未成交不在队列中;'5'->撤单;'a'->未知;'b'->尚未触发;'c'->已触发;
@property(nonatomic,copy) NSString *OrderType;//报单类型    '0'->正常;'1'->报价衍生;'2'->组合衍生;'3'->组合报单;'4'->条件单;'5'->互换单;
@property(nonatomic,strong) NSNumber *VolumeTraded;//今成交数量
@property(nonatomic,strong) NSNumber *VolumeTotal;//剩余数量
@property(nonatomic,copy) NSString *InsertDate;//报单日期
@property(nonatomic,copy) NSString *InsertTime;//委托时间
@property(nonatomic,copy) NSString *ActiveTime;//激活时间
@property(nonatomic,copy) NSString *SuspendTime;//挂起时间
@property(nonatomic,copy) NSString *UpdateTime;//最后修改时间
@property(nonatomic,copy) NSString *CancelTime;//撤销时间
@property(nonatomic,copy) NSString *ActiveTraderID;//最后修改交易所交易员代码
@property(nonatomic,copy) NSString *ClearingPartID;//结算会员编号
@property(nonatomic,strong) NSNumber *SequenceNo;//序号
@property(nonatomic,strong) NSNumber *FrontID;//前置编号
@property(nonatomic,strong) NSNumber *SessionID;//会话编号
@property(nonatomic,copy) NSString *UserProductInfo;//用户端产品信息
@property(nonatomic,copy) NSString *StatusMsg;//状态信息
@property(nonatomic,strong) NSNumber *UserForceClose;//用户强评标志
@property(nonatomic,copy) NSString *ActiveUserID;//操作用户代码
@property(nonatomic,strong) NSNumber *BrokerOrderSeq;//经纪公司报单编号
@property(nonatomic,copy) NSString *RelativeOrderSysID;//相关报单
@property(nonatomic,strong) NSNumber *ZCETotalTradedVolume;//郑商所成交数量
@property(nonatomic,strong) NSNumber *IsSwapOrder;//互换单标志
@property(nonatomic,copy) NSString *BranchID;//营业部编号
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码
@property(nonatomic,copy) NSString *AccountID;//资金账号
@property(nonatomic,copy) NSString *CurrencyID;//币种代码
@property(nonatomic,copy) NSString *IPAddress;//IP地址
@property(nonatomic,copy) NSString *MacAddress;//Mac地址

NS_ASSUME_NONNULL_END
@end