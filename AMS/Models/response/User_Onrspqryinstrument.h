//请求查询合约响应
#import <Foundation/Foundation.h>
//#import "BGFMDB.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqryinstrument : NSObject
@property(nonatomic,strong) NSNumber *is_Instrument_null;//Instrument是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *InstrumentID;//合约代码
@property(nonatomic,copy) NSString *ExchangeID;//交易所代码
@property(nonatomic,copy) NSString *InstrumentName;//合约名称
@property(nonatomic,copy) NSString *ExchangeInstID;//合约在交易所的代码
@property(nonatomic,copy) NSString *ProductID;//产品代码
@property(nonatomic,copy) NSString *ProductClass;//产品类型    '1'->期货;'2'->期货期权;'3'->组合;'4'->即期;'5'->期转现;'6'->现货期权;
@property(nonatomic,strong) NSNumber *DeliveryYear;//交割年份
@property(nonatomic,strong) NSNumber *DeliveryMonth;//交割月
@property(nonatomic,strong) NSNumber *MaxMarketOrderVolume;//市价单最大下单量
@property(nonatomic,strong) NSNumber *MinMarketOrderVolume;//市价单最小下单量
@property(nonatomic,strong) NSNumber *MaxLimitOrderVolume;//限价单最大下单量
@property(nonatomic,strong) NSNumber *MinLimitOrderVolume;//限价单最小下单量
@property(nonatomic,strong) NSNumber *VolumeMultiple;//合约数量乘数
@property(nonatomic,copy) NSString *PriceTick;//最小变动价位
@property(nonatomic,copy) NSString *CreateDate;//创建日
@property(nonatomic,copy) NSString *OpenDate;//上市日
@property(nonatomic,copy) NSString *ExpireDate;//到期日
@property(nonatomic,copy) NSString *StartDelivDate;//开始交割日
@property(nonatomic,copy) NSString *EndDelivDate;//结束交割日
@property(nonatomic,copy) NSString *InstLifePhase;//合约生命周期状态    '0'->未上市;'1'->上市;'2'->停牌;'3'->到期;
@property(nonatomic,strong) NSNumber *IsTrading;//当前是否交易
@property(nonatomic,copy) NSString *PositionType;//持仓类型    '1'->净持仓;'2'->综合持仓;
@property(nonatomic,copy) NSString *PositionDateType;//持仓日期类型    '1'->使用历史持仓;'2'->不使用历史持仓;
@property(nonatomic,copy) NSString *LongMarginRatio;//多头保证金率
@property(nonatomic,copy) NSString *ShortMarginRatio;//空头保证金率
@property(nonatomic,copy) NSString *MaxMarginSideAlgorithm;//是否使用大额单边保证金算法    '0'->不使用大额单边保证金算法;'1'->使用大额单边保证金算法;
@property(nonatomic,copy) NSString *UnderlyingInstrID;//基础商品代码
@property(nonatomic,copy) NSString *StrikePrice;//执行价
@property(nonatomic,copy) NSString *OptionsType;//期权类型    '1'->看涨;'2'->看跌;
@property(nonatomic,copy) NSString *UnderlyingMultiple;//合约基础商品乘数
@property(nonatomic,copy) NSString *CombinationType;//组合类型    '0'->期货组合;'1'->垂直价差BUL;'2'->垂直价差BER;'3'->跨式组合;'4'->宽跨式组合;'5'->备兑组合;'6'->时间价差组合;
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end
