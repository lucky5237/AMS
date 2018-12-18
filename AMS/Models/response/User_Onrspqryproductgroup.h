//请求查询产品组
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryproductgroup : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_ProductGroup_null;//ProductGroup是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *ProductID;//产品代码
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *ProductGroupID;//产品组代码

NS_ASSUME_NONNULL_END
@end