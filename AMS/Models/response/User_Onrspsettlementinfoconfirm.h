//投资者结算结果确认响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspsettlementinfoconfirm : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_SettlementInfoConfirm_null;//SettlementInfoConfirm是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *ConfirmDate;//确认日期
@property(nonatomic,copy) NSString *ConfirmTime;//确认时间
@property(nonatomic,strong) NSNumber *SettlementID;//结算编号
@property(nonatomic,copy) NSString *AccountID;//投资者帐号
@property(nonatomic,copy) NSString *CurrencyID;//币种代码

NS_ASSUME_NONNULL_END
@end