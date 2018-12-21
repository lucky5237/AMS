//请求查询询价响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryforquote : NSObject
@property(nonatomic,strong) NSNumber *is_ForQuote_null;//ForQuote是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *ForQuoteRef;//询价引用
@property(nonatomic,copy) NSString *UserID;//用户代码
@property(nonatomic,copy) NSString *ForQuoteLocalID;//本地询价编号
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *ParticipantID;//会员代码
@property(nonatomic,copy) NSString *ClientID;//客户代码
@property(nonatomic,copy) NSString *ExchangeInstID;//合约在交易所的代码
@property(nonatomic,copy) NSString *TraderID;//交易所交易员代码
@property(nonatomic,strong) NSNumber *InstallID;//安装编号
@property(nonatomic,copy) NSString *InsertDate;//报单日期
@property(nonatomic,copy) NSString *InsertTime;//插入时间
@property(nonatomic,copy) NSString *ForQuoteStatus;//询价状态    'a'->已经提交;'b'->已经接受;'c'->已经被拒绝;
@property(nonatomic,strong) NSNumber *FrontID;//前置编号
@property(nonatomic,strong) NSNumber *SessionID;//会话编号
@property(nonatomic,copy) NSString *StatusMsg;//状态信息
@property(nonatomic,copy) NSString *ActiveUserID;//操作用户代码
@property(nonatomic,strong) NSNumber *BrokerForQutoSeq;//经纪公司询价编号
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