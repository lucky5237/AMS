//删除预埋撤单响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspremoveparkedorderaction : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_RemoveParkedOrderAction_null;//RemoveParkedOrderAction是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *ParkedOrderActionID;//预埋撤单编号
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码

NS_ASSUME_NONNULL_END
@end