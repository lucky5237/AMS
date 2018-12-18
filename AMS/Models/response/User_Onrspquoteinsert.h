//报价录入请求响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspquoteinsert : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_InputQuote_null;//InputQuote是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *QuoteRef;//报价引用
@property(nonatomic,copy) NSString *UserID;//用户代码
@property(nonatomic,strong) NSNumber *AskPrice;//卖价格
@property(nonatomic,strong) NSNumber *BidPrice;//买价格
@property(nonatomic,strong) NSNumber *AskVolume;//卖数量
@property(nonatomic,strong) NSNumber *BidVolume;//买数量
@property(nonatomic,strong) NSNumber *RequestID;//请求编号
@property(nonatomic,copy) NSString *BusinessUnit;//业务单元
@property(nonatomic,strong) NSNumber *AskOffsetFlag;//卖开平标志    '0'->开仓;'1'->平仓;'2'->强平;'3'->平今;'4'->平昨;'5'->强减;'6'->本地强平;
@property(nonatomic,strong) NSNumber *BidOffsetFlag;//买开平标志    '0'->开仓;'1'->平仓;'2'->强平;'3'->平今;'4'->平昨;'5'->强减;'6'->本地强平;
@property(nonatomic,strong) NSNumber *AskHedgeFlag;//卖投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,strong) NSNumber *BidHedgeFlag;//买投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,copy) NSString *AskOrderRef;//衍生卖报单引用
@property(nonatomic,copy) NSString *BidOrderRef;//衍生买报单引用
@property(nonatomic,copy) NSString *ForQuoteSysID;//应价编号
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码
@property(nonatomic,copy) NSString *ClientID;//交易编码
@property(nonatomic,copy) NSString *IPAddress;//IP地址
@property(nonatomic,copy) NSString *MacAddress;//Mac地址

NS_ASSUME_NONNULL_END
@end