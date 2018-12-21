//报单操作错误回报
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onerrrtnorderaction : NSObject
@property(nonatomic,strong) NSNumber *is_OrderAction_null;//OrderAction是否为null    1->是null;0->不是null;
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
@property(nonatomic,copy) NSString *ActionDate;//操作日期
@property(nonatomic,copy) NSString *ActionTime;//操作时间
@property(nonatomic,copy) NSString *TraderID;//交易所交易员代码
@property(nonatomic,strong) NSNumber *InstallID;//安装编号
@property(nonatomic,copy) NSString *OrderLocalID;//本地报单编号
@property(nonatomic,copy) NSString *ActionLocalID;//操作本地编号
@property(nonatomic,copy) NSString *ParticipantID;//会员代码
@property(nonatomic,copy) NSString *ClientID;//客户代码
@property(nonatomic,copy) NSString *BusinessUnit;//业务单元
@property(nonatomic,copy) NSString *OrderActionStatus;//报单操作状态    'a'->已经提交;'b'->已经接受;'c'->已经被拒绝;
@property(nonatomic,copy) NSString *UserID;//用户代码
@property(nonatomic,copy) NSString *StatusMsg;//状态信息
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *BranchID;//营业部编号
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码
@property(nonatomic,copy) NSString *IPAddress;//IP地址
@property(nonatomic,copy) NSString *MacAddress;//Mac地址
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息

NS_ASSUME_NONNULL_END
@end