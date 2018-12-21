//执行宣告录入错误回报
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onerrrtnexecorderinsert : NSObject
@property(nonatomic,strong) NSNumber *is_InputExecOrder_null;//InputExecOrder是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *ExecOrderRef;//执行宣告引用
@property(nonatomic,copy) NSString *UserID;//用户代码
@property(nonatomic,strong) NSNumber *Volume;//数量
@property(nonatomic,strong) NSNumber *RequestID;//请求编号
@property(nonatomic,copy) NSString *BusinessUnit;//业务单元
@property(nonatomic,copy) NSString *OffsetFlag;//开平标志    '0'->开仓;'1'->平仓;'2'->强平;'3'->平今;'4'->平昨;'5'->强减;'6'->本地强平;
@property(nonatomic,copy) NSString *HedgeFlag;//投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,copy) NSString *ActionType;//执行类型    '1'->执行;'2'->放弃;
@property(nonatomic,copy) NSString *PosiDirection;//保留头寸申请的持仓方向    '1'->净;'2'->多头;'3'->空头;
@property(nonatomic,copy) NSString *ReservePositionFlag;//期权行权后是否保留期货头寸的标记,该字段已废弃    '0'->保留;'1'->不保留;
@property(nonatomic,copy) NSString *CloseFlag;//期权行权后生成的头寸是否自动平仓    '0'->自动平仓;'1'->免于自动平仓;
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码
@property(nonatomic,copy) NSString *AccountID;//资金账号
@property(nonatomic,copy) NSString *CurrencyID;//币种代码
@property(nonatomic,copy) NSString *ClientID;//交易编码
@property(nonatomic,copy) NSString *IPAddress;//IP地址
@property(nonatomic,copy) NSString *MacAddress;//Mac地址
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息

NS_ASSUME_NONNULL_END
@end