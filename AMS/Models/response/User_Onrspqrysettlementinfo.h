//请求查询投资者结算结果响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqrysettlementinfo : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_SettlementInfo_null;//SettlementInfo是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *TradingDay;//交易日
@property(nonatomic,strong) NSNumber *SettlementID;//结算编号
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,strong) NSNumber *SequenceNo;//序号
@property(nonatomic,copy) NSString *Content;//消息正文
@property(nonatomic,copy) NSString *AccountID;//投资者帐号
@property(nonatomic,copy) NSString *CurrencyID;//币种代码

NS_ASSUME_NONNULL_END
@end