//用户口令更新请求响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspuserpasswordupdate : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_UserPasswordUpdate_null;//UserPasswordUpdate是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *UserID;//用户代码
@property(nonatomic,copy) NSString *OldPassword;//原来的口令
@property(nonatomic,copy) NSString *NewPassword;//新的口令

NS_ASSUME_NONNULL_END
@end