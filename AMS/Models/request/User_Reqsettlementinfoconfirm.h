//投资者结算结果确认
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Reqsettlementinfoconfirm : NSObject
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *ConfirmDate;//确认日期
@property(nonatomic,copy) NSString *ConfirmTime;//确认时间
@property(nonatomic,strong) NSNumber *SettlementID;//结算编号
@property(nonatomic,copy) NSString *AccountID;//投资者帐号
@property(nonatomic,copy) NSString *CurrencyID;//币种代码
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号

NS_ASSUME_NONNULL_END
@end