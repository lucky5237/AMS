//删除预埋单响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspremoveparkedorder : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_RemoveParkedOrder_null;//RemoveParkedOrder是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *ParkedOrderID;//预埋报单编号
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码

NS_ASSUME_NONNULL_END
@end