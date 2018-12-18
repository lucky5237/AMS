//请求查询经纪公司交易算法响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqrybrokertradingalgos : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_BrokerTradingAlgos_null;//BrokerTradingAlgos是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,strong) NSNumber *HandlePositionAlgoID;//持仓处理算法编号    '1'->基本;'2'->大连商品交易所;'3'->郑州商品交易所;
@property(nonatomic,strong) NSNumber *FindMarginRateAlgoID;//寻找保证金率算法编号    '1'->基本;'2'->大连商品交易所;'3'->郑州商品交易所;
@property(nonatomic,strong) NSNumber *HandleTradingAccountAlgoID;//资金处理算法编号    '1'->基本;'2'->大连商品交易所;'3'->郑州商品交易所;

NS_ASSUME_NONNULL_END
@end