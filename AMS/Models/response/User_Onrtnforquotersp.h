//询价通知
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrtnforquotersp : NSObject
@property(nonatomic,strong) NSNumber *is_ForQuoteRsp_null;//ForQuoteRsp是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *TradingDay;//交易日
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *ForQuoteSysID;//询价编号
@property(nonatomic,copy) NSString *ForQuoteTime;//询价时间
@property(nonatomic,copy) NSString *ActionDay;//业务日期
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码

NS_ASSUME_NONNULL_END
@end