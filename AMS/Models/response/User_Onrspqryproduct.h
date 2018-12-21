//请求查询产品响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryproduct : NSObject
@property(nonatomic,strong) NSNumber *is_Product_null;//Product是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *ProductID;//产品代码
@property(nonatomic,copy) NSString *ProductName;//产品名称
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *ProductClass;//产品类型    '1'->期货;'2'->期货期权;'3'->组合;'4'->即期;'5'->期转现;'6'->现货期权;
@property(nonatomic,strong) NSNumber *VolumeMultiple;//合约数量乘数
@property(nonatomic,copy) NSString *PriceTick;//最小变动价位
@property(nonatomic,strong) NSNumber *MaxMarketOrderVolume;//市价单最大下单量
@property(nonatomic,strong) NSNumber *MinMarketOrderVolume;//市价单最小下单量
@property(nonatomic,strong) NSNumber *MaxLimitOrderVolume;//限价单最大下单量
@property(nonatomic,strong) NSNumber *MinLimitOrderVolume;//限价单最小下单量
@property(nonatomic,copy) NSString *PositionType;//持仓类型    '1'->净持仓;'2'->综合持仓;
@property(nonatomic,copy) NSString *PositionDateType;//持仓日期类型    '1'->使用历史持仓;'2'->不使用历史持仓;
@property(nonatomic,copy) NSString *CloseDealType;//平仓处理类型    '0'->正常;'1'->投机平仓优先;
@property(nonatomic,copy) NSString *TradeCurrencyID;//交易币种类型
@property(nonatomic,copy) NSString *MortgageFundUseRange;//质押资金可用范围    '0'->不能使用;'1'->用于保证金;'2'->用于手续费、盈亏、保证金;
@property(nonatomic,copy) NSString *ExchangeProductID;//交易所产品代码
@property(nonatomic,copy) NSString *UnderlyingMultiple;//合约基础商品乘数
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end