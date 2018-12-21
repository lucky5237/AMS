//报单操作请求响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrsporderaction : NSObject
@property(nonatomic,strong) NSNumber *is_InputOrderAction_null;//InputOrderAction是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,strong) NSNumber *OrderActionRef;//报单操作引用
@property(nonatomic,copy) NSString *OrderRef;//报单引用
@property(nonatomic,strong) NSNumber *RequestID;//请求编号
@property(nonatomic,strong) NSNumber *FrontID;//前置编号
@property(nonatomic,strong) NSNumber *SessionID;//会话编号
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *OrderSysID;//报单编号
@property(nonatomic,copy) NSString *ActionFlag;//操作标志    '0'->删除;'3'->修改;
@property(nonatomic,copy) NSString *LimitPrice;//价格
@property(nonatomic,strong) NSNumber *VolumeChange;//数量变化
@property(nonatomic,copy) NSString *UserID;//用户代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码
@property(nonatomic,copy) NSString *IPAddress;//IP地址
@property(nonatomic,copy) NSString *MacAddress;//Mac地址
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end