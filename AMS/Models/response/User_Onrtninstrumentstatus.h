//合约交易状态通知
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrtninstrumentstatus : NSObject
@property(nonatomic,strong) NSNumber *is_InstrumentStatus_null;//InstrumentStatus是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *ExchangeInstID;//合约在交易所的代码
@property(nonatomic,copy) NSString *SettlementGroupID;//结算组代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *InstrumentStatus;//合约交易状态    '0'->开盘前;'1'->非交易;'2'->连续交易;'3'->集合竞价报单;'4'->集合竞价价格平衡;'5'->集合竞价撮合;'6'->收盘;
@property(nonatomic,strong) NSNumber *TradingSegmentSN;//交易阶段编号
@property(nonatomic,copy) NSString *EnterTime;//进入本状态时间
@property(nonatomic,copy) NSString *EnterReason;//进入本状态原因    '1'->自动切换;'2'->手动切换;'3'->熔断;

NS_ASSUME_NONNULL_END
@end