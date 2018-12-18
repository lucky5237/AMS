//请求查询产品
#import "BaseRequestModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Reqqryproduct : BaseRequestModel
@property(nonatomic,copy) NSString *ProductID;//产品代码
@property(nonatomic,strong) NSNumber *ProductClass;//产品类型    '1'->期货;'2'->期货期权;'3'->组合;'4'->即期;'5'->期转现;'6'->现货期权;
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码

NS_ASSUME_NONNULL_END
@end
