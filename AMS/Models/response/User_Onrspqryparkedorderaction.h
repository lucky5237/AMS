//请求查询预埋撤单响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryparkedorderaction : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_ParkedOrderAction_null;//ParkedOrderAction是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,strong) NSNumber *OrderActionRef;//报单操作引用
@property(nonatomic,copy) NSString *OrderRef;//报单引用
@property(nonatomic,strong) NSNumber *RequestID;//请求编号
@property(nonatomic,strong) NSNumber *FrontID;//前置编号
@property(nonatomic,strong) NSNumber *SessionID;//会话编号
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *OrderSysID;//报单编号
@property(nonatomic,strong) NSNumber *ActionFlag;//操作标志    '0'->删除;'3'->修改;
@property(nonatomic,strong) NSNumber *LimitPrice;//价格
@property(nonatomic,strong) NSNumber *VolumeChange;//数量变化
@property(nonatomic,copy) NSString *UserID;//用户代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *ParkedOrderActionID;//预埋撤单单编号
@property(nonatomic,strong) NSNumber *UserType;//用户类型    '0'->投资者;'1'->操作员;'2'->管理员;
@property(nonatomic,strong) NSNumber *Status;//预埋撤单状态    '1'->未发送;'2'->已发送;'3'->已删除;
@property(nonatomic,strong) NSNumber *ErrorID;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg;//错误信息
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码
@property(nonatomic,copy) NSString *IPAddress;//IP地址
@property(nonatomic,copy) NSString *MacAddress;//Mac地址

NS_ASSUME_NONNULL_END
@end