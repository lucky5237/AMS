//登录请求响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspuserlogin : NSObject
@property(nonatomic,strong) NSNumber *is_RspUserLogin_null;//RspUserLogin是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *TradingDay;//交易日
@property(nonatomic,copy) NSString *LoginTime;//登录成功时间
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *UserID;//用户代码
@property(nonatomic,copy) NSString *SystemName;//交易系统名称
@property(nonatomic,strong) NSNumber *FrontID;//前置编号
@property(nonatomic,strong) NSNumber *SessionID;//会话编号
@property(nonatomic,copy) NSString *MaxOrderRef;//最大报单引用
@property(nonatomic,copy) NSString *SHFETime;//上期所时间
@property(nonatomic,copy) NSString *DCETime;//大商所时间
@property(nonatomic,copy) NSString *CZCETime;//郑商所时间
@property(nonatomic,copy) NSString *FFEXTime;//中金所时间
@property(nonatomic,copy) NSString *INETime;//能源中心时间
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end