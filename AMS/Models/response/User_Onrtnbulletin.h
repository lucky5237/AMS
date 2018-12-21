//交易所公告通知
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrtnbulletin : NSObject
@property(nonatomic,strong) NSNumber *is_Bulletin_null;//Bulletin是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *TradingDay;//交易日
@property(nonatomic,strong) NSNumber *BulletinID;//公告编号
@property(nonatomic,strong) NSNumber *SequenceNo;//序列号
@property(nonatomic,copy) NSString *NewsType;//公告类型
@property(nonatomic,copy) NSString *NewsUrgency;//紧急程度
@property(nonatomic,copy) NSString *SendTime;//发送时间
@property(nonatomic,copy) NSString *Abstract;//消息摘要
@property(nonatomic,copy) NSString *ComeFrom;//消息来源
@property(nonatomic,copy) NSString *Content;//消息正文
@property(nonatomic,copy) NSString *URLLink;//WEB地址
@property(nonatomic,copy) NSString *MarketID;//市场代码

NS_ASSUME_NONNULL_END
@end