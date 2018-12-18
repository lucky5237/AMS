//登出请求响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspuserlogout : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_UserLogout_null;//UserLogout是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *UserID;//用户代码

NS_ASSUME_NONNULL_END
@end