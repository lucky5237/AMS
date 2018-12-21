//请求查询二级代理操作员银期权限响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqrysecagentacidmap : NSObject
@property(nonatomic,strong) NSNumber *is_SecAgentACIDMap_null;//SecAgentACIDMap是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *UserID;//用户代码
@property(nonatomic,copy) NSString *AccountID;//资金账户
@property(nonatomic,copy) NSString *CurrencyID;//币种
@property(nonatomic,copy) NSString *BrokerSecAgentID;//境外中介机构资金帐号
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end