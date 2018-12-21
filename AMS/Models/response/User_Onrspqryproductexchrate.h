//请求查询产品报价汇率
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryproductexchrate : NSObject
@property(nonatomic,strong) NSNumber *is_ProductExchRate_null;//ProductExchRate是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *ProductID;//产品代码
@property(nonatomic,copy) NSString *QuoteCurrencyID;//报价币种类型
@property(nonatomic,copy) NSString *ExchangeRate;//汇率
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end