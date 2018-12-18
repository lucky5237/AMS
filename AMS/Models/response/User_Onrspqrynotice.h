//请求查询客户通知响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqrynotice : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_Notice_null;//Notice是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *Content;//消息正文
@property(nonatomic,copy) NSString *SequenceLabel;//经纪公司通知内容序列号

NS_ASSUME_NONNULL_END
@end