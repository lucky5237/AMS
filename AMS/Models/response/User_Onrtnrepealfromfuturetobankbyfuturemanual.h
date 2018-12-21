//系统运行时期货端手工发起冲正期货转银行请求，银行处理完毕后报盘发回的通知
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrtnrepealfromfuturetobankbyfuturemanual : NSObject
@property(nonatomic,strong) NSNumber *is_RspRepeal_null;//RspRepeal是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *RepealTimeInterval;//冲正时间间隔
@property(nonatomic,strong) NSNumber *RepealedTimes;//已经冲正次数
@property(nonatomic,copy) NSString *BankRepealFlag;//银行冲正标志    '0'->银行无需自动冲正;'1'->银行待自动冲正;'2'->银行已自动冲正;
@property(nonatomic,copy) NSString *BrokerRepealFlag;//期商冲正标志    '0'->期商无需自动冲正;'1'->期商待自动冲正;'2'->期商已自动冲正;
@property(nonatomic,strong) NSNumber *PlateRepealSerial;//被冲正平台流水号
@property(nonatomic,copy) NSString *BankRepealSerial;//被冲正银行流水号
@property(nonatomic,strong) NSNumber *FutureRepealSerial;//被冲正期货流水号
@property(nonatomic,copy) NSString *TradeCode;//业务功能码
@property(nonatomic,copy) NSString *BankID;//银行代码
@property(nonatomic,copy) NSString *BankBranchID;//银行分支机构代码
@property(nonatomic,copy) NSString *BrokerID;//期商代码
@property(nonatomic,copy) NSString *BrokerBranchID;//期商分支机构代码
@property(nonatomic,copy) NSString *TradeDate;//交易日期
@property(nonatomic,copy) NSString *TradeTime;//交易时间
@property(nonatomic,copy) NSString *BankSerial;//银行流水号
@property(nonatomic,copy) NSString *TradingDay;//交易系统日期
@property(nonatomic,strong) NSNumber *PlateSerial;//银期平台消息流水号
@property(nonatomic,copy) NSString *LastFragment;//最后分片标志    '0'->是最后分片;'1'->不是最后分片;
@property(nonatomic,strong) NSNumber *SessionID;//会话号
@property(nonatomic,copy) NSString *CustomerName;//客户姓名
@property(nonatomic,copy) NSString *IdCardType;//证件类型    '0'->组织机构代码;'1'->中国公民身份证;'2'->军官证;'3'->警官证;'4'->士兵证;'5'->户口簿;'6'->护照;'7'->台胞证;'8'->回乡证;'9'->营业执照号;'A'->税务登记号/当地纳税ID;'B'->港澳居民来往内地通行证;'C'->台湾居民来往大陆通行证;'D'->驾照;'F'->当地社保ID;'G'->当地身份证;'H'->商业登记证;'I'->港澳永久性居民身份证;'J'->人行开户许可证;'x'->其他证件;
@property(nonatomic,copy) NSString *IdentifiedCardNo;//证件号码
@property(nonatomic,copy) NSString *CustType;//客户类型    '0'->自然人;'1'->机构户;
@property(nonatomic,copy) NSString *BankAccount;//银行帐号
@property(nonatomic,copy) NSString *BankPassWord;//银行密码
@property(nonatomic,copy) NSString *AccountID;//投资者帐号
@property(nonatomic,copy) NSString *Password;//期货密码
@property(nonatomic,strong) NSNumber *InstallID;//安装编号
@property(nonatomic,strong) NSNumber *FutureSerial;//期货公司流水号
@property(nonatomic,copy) NSString *UserID;//用户标识
@property(nonatomic,copy) NSString *VerifyCertNoFlag;//验证客户证件号码标志    '0'->是;'1'->否;
@property(nonatomic,copy) NSString *CurrencyID;//币种代码
@property(nonatomic,copy) NSString *TradeAmount;//转帐金额
@property(nonatomic,copy) NSString *FutureFetchAmount;//期货可取金额
@property(nonatomic,copy) NSString *FeePayFlag;//费用支付标志    '0'->由受益方支付费用;'1'->由发送方支付费用;'2'->由发送方支付发起的费用，受益方支付接受的费用;
@property(nonatomic,copy) NSString *CustFee;//应收客户费用
@property(nonatomic,copy) NSString *BrokerFee;//应收期货公司费用
@property(nonatomic,copy) NSString *Message;//发送方给接收方的消息
@property(nonatomic,copy) NSString *Digest;//摘要
@property(nonatomic,copy) NSString *BankAccType;//银行帐号类型    '1'->银行存折;'2'->储蓄卡;'3'->信用卡;
@property(nonatomic,copy) NSString *DeviceID;//渠道标志
@property(nonatomic,copy) NSString *BankSecuAccType;//期货单位帐号类型    '1'->银行存折;'2'->储蓄卡;'3'->信用卡;
@property(nonatomic,copy) NSString *BrokerIDByBank;//期货公司银行编码
@property(nonatomic,copy) NSString *BankSecuAcc;//期货单位帐号
@property(nonatomic,copy) NSString *BankPwdFlag;//银行密码标志    '0'->不核对;'1'->明文核对;'2'->密文核对;
@property(nonatomic,copy) NSString *SecuPwdFlag;//期货资金密码核对标志    '0'->不核对;'1'->明文核对;'2'->密文核对;
@property(nonatomic,copy) NSString *OperNo;//交易柜员
@property(nonatomic,strong) NSNumber *RequestID;//请求编号
@property(nonatomic,strong) NSNumber *TID;//交易ID
@property(nonatomic,copy) NSString *TransferStatus;//转账交易状态    '0'->正常;'1'->被冲正;
@property(nonatomic,strong) NSNumber *ErrorID;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg;//错误信息
@property(nonatomic,copy) NSString *LongCustomerName;//长客户姓名

NS_ASSUME_NONNULL_END
@end