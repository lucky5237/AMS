//投资者结算结果确认响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspsettlementinfoconfirm : NSObject
@property(nonatomic,strong) NSNumber *is_SettlementInfoConfirm_null;//SettlementInfoConfirm是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *ConfirmDate;//确认日期
@property(nonatomic,copy) NSString *ConfirmTime;//确认时间
@property(nonatomic,strong) NSNumber *SettlementID;//结算编号
@property(nonatomic,copy) NSString *AccountID;//投资者帐号
@property(nonatomic,copy) NSString *CurrencyID;//币种代码
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end