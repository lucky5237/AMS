//客户端认证响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspauthenticate : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_RspAuthenticateField_null;//RspAuthenticateField是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *UserID;//用户代码
@property(nonatomic,copy) NSString *UserProductInfo;//用户端产品信息

NS_ASSUME_NONNULL_END
@end