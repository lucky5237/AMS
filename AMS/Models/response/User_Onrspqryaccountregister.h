//请求查询银期签约关系响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryaccountregister : NSObject
@property(nonatomic,strong) NSNumber *is_Accountregister_null;//Accountregister是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *TradeDay;//交易日期
@property(nonatomic,copy) NSString *BankID;//银行编码
@property(nonatomic,copy) NSString *BankBranchID;//银行分支机构编码
@property(nonatomic,copy) NSString *BankAccount;//银行帐号
@property(nonatomic,copy) NSString *BrokerID;//期货公司编码
@property(nonatomic,copy) NSString *BrokerBranchID;//期货公司分支机构编码
@property(nonatomic,copy) NSString *AccountID;//投资者帐号
@property(nonatomic,copy) NSString *IdCardType;//证件类型    '0'->组织机构代码;'1'->中国公民身份证;'2'->军官证;'3'->警官证;'4'->士兵证;'5'->户口簿;'6'->护照;'7'->台胞证;'8'->回乡证;'9'->营业执照号;'A'->税务登记号/当地纳税ID;'B'->港澳居民来往内地通行证;'C'->台湾居民来往大陆通行证;'D'->驾照;'F'->当地社保ID;'G'->当地身份证;'H'->商业登记证;'I'->港澳永久性居民身份证;'J'->人行开户许可证;'x'->其他证件;
@property(nonatomic,copy) NSString *IdentifiedCardNo;//证件号码
@property(nonatomic,copy) NSString *CustomerName;//客户姓名
@property(nonatomic,copy) NSString *CurrencyID;//币种代码
@property(nonatomic,copy) NSString *OpenOrDestroy;//开销户类别    '1'->开户;'0'->销户;
@property(nonatomic,copy) NSString *RegDate;//签约日期
@property(nonatomic,copy) NSString *OutDate;//解约日期
@property(nonatomic,strong) NSNumber *TID;//交易ID
@property(nonatomic,copy) NSString *CustType;//客户类型    '0'->自然人;'1'->机构户;
@property(nonatomic,copy) NSString *BankAccType;//银行帐号类型    '1'->银行存折;'2'->储蓄卡;'3'->信用卡;
@property(nonatomic,copy) NSString *LongCustomerName;//长客户姓名
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end