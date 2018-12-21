//查询保证金监管系统经纪公司资金账户密钥响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqrycfmmctradingaccountkey : NSObject
@property(nonatomic,strong) NSNumber *is_CFMMCTradingAccountKey_null;//CFMMCTradingAccountKey是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *ParticipantID;//经纪公司统一编码
@property(nonatomic,copy) NSString *AccountID;//投资者帐号
@property(nonatomic,strong) NSNumber *KeyID;//密钥编号
@property(nonatomic,copy) NSString *CurrentKey;//动态密钥
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end