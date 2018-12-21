//请求查询产品组
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Reqqryproductgroup : NSObject
@property(nonatomic,copy) NSString *ProductID;//产品代码
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号

NS_ASSUME_NONNULL_END
@end