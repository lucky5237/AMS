//请求查询二级代理商资金校验模式
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Reqqrysecagentcheckmode : NSObject
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号

NS_ASSUME_NONNULL_END
@end