//请求查询汇率响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryexchangerate : NSObject
@property(nonatomic,strong) NSNumber *is_ExchangeRate_null;//ExchangeRate是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *FromCurrencyID;//源币种
@property(nonatomic,copy) NSString *FromCurrencyUnit;//源币种单位数量
@property(nonatomic,copy) NSString *ToCurrencyID;//目标币种
@property(nonatomic,copy) NSString *ExchangeRate;//汇率
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end