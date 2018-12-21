//请求查询转帐银行
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Reqqrytransferbank : NSObject
@property(nonatomic,copy) NSString *BankID;//银行代码
@property(nonatomic,copy) NSString *BankBrchID;//银行分中心代码
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号

NS_ASSUME_NONNULL_END
@end