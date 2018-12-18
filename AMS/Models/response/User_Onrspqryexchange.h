//请求查询交易所响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryexchange : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_Exchange_null;//Exchange是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *ExchangeName;//交易所名称
@property(nonatomic,strong) NSNumber *ExchangeProperty;//交易所属性    '0'->正常;'1'->根据成交生成报单;

NS_ASSUME_NONNULL_END
@end