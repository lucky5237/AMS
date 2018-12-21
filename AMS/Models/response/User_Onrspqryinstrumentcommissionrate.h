//请求查询合约手续费率响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryinstrumentcommissionrate : NSObject
@property(nonatomic,strong) NSNumber *is_InstrumentCommissionRate_null;//InstrumentCommissionRate是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *InvestorRange;//投资者范围    '1'->所有;'2'->投资者组;'3'->单一投资者;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *OpenRatioByMoney;//开仓手续费率
@property(nonatomic,copy) NSString *OpenRatioByVolume;//开仓手续费
@property(nonatomic,copy) NSString *CloseRatioByMoney;//平仓手续费率
@property(nonatomic,copy) NSString *CloseRatioByVolume;//平仓手续费
@property(nonatomic,copy) NSString *CloseTodayRatioByMoney;//平今手续费率
@property(nonatomic,copy) NSString *CloseTodayRatioByVolume;//平今手续费
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *BizType;//业务类型    '1'->期货;'2'->证券;
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end