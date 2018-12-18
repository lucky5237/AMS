//请求查询行情响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqrydepthmarketdata : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_DepthMarketData_null;//DepthMarketData是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *TradingDay;//交易日
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *ExchangeInstID;//合约在交易所的代码
@property(nonatomic,strong) NSNumber *LastPrice;//最新价
@property(nonatomic,strong) NSNumber *PreSettlementPrice;//上次结算价
@property(nonatomic,strong) NSNumber *PreClosePrice;//昨收盘
@property(nonatomic,strong) NSNumber *PreOpenInterest;//昨持仓量
@property(nonatomic,strong) NSNumber *OpenPrice;//今开盘
@property(nonatomic,strong) NSNumber *HighestPrice;//最高价
@property(nonatomic,strong) NSNumber *LowestPrice;//最低价
@property(nonatomic,strong) NSNumber *Volume;//数量
@property(nonatomic,strong) NSNumber *Turnover;//成交金额
@property(nonatomic,strong) NSNumber *OpenInterest;//持仓量
@property(nonatomic,strong) NSNumber *ClosePrice;//今收盘
@property(nonatomic,strong) NSNumber *SettlementPrice;//本次结算价
@property(nonatomic,strong) NSNumber *UpperLimitPrice;//涨停板价
@property(nonatomic,strong) NSNumber *LowerLimitPrice;//跌停板价
@property(nonatomic,strong) NSNumber *PreDelta;//昨虚实度
@property(nonatomic,strong) NSNumber *CurrDelta;//今虚实度
@property(nonatomic,copy) NSString *UpdateTime;//最后修改时间
@property(nonatomic,strong) NSNumber *UpdateMillisec;//最后修改毫秒
@property(nonatomic,strong) NSNumber *BidPrice1;//申买价一
@property(nonatomic,strong) NSNumber *BidVolume1;//申买量一
@property(nonatomic,strong) NSNumber *AskPrice1;//申卖价一
@property(nonatomic,strong) NSNumber *AskVolume1;//申卖量一
@property(nonatomic,strong) NSNumber *BidPrice2;//申买价二
@property(nonatomic,strong) NSNumber *BidVolume2;//申买量二
@property(nonatomic,strong) NSNumber *AskPrice2;//申卖价二
@property(nonatomic,strong) NSNumber *AskVolume2;//申卖量二
@property(nonatomic,strong) NSNumber *BidPrice3;//申买价三
@property(nonatomic,strong) NSNumber *BidVolume3;//申买量三
@property(nonatomic,strong) NSNumber *AskPrice3;//申卖价三
@property(nonatomic,strong) NSNumber *AskVolume3;//申卖量三
@property(nonatomic,strong) NSNumber *BidPrice4;//申买价四
@property(nonatomic,strong) NSNumber *BidVolume4;//申买量四
@property(nonatomic,strong) NSNumber *AskPrice4;//申卖价四
@property(nonatomic,strong) NSNumber *AskVolume4;//申卖量四
@property(nonatomic,strong) NSNumber *BidPrice5;//申买价五
@property(nonatomic,strong) NSNumber *BidVolume5;//申买量五
@property(nonatomic,strong) NSNumber *AskPrice5;//申卖价五
@property(nonatomic,strong) NSNumber *AskVolume5;//申卖量五
@property(nonatomic,strong) NSNumber *AveragePrice;//当日均价
@property(nonatomic,copy) NSString *ActionDay;//业务日期

NS_ASSUME_NONNULL_END
@end