//请求查询二级代理操作员银期权限
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Reqqrysecagentacidmap : NSObject
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *UserID;//用户代码
@property(nonatomic,copy) NSString *AccountID;//资金账户
@property(nonatomic,copy) NSString *CurrencyID;//币种
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号

NS_ASSUME_NONNULL_END
@end