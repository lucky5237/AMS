//请求查询经纪公司交易算法响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqrybrokertradingalgos : NSObject
@property(nonatomic,strong) NSNumber *is_BrokerTradingAlgos_null;//BrokerTradingAlgos是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *HandlePositionAlgoID;//持仓处理算法编号    '1'->基本;'2'->大连商品交易所;'3'->郑州商品交易所;
@property(nonatomic,copy) NSString *FindMarginRateAlgoID;//寻找保证金率算法编号    '1'->基本;'2'->大连商品交易所;'3'->郑州商品交易所;
@property(nonatomic,copy) NSString *HandleTradingAccountAlgoID;//资金处理算法编号    '1'->基本;'2'->大连商品交易所;'3'->郑州商品交易所;
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end