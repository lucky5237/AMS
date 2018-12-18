//请求查询产品报价汇率
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryproductexchrate : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_ProductExchRate_null;//ProductExchRate是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *ProductID;//产品代码
@property(nonatomic,copy) NSString *QuoteCurrencyID;//报价币种类型
@property(nonatomic,strong) NSNumber *ExchangeRate;//汇率
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码

NS_ASSUME_NONNULL_END
@end