//保证金监控中心用户令牌
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrtncfmmctradingaccounttoken : NSObject
@property(nonatomic,strong) NSNumber *is_CFMMCTradingAccountToken_null;//CFMMCTradingAccountToken是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *ParticipantID;//经纪公司统一编码
@property(nonatomic,copy) NSString *AccountID;//投资者帐号
@property(nonatomic,strong) NSNumber *KeyID;//密钥编号
@property(nonatomic,copy) NSString *Token;//动态令牌

NS_ASSUME_NONNULL_END
@end