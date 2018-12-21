//请求查询交易通知响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqrytradingnotice : NSObject
@property(nonatomic,strong) NSNumber *is_TradingNotice_null;//TradingNotice是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorRange;//投资者范围    '1'->所有;'2'->投资者组;'3'->单一投资者;
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *(null);//(null)
@property(nonatomic,copy) NSString *UserID;//用户代码
@property(nonatomic,copy) NSString *SendTime;//发送时间
@property(nonatomic,strong) NSNumber *SequenceNo;//序列号
@property(nonatomic,copy) NSString *FieldContent;//消息正文
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end