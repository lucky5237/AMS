//请求查询转帐银行响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqrytransferbank : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_TransferBank_null;//TransferBank是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BankID;//银行代码
@property(nonatomic,copy) NSString *BankBrchID;//银行分中心代码
@property(nonatomic,copy) NSString *BankName;//银行名称
@property(nonatomic,strong) NSNumber *IsActive;//是否活跃

NS_ASSUME_NONNULL_END
@end