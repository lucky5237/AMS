//请求查询投资者品种/跨品种保证金响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryinvestorproductgroupmargin : NSObject
@property(nonatomic,strong) NSNumber *is_InvestorProductGroupMargin_null;//InvestorProductGroupMargin是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *ProductGroupID;//品种/跨品种标示
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *TradingDay;//交易日
@property(nonatomic,strong) NSNumber *SettlementID;//结算编号
@property(nonatomic,copy) NSString *FrozenMargin;//冻结的保证金
@property(nonatomic,copy) NSString *LongFrozenMargin;//多头冻结的保证金
@property(nonatomic,copy) NSString *ShortFrozenMargin;//空头冻结的保证金
@property(nonatomic,copy) NSString *UseMargin;//占用的保证金
@property(nonatomic,copy) NSString *LongUseMargin;//多头保证金
@property(nonatomic,copy) NSString *ShortUseMargin;//空头保证金
@property(nonatomic,copy) NSString *ExchMargin;//交易所保证金
@property(nonatomic,copy) NSString *LongExchMargin;//交易所多头保证金
@property(nonatomic,copy) NSString *ShortExchMargin;//交易所空头保证金
@property(nonatomic,copy) NSString *CloseProfit;//平仓盈亏
@property(nonatomic,copy) NSString *FrozenCommission;//冻结的手续费
@property(nonatomic,copy) NSString *Commission;//手续费
@property(nonatomic,copy) NSString *FrozenCash;//冻结的资金
@property(nonatomic,copy) NSString *CashIn;//资金差额
@property(nonatomic,copy) NSString *PositionProfit;//持仓盈亏
@property(nonatomic,copy) NSString *OffsetAmount;//折抵总金额
@property(nonatomic,copy) NSString *LongOffsetAmount;//多头折抵总金额
@property(nonatomic,copy) NSString *ShortOffsetAmount;//空头折抵总金额
@property(nonatomic,copy) NSString *ExchOffsetAmount;//交易所折抵总金额
@property(nonatomic,copy) NSString *LongExchOffsetAmount;//交易所多头折抵总金额
@property(nonatomic,copy) NSString *ShortExchOffsetAmount;//交易所空头折抵总金额
@property(nonatomic,copy) NSString *HedgeFlag;//投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end