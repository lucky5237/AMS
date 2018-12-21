//资金账户口令更新请求
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Reqtradingaccountpasswordupdate : NSObject
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *AccountID;//投资者帐号
@property(nonatomic,copy) NSString *OldPassword;//原来的口令
@property(nonatomic,copy) NSString *NewPassword;//新的口令
@property(nonatomic,copy) NSString *CurrencyID;//币种代码
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号

NS_ASSUME_NONNULL_END
@end