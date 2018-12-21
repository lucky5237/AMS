//请求查询期权自对冲
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Reqqryoptionselfclose : NSObject
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *OptionSelfCloseSysID;//期权自对冲编号
@property(nonatomic,copy) NSString *InsertTimeStart;//开始时间
@property(nonatomic,copy) NSString *InsertTimeEnd;//结束时间
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号

NS_ASSUME_NONNULL_END
@end