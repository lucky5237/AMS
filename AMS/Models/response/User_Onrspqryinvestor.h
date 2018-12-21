//请求查询投资者响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryinvestor : NSObject
@property(nonatomic,strong) NSNumber *is_Investor_null;//Investor是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *InvestorID;//投资者代码
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *InvestorGroupID;//投资者分组代码
@property(nonatomic,copy) NSString *InvestorName;//投资者名称
@property(nonatomic,copy) NSString *IdentifiedCardType;//证件类型    '0'->组织机构代码;'1'->中国公民身份证;'2'->军官证;'3'->警官证;'4'->士兵证;'5'->户口簿;'6'->护照;'7'->台胞证;'8'->回乡证;'9'->营业执照号;'A'->税务登记号/当地纳税ID;'B'->港澳居民来往内地通行证;'C'->台湾居民来往大陆通行证;'D'->驾照;'F'->当地社保ID;'G'->当地身份证;'H'->商业登记证;'I'->港澳永久性居民身份证;'J'->人行开户许可证;'x'->其他证件;
@property(nonatomic,copy) NSString *IdentifiedCardNo;//证件号码
@property(nonatomic,strong) NSNumber *IsActive;//是否活跃
@property(nonatomic,copy) NSString *Telephone;//联系电话
@property(nonatomic,copy) NSString *Address;//通讯地址
@property(nonatomic,copy) NSString *OpenDate;//开户日期
@property(nonatomic,copy) NSString *Mobile;//手机
@property(nonatomic,copy) NSString *CommModelID;//手续费率模板代码
@property(nonatomic,copy) NSString *MarginModelID;//保证金率模板代码
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end