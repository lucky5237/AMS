//请求查询报价响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryquote : NSObject
@property(nonatomic,strong) NSNumber *is_Quote_null;//Quote是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *QuoteRef;//报价引用
@property(nonatomic,copy) NSString *UserID;//用户代码
@property(nonatomic,copy) NSString *AskPrice;//卖价格
@property(nonatomic,copy) NSString *BidPrice;//买价格
@property(nonatomic,strong) NSNumber *AskVolume;//卖数量
@property(nonatomic,strong) NSNumber *BidVolume;//买数量
@property(nonatomic,strong) NSNumber *RequestID;//请求编号
@property(nonatomic,copy) NSString *BusinessUnit;//业务单元
@property(nonatomic,copy) NSString *AskOffsetFlag;//卖开平标志    '0'->开仓;'1'->平仓;'2'->强平;'3'->平今;'4'->平昨;'5'->强减;'6'->本地强平;
@property(nonatomic,copy) NSString *BidOffsetFlag;//买开平标志    '0'->开仓;'1'->平仓;'2'->强平;'3'->平今;'4'->平昨;'5'->强减;'6'->本地强平;
@property(nonatomic,copy) NSString *AskHedgeFlag;//卖投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,copy) NSString *BidHedgeFlag;//买投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,copy) NSString *QuoteLocalID;//本地报价编号
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *ParticipantID;//会员代码
@property(nonatomic,copy) NSString *ClientID;//客户代码
@property(nonatomic,copy) NSString *ExchangeInstID;//合约在交易所的代码
@property(nonatomic,copy) NSString *TraderID;//交易所交易员代码
@property(nonatomic,strong) NSNumber *InstallID;//安装编号
@property(nonatomic,strong) NSNumber *NotifySequence;//报价提示序号
@property(nonatomic,copy) NSString *OrderSubmitStatus;//报价提交状态    '0'->已经提交;'1'->撤单已经提交;'2'->修改已经提交;'3'->已经接受;'4'->报单已经被拒绝;'5'->撤单已经被拒绝;'6'->改单已经被拒绝;
@property(nonatomic,copy) NSString *TradingDay;//交易日
@property(nonatomic,strong) NSNumber *SettlementID;//结算编号
@property(nonatomic,copy) NSString *QuoteSysID;//报价编号
@property(nonatomic,copy) NSString *InsertDate;//报单日期
@property(nonatomic,copy) NSString *InsertTime;//插入时间
@property(nonatomic,copy) NSString *CancelTime;//撤销时间
@property(nonatomic,copy) NSString *QuoteStatus;//报价状态    '0'->全部成交;'1'->部分成交还在队列中;'2'->部分成交不在队列中;'3'->未成交还在队列中;'4'->未成交不在队列中;'5'->撤单;'a'->未知;'b'->尚未触发;'c'->已触发;
@property(nonatomic,copy) NSString *ClearingPartID;//结算会员编号
@property(nonatomic,strong) NSNumber *SequenceNo;//序号
@property(nonatomic,copy) NSString *AskOrderSysID;//卖方报单编号
@property(nonatomic,copy) NSString *BidOrderSysID;//买方报单编号
@property(nonatomic,strong) NSNumber *FrontID;//前置编号
@property(nonatomic,strong) NSNumber *SessionID;//会话编号
@property(nonatomic,copy) NSString *UserProductInfo;//用户端产品信息
@property(nonatomic,copy) NSString *StatusMsg;//状态信息
@property(nonatomic,copy) NSString *ActiveUserID;//操作用户代码
@property(nonatomic,strong) NSNumber *BrokerQuoteSeq;//经纪公司报价编号
@property(nonatomic,copy) NSString *AskOrderRef;//衍生卖报单引用
@property(nonatomic,copy) NSString *BidOrderRef;//衍生买报单引用
@property(nonatomic,copy) NSString *ForQuoteSysID;//应价编号
@property(nonatomic,copy) NSString *BranchID;//营业部编号
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码
@property(nonatomic,copy) NSString *AccountID;//资金账号
@property(nonatomic,copy) NSString *CurrencyID;//币种代码
@property(nonatomic,copy) NSString *IPAddress;//IP地址
@property(nonatomic,copy) NSString *MacAddress;//Mac地址
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end