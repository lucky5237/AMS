//请求查询资金账户响应
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqrysecagenttradingaccount : NSObject
@property(nonatomic,strong) NSNumber *is_TradingAccount_null;//TradingAccount是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *AccountID;//投资者帐号
@property(nonatomic,copy) NSString *PreMortgage;//上次质押金额
@property(nonatomic,copy) NSString *PreCredit;//上次信用额度
@property(nonatomic,copy) NSString *PreDeposit;//上次存款额
@property(nonatomic,copy) NSString *PreBalance;//上次结算准备金
@property(nonatomic,copy) NSString *PreMargin;//上次占用的保证金
@property(nonatomic,copy) NSString *InterestBase;//利息基数
@property(nonatomic,copy) NSString *Interest;//利息收入
@property(nonatomic,copy) NSString *Deposit;//入金金额
@property(nonatomic,copy) NSString *Withdraw;//出金金额
@property(nonatomic,copy) NSString *FrozenMargin;//冻结的保证金
@property(nonatomic,copy) NSString *FrozenCash;//冻结的资金
@property(nonatomic,copy) NSString *FrozenCommission;//冻结的手续费
@property(nonatomic,copy) NSString *CurrMargin;//当前保证金总额
@property(nonatomic,copy) NSString *CashIn;//资金差额
@property(nonatomic,copy) NSString *Commission;//手续费
@property(nonatomic,copy) NSString *CloseProfit;//平仓盈亏
@property(nonatomic,copy) NSString *PositionProfit;//持仓盈亏
@property(nonatomic,copy) NSString *Balance;//期货结算准备金
@property(nonatomic,copy) NSString *Available;//可用资金
@property(nonatomic,copy) NSString *WithdrawQuota;//可取资金
@property(nonatomic,copy) NSString *Reserve;//基本准备金
@property(nonatomic,copy) NSString *TradingDay;//交易日
@property(nonatomic,strong) NSNumber *SettlementID;//结算编号
@property(nonatomic,copy) NSString *Credit;//信用额度
@property(nonatomic,copy) NSString *Mortgage;//质押金额
@property(nonatomic,copy) NSString *ExchangeMargin;//交易所保证金
@property(nonatomic,copy) NSString *DeliveryMargin;//投资者交割保证金
@property(nonatomic,copy) NSString *ExchangeDeliveryMargin;//交易所交割保证金
@property(nonatomic,copy) NSString *ReserveBalance;//保底期货结算准备金
@property(nonatomic,copy) NSString *CurrencyID;//币种代码
@property(nonatomic,copy) NSString *PreFundMortgageIn;//上次货币质入金额
@property(nonatomic,copy) NSString *PreFundMortgageOut;//上次货币质出金额
@property(nonatomic,copy) NSString *FundMortgageIn;//货币质入金额
@property(nonatomic,copy) NSString *FundMortgageOut;//货币质出金额
@property(nonatomic,copy) NSString *FundMortgageAvailable;//货币质押余额
@property(nonatomic,copy) NSString *MortgageableFund;//可质押货币金额
@property(nonatomic,copy) NSString *SpecProductMargin;//特殊产品占用保证金
@property(nonatomic,copy) NSString *SpecProductFrozenMargin;//特殊产品冻结保证金
@property(nonatomic,copy) NSString *SpecProductCommission;//特殊产品手续费
@property(nonatomic,copy) NSString *SpecProductFrozenCommission;//特殊产品冻结手续费
@property(nonatomic,copy) NSString *SpecProductPositionProfit;//特殊产品持仓盈亏
@property(nonatomic,copy) NSString *SpecProductCloseProfit;//特殊产品平仓盈亏
@property(nonatomic,copy) NSString *SpecProductPositionProfitByAlg;//根据持仓盈亏算法计算的特殊产品持仓盈亏
@property(nonatomic,copy) NSString *SpecProductExchangeMargin;//特殊产品交易所保证金
@property(nonatomic,copy) NSString *BizType;//业务类型    '1'->期货;'2'->证券;
@property(nonatomic,copy) NSString *FrozenSwap;//延时换汇冻结金额
@property(nonatomic,copy) NSString *RemainSwap;//剩余换汇额度
@property(nonatomic,strong) NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null;
@property(nonatomic,strong) NSNumber *ErrorID_in_RspInfo;//错误代码
@property(nonatomic,copy) NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong) NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong) NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条;

NS_ASSUME_NONNULL_END
@end