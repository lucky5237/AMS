//请求查询申请组合响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqrycombaction : NSObject
@property(nonatomic,strong) NSNumber *is_CombAction_null;//CombAction是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *CombActionRef;//组合引用
@property(nonatomic,copy) NSString *UserID;//用户代码
@property(nonatomic,copy) NSString *Direction;//买卖方向    '0'->买;'1'->卖;
@property(nonatomic,strong) NSNumber *Volume;//数量
@property(nonatomic,copy) NSString *CombDirection;//组合指令方向    '0'->申请组合;'1'->申请拆分;
@property(nonatomic,copy) NSString *HedgeFlag;//投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,copy) NSString *ActionLocalID;//本地申请组合编号
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *ParticipantID;//会员代码
@property(nonatomic,copy) NSString *ClientID;//客户代码
@property(nonatomic,copy) NSString *ExchangeInstID;//合约在交易所的代码
@property(nonatomic,copy) NSString *TraderID;//交易所交易员代码
@property(nonatomic,strong) NSNumber *InstallID;//安装编号
@property(nonatomic,copy) NSString *ActionStatus;//组合状态    'a'->已经提交;'b'->已经接受;'c'->已经被拒绝;
@property(nonatomic,strong) NSNumber *NotifySequence;//报单提示序号
@property(nonatomic,copy) NSString *TradingDay;//交易日
@property(nonatomic,strong) NSNumber *SettlementID;//结算编号
@property(nonatomic,strong) NSNumber *SequenceNo;//序号
@property(nonatomic,strong) NSNumber *FrontID;//前置编号
@property(nonatomic,strong) NSNumber *SessionID;//会话编号
@property(nonatomic,copy) NSString *UserProductInfo;//用户端产品信息
@property(nonatomic,copy) NSString *StatusMsg;//状态信息
@property(nonatomic,copy) NSString *IPAddress;//IP地址
@property(nonatomic,copy) NSString *MacAddress;//Mac地址
@property(nonatomic,copy) NSString *ComTradeID;//组合编号
@property(nonatomic,copy) NSString *BranchID;//营业部编号
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end