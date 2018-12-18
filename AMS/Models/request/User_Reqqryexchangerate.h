//请求查询汇率
#import "BaseRequestModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Reqqryexchangerate : BaseRequestModel
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *FromCurrencyID;//源币种
@property(nonatomic,copy) NSString *ToCurrencyID;//目标币种

NS_ASSUME_NONNULL_END
@end
