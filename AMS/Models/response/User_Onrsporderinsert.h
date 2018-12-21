//报单录入请求响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrsporderinsert : NSObject
@property(nonatomic,strong) NSNumber *is_InputOrder_null;//InputOrder是否为null    1->是null;0->不是null;
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
@property(nonatomic,strong) NSNumber *UserForceClose;//用户强评标志
@property(nonatomic,strong) NSNumber *IsSwapOrder;//互换单标志
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码
@property(nonatomic,copy) NSString *AccountID;//资金账号
@property(nonatomic,copy) NSString *CurrencyID;//币种代码
@property(nonatomic,copy) NSString *ClientID;//交易编码
@property(nonatomic,copy) NSString *IPAddress;//IP地址
@property(nonatomic,copy) NSString *MacAddress;//Mac地址
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end