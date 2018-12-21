//期权自对冲通知
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrtnoptionselfclose : NSObject
@property(nonatomic,strong) NSNumber *is_OptionSelfClose_null;//OptionSelfClose是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *OptionSelfCloseRef;//期权自对冲引用
@property(nonatomic,copy) NSString *UserID;//用户代码
@property(nonatomic,strong) NSNumber *Volume;//数量
@property(nonatomic,strong) NSNumber *RequestID;//请求编号
@property(nonatomic,copy) NSString *BusinessUnit;//业务单元
@property(nonatomic,copy) NSString *HedgeFlag;//投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,copy) NSString *OptSelfCloseFlag;//期权行权的头寸是否自对冲    '1'->自对冲期权仓位;'2'->保留期权仓位;'3'->自对冲卖方履约后的期货仓位;
@property(nonatomic,copy) NSString *OptionSelfCloseLocalID;//本地期权自对冲编号
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *ParticipantID;//会员代码
@property(nonatomic,copy) NSString *ClientID;//客户代码
@property(nonatomic,copy) NSString *ExchangeInstID;//合约在交易所的代码
@property(nonatomic,copy) NSString *TraderID;//交易所交易员代码
@property(nonatomic,strong) NSNumber *InstallID;//安装编号
@property(nonatomic,copy) NSString *OrderSubmitStatus;//期权自对冲提交状态    '0'->已经提交;'1'->撤单已经提交;'2'->修改已经提交;'3'->已经接受;'4'->报单已经被拒绝;'5'->撤单已经被拒绝;'6'->改单已经被拒绝;
@property(nonatomic,strong) NSNumber *NotifySequence;//报单提示序号
@property(nonatomic,copy) NSString *TradingDay;//交易日
@property(nonatomic,strong) NSNumber *SettlementID;//结算编号
@property(nonatomic,copy) NSString *OptionSelfCloseSysID;//期权自对冲编号
@property(nonatomic,copy) NSString *InsertDate;//报单日期
@property(nonatomic,copy) NSString *InsertTime;//插入时间
@property(nonatomic,copy) NSString *CancelTime;//撤销时间
@property(nonatomic,copy) NSString *ExecResult;//自对冲结果    'n'->没有执行;'c'->已经取消;'0'->执行成功;'1'->期权持仓不够;'2'->资金不够;'3'->会员不存在;'4'->客户不存在;'6'->合约不存在;'7'->没有执行权限;'8'->不合理的数量;'9'->没有足够的历史成交;'a'->未知;
@property(nonatomic,copy) NSString *ClearingPartID;//结算会员编号
@property(nonatomic,strong) NSNumber *SequenceNo;//序号
@property(nonatomic,strong) NSNumber *FrontID;//前置编号
@property(nonatomic,strong) NSNumber *SessionID;//会话编号
@property(nonatomic,copy) NSString *UserProductInfo;//用户端产品信息
@property(nonatomic,copy) NSString *StatusMsg;//状态信息
@property(nonatomic,copy) NSString *ActiveUserID;//操作用户代码
@property(nonatomic,strong) NSNumber *BrokerOptionSelfCloseSeq;//经纪公司报单编号
@property(nonatomic,copy) NSString *BranchID;//营业部编号
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码
@property(nonatomic,copy) NSString *AccountID;//资金账号
@property(nonatomic,copy) NSString *CurrencyID;//币种代码
@property(nonatomic,copy) NSString *IPAddress;//IP地址
@property(nonatomic,copy) NSString *MacAddress;//Mac地址

NS_ASSUME_NONNULL_END
@end