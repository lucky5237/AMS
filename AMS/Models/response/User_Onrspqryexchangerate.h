//请求查询汇率响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryexchangerate : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_ExchangeRate_null;//ExchangeRate是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *FromCurrencyID;//源币种
@property(nonatomic,strong) NSNumber *FromCurrencyUnit;//源币种单位数量
@property(nonatomic,copy) NSString *ToCurrencyID;//目标币种
@property(nonatomic,strong) NSNumber *ExchangeRate;//汇率

NS_ASSUME_NONNULL_END
@end