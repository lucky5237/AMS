//请求查询转帐银行
#import "BaseRequestModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Reqqrytransferbank : BaseRequestModel
@property(nonatomic,copy) NSString *BankID;//银行代码
@property(nonatomic,copy) NSString *BankBrchID;//银行分中心代码

NS_ASSUME_NONNULL_END
@end
