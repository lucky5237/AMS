//请求查询行情响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqrydepthmarketdata : NSObject
@property(nonatomic,strong) NSNumber *is_DepthMarketData_null;//DepthMarketData是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *TradingDay;//交易日
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *ExchangeInstID;//合约在交易所的代码
@property(nonatomic,copy) NSString *LastPrice;//最新价
@property(nonatomic,copy) NSString *PreSettlementPrice;//上次结算价
@property(nonatomic,copy) NSString *PreClosePrice;//昨收盘
@property(nonatomic,copy) NSString *PreOpenInterest;//昨持仓量
@property(nonatomic,copy) NSString *OpenPrice;//今开盘
@property(nonatomic,copy) NSString *HighestPrice;//最高价
@property(nonatomic,copy) NSString *LowestPrice;//最低价
@property(nonatomic,strong) NSNumber *Volume;//数量
@property(nonatomic,copy) NSString *Turnover;//成交金额
@property(nonatomic,copy) NSString *OpenInterest;//持仓量
@property(nonatomic,copy) NSString *ClosePrice;//今收盘
@property(nonatomic,copy) NSString *SettlementPrice;//本次结算价
@property(nonatomic,copy) NSString *UpperLimitPrice;//涨停板价
@property(nonatomic,copy) NSString *LowerLimitPrice;//跌停板价
@property(nonatomic,copy) NSString *PreDelta;//昨虚实度
@property(nonatomic,copy) NSString *CurrDelta;//今虚实度
@property(nonatomic,copy) NSString *UpdateTime;//最后修改时间
@property(nonatomic,strong) NSNumber *UpdateMillisec;//最后修改毫秒
@property(nonatomic,copy) NSString *BidPrice1;//申买价一
@property(nonatomic,strong) NSNumber *BidVolume1;//申买量一
@property(nonatomic,copy) NSString *AskPrice1;//申卖价一
@property(nonatomic,strong) NSNumber *AskVolume1;//申卖量一
@property(nonatomic,copy) NSString *BidPrice2;//申买价二
@property(nonatomic,strong) NSNumber *BidVolume2;//申买量二
@property(nonatomic,copy) NSString *AskPrice2;//申卖价二
@property(nonatomic,strong) NSNumber *AskVolume2;//申卖量二
@property(nonatomic,copy) NSString *BidPrice3;//申买价三
@property(nonatomic,strong) NSNumber *BidVolume3;//申买量三
@property(nonatomic,copy) NSString *AskPrice3;//申卖价三
@property(nonatomic,strong) NSNumber *AskVolume3;//申卖量三
@property(nonatomic,copy) NSString *BidPrice4;//申买价四
@property(nonatomic,strong) NSNumber *BidVolume4;//申买量四
@property(nonatomic,copy) NSString *AskPrice4;//申卖价四
@property(nonatomic,strong) NSNumber *AskVolume4;//申卖量四
@property(nonatomic,copy) NSString *BidPrice5;//申买价五
@property(nonatomic,strong) NSNumber *BidVolume5;//申买量五
@property(nonatomic,copy) NSString *AskPrice5;//申卖价五
@property(nonatomic,strong) NSNumber *AskVolume5;//申卖量五
@property(nonatomic,copy) NSString *AveragePrice;//当日均价
@property(nonatomic,copy) NSString *ActionDay;//业务日期
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end