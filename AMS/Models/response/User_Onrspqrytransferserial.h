//请求查询转帐流水响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqrytransferserial : NSObject
@property(nonatomic,strong) NSNumber *is_TransferSerial_null;//TransferSerial是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *PlateSerial;//平台流水号
@property(nonatomic,copy) NSString *TradeDate;//交易发起方日期
@property(nonatomic,copy) NSString *TradingDay;//交易日期
@property(nonatomic,copy) NSString *TradeTime;//交易时间
@property(nonatomic,copy) NSString *TradeCode;//交易代码
@property(nonatomic,strong) NSNumber *SessionID;//会话编号
@property(nonatomic,copy) NSString *BankID;//银行编码
@property(nonatomic,copy) NSString *BankBranchID;//银行分支机构编码
@property(nonatomic,copy) NSString *BankAccType;//银行帐号类型    '1'->银行存折;'2'->储蓄卡;'3'->信用卡;
@property(nonatomic,copy) NSString *BankAccount;//银行帐号
@property(nonatomic,copy) NSString *BankSerial;//银行流水号
@property(nonatomic,copy) NSString *BrokerID;//期货公司编码
@property(nonatomic,copy) NSString *BrokerBranchID;//期商分支机构代码
@property(nonatomic,copy) NSString *FutureAccType;//期货公司帐号类型    '1'->银行存折;'2'->储蓄卡;'3'->信用卡;
@property(nonatomic,copy) NSString *AccountID;//投资者帐号
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,strong) NSNumber *FutureSerial;//期货公司流水号
@property(nonatomic,copy) NSString *IdCardType;//证件类型    '0'->组织机构代码;'1'->中国公民身份证;'2'->军官证;'3'->警官证;'4'->士兵证;'5'->户口簿;'6'->护照;'7'->台胞证;'8'->回乡证;'9'->营业执照号;'A'->税务登记号/当地纳税ID;'B'->港澳居民来往内地通行证;'C'->台湾居民来往大陆通行证;'D'->驾照;'F'->当地社保ID;'G'->当地身份证;'H'->商业登记证;'I'->港澳永久性居民身份证;'J'->人行开户许可证;'x'->其他证件;
@property(nonatomic,copy) NSString *IdentifiedCardNo;//证件号码
@property(nonatomic,copy) NSString *CurrencyID;//币种代码
@property(nonatomic,copy) NSString *TradeAmount;//交易金额
@property(nonatomic,copy) NSString *CustFee;//应收客户费用
@property(nonatomic,copy) NSString *BrokerFee;//应收期货公司费用
@property(nonatomic,copy) NSString *AvailabilityFlag;//有效标志    '0'->未确认;'1'->有效;'2'->冲正;
@property(nonatomic,copy) NSString *OperatorCode;//操作员
@property(nonatomic,copy) NSString *BankNewAccount;//新银行帐号
@property(nonatomic,strong) NSNumber *ErrorID;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg;//错误信息
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end