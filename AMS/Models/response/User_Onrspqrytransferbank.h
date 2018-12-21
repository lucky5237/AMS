//请求查询转帐银行响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqrytransferbank : NSObject
@property(nonatomic,strong) NSNumber *is_TransferBank_null;//TransferBank是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BankID;//银行代码
@property(nonatomic,copy) NSString *BankBrchID;//银行分中心代码
@property(nonatomic,copy) NSString *BankName;//银行名称
@property(nonatomic,strong) NSNumber *IsActive;//是否活跃
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end