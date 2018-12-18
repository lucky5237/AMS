//查询保证金监管系统经纪公司资金账户密钥响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqrycfmmctradingaccountkey : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_CFMMCTradingAccountKey_null;//CFMMCTradingAccountKey是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *ParticipantID;//经纪公司统一编码
@property(nonatomic,copy) NSString *AccountID;//投资者帐号
@property(nonatomic,strong) NSNumber *KeyID;//密钥编号
@property(nonatomic,copy) NSString *CurrentKey;//动态密钥

NS_ASSUME_NONNULL_END
@end