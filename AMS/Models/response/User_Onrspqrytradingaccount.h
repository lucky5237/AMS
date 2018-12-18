//请求查询资金账户响应
#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User_Onrspqrytradingaccount : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_TradingAccount_null;//TradingAccount是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *AccountID;//投资者帐号
@property(nonatomic,strong) NSNumber *PreMortgage;//上次质押金额
@property(nonatomic,strong) NSNumber *PreCredit;//上次信用额度
@property(nonatomic,strong) NSNumber *PreDeposit;//上次存款额
@property(nonatomic,strong) NSNumber *PreBalance;//上次结算准备金
@property(nonatomic,strong) NSNumber *PreMargin;//上次占用的保证金
@property(nonatomic,strong) NSNumber *InterestBase;//利息基数
@property(nonatomic,strong) NSNumber *Interest;//利息收入
@property(nonatomic,strong) NSNumber *Deposit;//入金金额
@property(nonatomic,strong) NSNumber *Withdraw;//出金金额
@property(nonatomic,strong) NSNumber *FrozenMargin;//冻结的保证金
@property(nonatomic,strong) NSNumber *FrozenCash;//冻结的资金
@property(nonatomic,strong) NSNumber *FrozenCommission;//冻结的手续费
@property(nonatomic,strong) NSNumber *CurrMargin;//当前保证金总额
@property(nonatomic,strong) NSNumber *CashIn;//资金差额
@property(nonatomic,strong) NSNumber *Commission;//手续费
@property(nonatomic,strong) NSNumber *CloseProfit;//平仓盈亏
@property(nonatomic,strong) NSNumber *PositionProfit;//持仓盈亏
@property(nonatomic,strong) NSNumber *Balance;//期货结算准备金
@property(nonatomic,strong) NSNumber *Available;//可用资金
@property(nonatomic,strong) NSNumber *WithdrawQuota;//可取资金
@property(nonatomic,strong) NSNumber *Reserve;//基本准备金
@property(nonatomic,copy) NSString *TradingDay;//交易日
@property(nonatomic,strong) NSNumber *SettlementID;//结算编号
@property(nonatomic,strong) NSNumber *Credit;//信用额度
@property(nonatomic,strong) NSNumber *Mortgage;//质押金额
@property(nonatomic,strong) NSNumber *ExchangeMargin;//交易所保证金
@property(nonatomic,strong) NSNumber *DeliveryMargin;//投资者交割保证金
@property(nonatomic,strong) NSNumber *ExchangeDeliveryMargin;//交易所交割保证金
@property(nonatomic,strong) NSNumber *ReserveBalance;//保底期货结算准备金
@property(nonatomic,copy) NSString *CurrencyID;//币种代码
@property(nonatomic,strong) NSNumber *PreFundMortgageIn;//上次货币质入金额
@property(nonatomic,strong) NSNumber *PreFundMortgageOut;//上次货币质出金额
@property(nonatomic,strong) NSNumber *FundMortgageIn;//货币质入金额
@property(nonatomic,strong) NSNumber *FundMortgageOut;//货币质出金额
@property(nonatomic,strong) NSNumber *FundMortgageAvailable;//货币质押余额
@property(nonatomic,strong) NSNumber *MortgageableFund;//可质押货币金额
@property(nonatomic,strong) NSNumber *SpecProductMargin;//特殊产品占用保证金
@property(nonatomic,strong) NSNumber *SpecProductFrozenMargin;//特殊产品冻结保证金
@property(nonatomic,strong) NSNumber *SpecProductCommission;//特殊产品手续费
@property(nonatomic,strong) NSNumber *SpecProductFrozenCommission;//特殊产品冻结手续费
@property(nonatomic,strong) NSNumber *SpecProductPositionProfit;//特殊产品持仓盈亏
@property(nonatomic,strong) NSNumber *SpecProductCloseProfit;//特殊产品平仓盈亏
@property(nonatomic,strong) NSNumber *SpecProductPositionProfitByAlg;//根据持仓盈亏算法计算的特殊产品持仓盈亏
@property(nonatomic,strong) NSNumber *SpecProductExchangeMargin;//特殊产品交易所保证金
@property(nonatomic,strong) NSNumber *BizType;//业务类型    '1'->期货;'2'->证券;
@property(nonatomic,strong) NSNumber *FrozenSwap;//延时换汇冻结金额
@property(nonatomic,strong) NSNumber *RemainSwap;//剩余换汇额度

NS_ASSUME_NONNULL_END
@end