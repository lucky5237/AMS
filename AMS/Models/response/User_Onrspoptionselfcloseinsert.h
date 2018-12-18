//期权自对冲录入请求响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspoptionselfcloseinsert : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_InputOptionSelfClose_null;//InputOptionSelfClose是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *OptionSelfCloseRef;//期权自对冲引用
@property(nonatomic,copy) NSString *UserID;//用户代码
@property(nonatomic,strong) NSNumber *Volume;//数量
@property(nonatomic,strong) NSNumber *RequestID;//请求编号
@property(nonatomic,copy) NSString *BusinessUnit;//业务单元
@property(nonatomic,strong) NSNumber *HedgeFlag;//投机套保标志    '1'->投机;'2'->套利;'3'->套保;'5'->做市商;
@property(nonatomic,strong) NSNumber *OptSelfCloseFlag;//期权行权的头寸是否自对冲    '1'->自对冲期权仓位;'2'->保留期权仓位;'3'->自对冲卖方履约后的期货仓位;
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码
@property(nonatomic,copy) NSString *AccountID;//资金账号
@property(nonatomic,copy) NSString *CurrencyID;//币种代码
@property(nonatomic,copy) NSString *ClientID;//交易编码
@property(nonatomic,copy) NSString *IPAddress;//IP地址
@property(nonatomic,copy) NSString *MacAddress;//Mac地址

NS_ASSUME_NONNULL_END
@end