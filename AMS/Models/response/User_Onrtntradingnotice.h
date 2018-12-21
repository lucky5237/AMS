//交易通知
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrtntradingnotice : NSObject
@property(nonatomic,strong) NSNumber *is_TradingNoticeInfo_null;//TradingNoticeInfo是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *SendTime;//发送时间
@property(nonatomic,copy) NSString *FieldContent;//消息正文
@property(nonatomic,copy) NSString *(null);//(null)
@property(nonatomic,strong) NSNumber *SequenceNo;//序列号
@property(nonatomic,copy) NSString *InvestUnitID;//投资单元代码

NS_ASSUME_NONNULL_END
@end