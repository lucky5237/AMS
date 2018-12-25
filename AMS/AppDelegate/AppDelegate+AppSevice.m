//
//  AppDelegate+AppSevice.m
//  AMS
//
//  Created by jianlu on 2018/10/29.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "AppDelegate+AppSevice.h"
#import "MainViewController.h"
#import <ECSlidingViewController.h>
#import <RealReachability.h>
#import <JDStatusBarNotification.h>
#import <Harpy.h>
#import <JLRoutes.h>
#import "CollectQuatationDBModel.h"
#import "AMSSocketManager.h"
#import "ConfigModel.h"
#import "User_Onrtnorder.h"
#import "User_Onrtntrade.h"
#import "User_Onrspqryinvestorposition.h"
#import "User_Reqqryinvestorposition.h"
#import "InstrumentDBModel.h"
#import <JQFMDB.h>
@implementation AppDelegate (AppSevice)

/**
 初始化controller
 */
-(void)setUpRootViewController{
   
    MainViewController *mainVC = [[MainViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = mainVC;
    [self.window makeKeyAndVisible];
}

/**
 监听网络清理
 */
-(void)listenNetworkStatus{
    [GLobalRealReachability startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged:) name:kRealReachabilityChangedNotification object:nil];
}

/**
 版本检查更新
 */
-(void)checkVersion{
    [[Harpy sharedInstance] setPresentingViewController:self.window.rootViewController];
    [[Harpy sharedInstance] checkVersion];
}

/**
 初始化数据库
 */
- (void)initDB{
    //创建数据库
    JQFMDB *db = [JQFMDB shareDatabase:@"ams.sqlite"];
    [db jq_createTable:@"InstrumentDBModel" dicOrModel:[InstrumentDBModel class]];
}

-(void)initConfig{
    self.configModel = [[ConfigModel alloc] init];
    self.configModel.FIELD_KEY_DICTS =@{
                       @"FIELD_KEY_AShortMarginRatioByMoney":@10001,       //套利空头保证金调整系数
                       @"FIELD_KEY_AShortMarginRatioByVolume":@10002,      //套利空头保证金调整系数
                       @"FIELD_KEY_AbandonFrozen":@10003,                  //放弃执行冻结
                       @"FIELD_KEY_Abstract":@10004,                       //消息摘要
                       @"FIELD_KEY_AccountID":@10005,                      //投资者帐号
                       @"FIELD_KEY_AccountSourceType":@10006,              //账户来源
                       @"FIELD_KEY_ActionDate":@10007,                     //操作日期
                       @"FIELD_KEY_ActionDay":@10008,                      //业务日期
                       @"FIELD_KEY_ActionFlag":@10009,                     //操作标志
                       @"FIELD_KEY_ActionLocalID":@10010,                  //操作本地编号
                       @"FIELD_KEY_ActionStatus":@10011,                   //组合状态
                       @"FIELD_KEY_ActionTime":@10012,                     //操作时间
                       @"FIELD_KEY_ActionType":@10013,                     //执行类型
                       @"FIELD_KEY_ActiveTime":@10014,                     //激活时间
                       @"FIELD_KEY_ActiveTraderID":@10015,                 //最后修改交易所交易员代码
                       @"FIELD_KEY_ActiveUserID":@10016,                   //操作用户代码
                       @"FIELD_KEY_Address":@10017,                        //地址
                       @"FIELD_KEY_Algorithm":@10018,                      //盈亏算法
                       @"FIELD_KEY_AllWithoutTrade":@10019,                //本日无仓且无成交客户是否受可提比例限制
                       @"FIELD_KEY_ArbiOpenVolume":@10020,                 //当日套利开仓数量限制
                       @"FIELD_KEY_AskHedgeFlag":@10021,                   //卖投机套保标志
                       @"FIELD_KEY_AskOffsetFlag":@10022,                  //卖开平标志
                       @"FIELD_KEY_AskOrderRef":@10023,                    //衍生卖报单引用
                       @"FIELD_KEY_AskOrderSysID":@10024,                  //卖方报单编号
                       @"FIELD_KEY_AskPrice":@10025,                       //卖价格
                       @"FIELD_KEY_AskPrice1":@10026,                      //申卖价一
                       @"FIELD_KEY_AskPrice2":@10027,                      //申卖价二
                       @"FIELD_KEY_AskPrice3":@10028,                      //申卖价三
                       @"FIELD_KEY_AskPrice4":@10029,                      //申卖价四
                       @"FIELD_KEY_AskPrice5":@10030,                      //申卖价五
                       @"FIELD_KEY_AskVolume":@10031,                      //卖数量
                       @"FIELD_KEY_AskVolume1":@10032,                     //申卖量一
                       @"FIELD_KEY_AskVolume2":@10033,                     //申卖量二
                       @"FIELD_KEY_AskVolume3":@10034,                     //申卖量三
                       @"FIELD_KEY_AskVolume4":@10035,                     //申卖量四
                       @"FIELD_KEY_AskVolume5":@10036,                     //申卖量五
                       @"FIELD_KEY_AuthCode":@10037,                       //认证码
                       @"FIELD_KEY_AuthInfo":@10038,                       //认证信息
                       @"FIELD_KEY_AuthKey":@10039,                        //令牌密钥
                       @"FIELD_KEY_AvailIncludeCloseProfit":@10040,        //可用是否包含平仓盈利
                       @"FIELD_KEY_AvailabilityFlag":@10041,               //有效标志
                       @"FIELD_KEY_Available":@10042,                      //可提资金
                       @"FIELD_KEY_AveragePrice":@10043,                   //当日均价
                       @"FIELD_KEY_Balance":@10044,                        //期货结算准备金
                       @"FIELD_KEY_BalanceAlgorithm":@10045,               //权益算法
                       @"FIELD_KEY_BankAccType":@10046,                    //银行帐号类型
                       @"FIELD_KEY_BankAccount":@10047,                    //银行账户
                       @"FIELD_KEY_BankBranchID":@10048,                   //银行分支机构代码
                       @"FIELD_KEY_BankBrchID":@10049,                     //银行分中心代码
                       @"FIELD_KEY_BankFetchAmount":@10050,                //银行可取金额
                       @"FIELD_KEY_BankID":@10051,                         //银行统一标识类型
                       @"FIELD_KEY_BankName":@10052,                       //银行名称
                       @"FIELD_KEY_BankNewAccount":@10053,                 //新银行帐号
                       @"FIELD_KEY_BankPassWord":@10054,                   //银行密码
                       @"FIELD_KEY_BankPwdFlag":@10055,                    //银行密码标志
                       @"FIELD_KEY_BankRepealFlag":@10056,                 //银行冲正标志
                       @"FIELD_KEY_BankRepealSerial":@10057,               //被冲正银行流水号
                       @"FIELD_KEY_BankReserveOpenSeq":@10058,             //预约开户银行流水号
                       @"FIELD_KEY_BankSecuAcc":@10059,                    //期货单位帐号
                       @"FIELD_KEY_BankSecuAccType":@10060,                //期货单位帐号类型
                       @"FIELD_KEY_BankSerial":@10061,                     //银行流水号
                       @"FIELD_KEY_BankUseAmount":@10062,                  //银行可用金额
                       @"FIELD_KEY_BidHedgeFlag":@10063,                   //买投机套保标志
                       @"FIELD_KEY_BidOffsetFlag":@10064,                  //买开平标志
                       @"FIELD_KEY_BidOrderRef":@10065,                    //衍生买报单引用
                       @"FIELD_KEY_BidOrderSysID":@10066,                  //买方报单编号
                       @"FIELD_KEY_BidPrice":@10067,                       //买价格
                       @"FIELD_KEY_BidPrice1":@10068,                      //申买价一
                       @"FIELD_KEY_BidPrice2":@10069,                      //申买价二
                       @"FIELD_KEY_BidPrice3":@10070,                      //申买价三
                       @"FIELD_KEY_BidPrice4":@10071,                      //申买价四
                       @"FIELD_KEY_BidPrice5":@10072,                      //申买价五
                       @"FIELD_KEY_BidVolume":@10073,                      //买数量
                       @"FIELD_KEY_BidVolume1":@10074,                     //申买量一
                       @"FIELD_KEY_BidVolume2":@10075,                     //申买量二
                       @"FIELD_KEY_BidVolume3":@10076,                     //申买量三
                       @"FIELD_KEY_BidVolume4":@10077,                     //申买量四
                       @"FIELD_KEY_BidVolume5":@10078,                     //申买量五
                       @"FIELD_KEY_BizType":@10079,                        //业务类型
                       @"FIELD_KEY_BookDate":@10080,                       //预约开户日期
                       @"FIELD_KEY_BookPsw":@10081,                        //预约开户验证密码
                       @"FIELD_KEY_BranchID":@10082,                       //营业部编号
                       @"FIELD_KEY_BrokerAbbr":@10083,                     //经纪公司简称
                       @"FIELD_KEY_BrokerBranchID":@10084,                 //期商分支机构代码
                       @"FIELD_KEY_BrokerExecOrderSeq":@10085,             //经纪公司报单编号
                       @"FIELD_KEY_BrokerFee":@10086,                      //应收期货公司费用
                       @"FIELD_KEY_BrokerForQutoSeq":@10087,               //经纪公司询价编号
                       @"FIELD_KEY_BrokerFunctionCode":@10088,             //经纪公司功能代码
                       @"FIELD_KEY_BrokerID":@10089,                       //经纪公司代码
                       @"FIELD_KEY_BrokerIDByBank":@10090,                 //期货公司银行编码
                       @"FIELD_KEY_BrokerName":@10091,                     //经纪公司名称
                       @"FIELD_KEY_BrokerOptionSelfCloseSeq":@10092,       //经纪公司报单编号
                       @"FIELD_KEY_BrokerOrderSeq":@10093,                 //经纪公司报单编号
                       @"FIELD_KEY_BrokerQuoteSeq":@10094,                 //经纪公司报价编号
                       @"FIELD_KEY_BrokerRepealFlag":@10095,               //期商冲正标志
                       @"FIELD_KEY_BrokerSecAgentID":@10096,               //境外中介机构资金帐号
                       @"FIELD_KEY_BulletinID":@10097,                     //公告编号
                       @"FIELD_KEY_BusinessUnit":@10098,                   //业务单元
                       @"FIELD_KEY_CZCETime":@10099,                       //郑商所时间
                       @"FIELD_KEY_CancelDate":@10100,                     //注销日期
                       @"FIELD_KEY_CancelTime":@10101,                     //撤销时间
                       @"FIELD_KEY_CashExchangeCode":@10102,               //汇钞标志
                       @"FIELD_KEY_CashIn":@10103,                         //资金差额
                       @"FIELD_KEY_CertCode":@10104,                       //证件号码
                       @"FIELD_KEY_CheckSelfAccount":@10105,               //是否需要校验自己的资金账户
                       @"FIELD_KEY_ClearingPartID":@10106,                 //结算会员编号
                       @"FIELD_KEY_ClientID":@10107,                       //客户代码
                       @"FIELD_KEY_ClientIDType":@10108,                   //交易编码类型
                       @"FIELD_KEY_ClientIPAddress":@10109,                //终端IP地址
                       @"FIELD_KEY_CloseAmount":@10110,                    //平仓金额
                       @"FIELD_KEY_CloseDealType":@10111,                  //平仓处理类型
                       @"FIELD_KEY_CloseFlag":@10112,                      //期权行权后生成的头寸是否自动平仓
                       @"FIELD_KEY_ClosePrice":@10113,                     //今收盘
                       @"FIELD_KEY_CloseProfit":@10114,                    //平仓盈亏
                       @"FIELD_KEY_CloseProfitByDate":@10115,              //逐日盯市平仓盈亏
                       @"FIELD_KEY_CloseProfitByTrade":@10116,             //逐笔对冲平仓盈亏
                       @"FIELD_KEY_CloseRatioByMoney":@10117,              //平仓手续费率
                       @"FIELD_KEY_CloseRatioByVolume":@10118,             //平仓手续费
                       @"FIELD_KEY_CloseTodayRatioByMoney":@10119,         //平今手续费率
                       @"FIELD_KEY_CloseTodayRatioByVolume":@10120,        //平今手续费
                       @"FIELD_KEY_CloseVolume":@10121,                    //平仓量
                       @"FIELD_KEY_ComTradeID":@10122,                     //组合编号
                       @"FIELD_KEY_CombActionRef":@10123,                  //组合引用
                       @"FIELD_KEY_CombDirection":@10124,                  //组合指令方向
                       @"FIELD_KEY_CombHedgeFlag":@10125,                  //组合投机套保标志
                       @"FIELD_KEY_CombInstrumentID":@10126,               //组合持仓合约编码
                       @"FIELD_KEY_CombLongFrozen":@10127,                 //组合多头冻结
                       @"FIELD_KEY_CombOffsetFlag":@10128,                 //组合开平标志
                       @"FIELD_KEY_CombPosition":@10129,                   //组合成交形成的持仓
                       @"FIELD_KEY_CombShortFrozen":@10130,                //组合空头冻结
                       @"FIELD_KEY_CombinationType":@10131,                //组合类型
                       @"FIELD_KEY_ComeFrom":@10132,                       //消息来源
                       @"FIELD_KEY_CommModelID":@10133,                    //手续费率模板代码
                       @"FIELD_KEY_CommModelName":@10134,                  //模板名称
                       @"FIELD_KEY_CommPhaseNo":@10135,                    //通讯时段编号
                       @"FIELD_KEY_Commission":@10136,                     //手续费
                       @"FIELD_KEY_ConfirmDate":@10137,                    //确认日期
                       @"FIELD_KEY_ConfirmTime":@10138,                    //确认时间
                       @"FIELD_KEY_ConnectDate":@10139,                    //完成连接日期
                       @"FIELD_KEY_ConnectRequestDate":@10140,             //发出连接请求的日期
                       @"FIELD_KEY_ConnectRequestTime":@10141,             //发出连接请求的时间
                       @"FIELD_KEY_ConnectTime":@10142,                    //完成连接时间
                       @"FIELD_KEY_Content":@10143,                        //消息正文
                       @"FIELD_KEY_ContingentCondition":@10144,            //触发条件
                       @"FIELD_KEY_CountryCode":@10145,                    //国家代码
                       @"FIELD_KEY_CreateDate":@10146,                     //密钥生成日期
                       @"FIELD_KEY_CreateTime":@10147,                     //密钥生成时间
                       @"FIELD_KEY_Credit":@10148,                         //信用额度
                       @"FIELD_KEY_CurrDate":@10149,                       //当前日期
                       @"FIELD_KEY_CurrDelta":@10150,                      //今虚实度
                       @"FIELD_KEY_CurrMargin":@10151,                     //当前保证金总额
                       @"FIELD_KEY_CurrMillisec":@10152,                   //当前时间（毫秒）
                       @"FIELD_KEY_CurrTime":@10153,                       //当前时间
                       @"FIELD_KEY_CurrencyCode":@10154,                   //货币代码
                       @"FIELD_KEY_CurrencyID":@10155,                     //币种代码
                       @"FIELD_KEY_CurrentKey":@10156,                     //动态密钥
                       @"FIELD_KEY_CustFee":@10157,                        //应收客户费用
                       @"FIELD_KEY_CustType":@10158,                       //客户类型
                       @"FIELD_KEY_CustomerName":@10159,                   //客户姓名
                       @"FIELD_KEY_DCETime":@10160,                        //大商所时间
                       @"FIELD_KEY_DRIdentityID":@10161,                   //交易中心代码
                       @"FIELD_KEY_DataSyncStatus":@10162,                 //数据同步状态
                       @"FIELD_KEY_DelaySwapSeqNo":@10163,                 //延时换汇流水号
                       @"FIELD_KEY_DeliveryMargin":@10164,                 //投资者交割保证金
                       @"FIELD_KEY_DeliveryMonth":@10165,                  //交割月
                       @"FIELD_KEY_DeliveryYear":@10166,                   //交割年份
                       @"FIELD_KEY_Delta":@10167,                          //Delta值
                       @"FIELD_KEY_Deposit":@10168,                        //入金金额
                       @"FIELD_KEY_DepositSeqNo":@10169,                   //出入金流水号，该流水号为银期报盘返回的流水号
                       @"FIELD_KEY_DescrInfoForReturnCode":@10170,         //返回码描述
                       @"FIELD_KEY_DestBrokerID":@10171,                   //目标易用单元代码
                       @"FIELD_KEY_DestDRIdentityID":@10172,               //目标交易中心代码
                       @"FIELD_KEY_DeviceID":@10173,                       //渠道标志
                       @"FIELD_KEY_Digest":@10174,                         //摘要
                       @"FIELD_KEY_Direction":@10175,                      //买卖方向
                       @"FIELD_KEY_Discount":@10176,                       //资金折扣比例
                       @"FIELD_KEY_EMail":@10177,                          //电子邮件
                       @"FIELD_KEY_EndDelivDate":@10178,                   //结束交割日
                       @"FIELD_KEY_EnterReason":@10179,                    //进入本状态原因
                       @"FIELD_KEY_EnterTime":@10180,                      //进入本状态时间
                       @"FIELD_KEY_ErrorID":@10181,                        //错误代码
                       @"FIELD_KEY_ErrorID_in_RspInfo":@10182,             //错误代码
                       @"FIELD_KEY_ErrorMsg":@10183,                       //错误信息
                       @"FIELD_KEY_ErrorMsg_in_RspInfo":@10184,            //错误信息
                       @"FIELD_KEY_EventDate":@10185,                      //事件发生日期
                       @"FIELD_KEY_EventSequenceNo":@10186,                //用户事件序号
                       @"FIELD_KEY_EventTime":@10187,                      //事件发生时间
                       @"FIELD_KEY_ExchFixedMargin":@10188,                //交易所期权合约保证金不变部分
                       @"FIELD_KEY_ExchLongMarginRatioByMoney":@10189,     //交易所多头保证金率
                       @"FIELD_KEY_ExchLongMarginRatioByVolume":@10190,    //交易所多头保证金费
                       @"FIELD_KEY_ExchMargin":@10191,                     //交易所保证金
                       @"FIELD_KEY_ExchMiniMargin":@10192,                 //交易所期权合约最小保证金
                       @"FIELD_KEY_ExchOffsetAmount":@10193,               //交易所折抵总金额
                       @"FIELD_KEY_ExchShortMarginRatioByMoney":@10194,    //交易所空头保证金率
                       @"FIELD_KEY_ExchShortMarginRatioByVolume":@10195,   //交易所空头保证金费
                       @"FIELD_KEY_ExchangeDeliveryMargin":@10196,         //交易所交割保证金
                       @"FIELD_KEY_ExchangeID":@10197,                     //交易所代码
                       @"FIELD_KEY_ExchangeInstID":@10198,                 //合约在交易所的代码
                       @"FIELD_KEY_ExchangeMargin":@10199,                 //交易所保证金
                       @"FIELD_KEY_ExchangeName":@10200,                   //交易所名称
                       @"FIELD_KEY_ExchangeProductID":@10201,              //交易所产品代码
                       @"FIELD_KEY_ExchangeProperty":@10202,               //交易所属性
                       @"FIELD_KEY_ExchangeRate":@10203,                   //汇率
                       @"FIELD_KEY_ExecOrderActionRef":@10204,             //执行宣告操作引用
                       @"FIELD_KEY_ExecOrderLocalID":@10205,               //本地执行宣告编号
                       @"FIELD_KEY_ExecOrderRef":@10206,                   //执行宣告引用
                       @"FIELD_KEY_ExecOrderSysID":@10207,                 //执行宣告操作编号
                       @"FIELD_KEY_ExecResult":@10208,                     //自对冲结果
                       @"FIELD_KEY_ExpireDate":@10209,                     //密码过期时间
                       @"FIELD_KEY_FFEXTime":@10210,                       //中金所时间
                       @"FIELD_KEY_Fax":@10211,                            //传真
                       @"FIELD_KEY_FeePayFlag":@10212,                     //费用支付标志
                       @"FIELD_KEY_FetchAmt":@10213,                       //银行可取余额
                       @"FIELD_KEY_FieldContent":@10214,                   //消息正文
                       @"FIELD_KEY_FileBusinessCode":@10215,               //文件业务功能
                       @"FIELD_KEY_FindMarginRateAlgoID":@10216,           //寻找保证金率算法编号
                       @"FIELD_KEY_FirstOTP":@10217,                       //第一个动态密码
                       @"FIELD_KEY_FixedMargin":@10218,                    //期权合约保证金不变部分
                       @"FIELD_KEY_Flag":@10219,                           //有效标志
                       @"FIELD_KEY_ForQuoteLocalID":@10220,                //本地询价编号
                       @"FIELD_KEY_ForQuoteRef":@10221,                    //询价引用
                       @"FIELD_KEY_ForQuoteStatus":@10222,                 //询价状态
                       @"FIELD_KEY_ForQuoteSysID":@10223,                  //询价编号
                       @"FIELD_KEY_ForQuoteTime":@10224,                   //询价时间
                       @"FIELD_KEY_ForceCloseReason":@10225,               //强平原因
                       @"FIELD_KEY_FromAmount":@10226,                     //源金额
                       @"FIELD_KEY_FromCurrencyID":@10227,                 //源币种
                       @"FIELD_KEY_FromCurrencyUnit":@10228,               //源币种单位数量
                       @"FIELD_KEY_FromFrozenSwap":@10229,                 //源换汇冻结金额(可用冻结)
                       @"FIELD_KEY_FromRemainSwap":@10230,                 //源剩余换汇额度(可提冻结)
                       @"FIELD_KEY_FrontID":@10231,                        //前置编号
                       @"FIELD_KEY_FrozenCash":@10232,                     //冻结的资金
                       @"FIELD_KEY_FrozenCommission":@10233,               //冻结的手续费
                       @"FIELD_KEY_FrozenMargin":@10234,                   //冻结的保证金
                       @"FIELD_KEY_FrozenSwap":@10235,                     //延时换汇冻结金额
                       @"FIELD_KEY_FunctionCode":@10236,                   //功能代码
                       @"FIELD_KEY_FundMortgageAvailable":@10237,          //货币质押余额
                       @"FIELD_KEY_FundMortgageIn":@10238,                 //货币质入金额
                       @"FIELD_KEY_FundMortgageOut":@10239,                //货币质出金额
                       @"FIELD_KEY_FundMortgageRatio":@10240,              //货币质押比率
                       @"FIELD_KEY_FutureAccPwd":@10241,                   //密码
                       @"FIELD_KEY_FutureAccType":@10242,                  //期货公司帐号类型
                       @"FIELD_KEY_FutureAccount":@10243,                  //资金帐号
                       @"FIELD_KEY_FutureFetchAmount":@10244,              //期货可取金额
                       @"FIELD_KEY_FutureID":@10245,                       //期货公司代码
                       @"FIELD_KEY_FuturePwdFlag":@10246,                  //密码标志
                       @"FIELD_KEY_FutureRepealSerial":@10247,             //被冲正期货流水号
                       @"FIELD_KEY_FutureSerial":@10248,                   //期货公司流水号
                       @"FIELD_KEY_GTDDate":@10249,                        //GTD日期
                       @"FIELD_KEY_Gender":@10250,                         //性别
                       @"FIELD_KEY_GroupIP":@10251,                        //组播组IP地址
                       @"FIELD_KEY_GroupPort":@10252,                      //组播组IP端口
                       @"FIELD_KEY_GuarantRatio":@10253,                   //
                       @"FIELD_KEY_HShortMarginRatioByMoney":@10254,       //保值空头保证金调整系数
                       @"FIELD_KEY_HShortMarginRatioByVolume":@10255,      //保值空头保证金调整系数
                       @"FIELD_KEY_HandlePositionAlgoID":@10256,           //持仓处理算法编号
                       @"FIELD_KEY_HandleTradingAccountAlgoID":@10257,     //资金处理算法编号
                       @"FIELD_KEY_HedgeFlag":@10258,                      //投机套保标志
                       @"FIELD_KEY_HighestPrice":@10259,                   //最高价
                       @"FIELD_KEY_INETime":@10260,                        //能源中心时间
                       @"FIELD_KEY_IPAddress":@10261,                      //IP地址
                       @"FIELD_KEY_IPMask":@10262,                         //IP地址掩码
                       @"FIELD_KEY_IdCardType":@10263,                     //证件类型
                       @"FIELD_KEY_IdentifiedCardNo":@10264,               //证件号码
                       @"FIELD_KEY_IdentifiedCardType":@10265,             //证件类型
                       @"FIELD_KEY_IdentityID":@10266,                     //交易中心代码
                       @"FIELD_KEY_ImplyLevel":@10267,                     //派生层数
                       @"FIELD_KEY_IncludeCloseProfit":@10268,             //可提是否包含平仓盈利
                       @"FIELD_KEY_InputPrice":@10269,                     //期权合约报价
                       @"FIELD_KEY_InsertDate":@10270,                     //报单日期
                       @"FIELD_KEY_InsertTime":@10271,                     //委托时间
                       @"FIELD_KEY_InsertTimeEnd":@10272,                  //结束时间
                       @"FIELD_KEY_InsertTimeStart":@10273,                //开始时间
                       @"FIELD_KEY_InstLifePhase":@10274,                  //合约生命周期状态
                       @"FIELD_KEY_InstallCount":@10275,                   //安装数量
                       @"FIELD_KEY_InstallID":@10276,                      //安装编号
                       @"FIELD_KEY_InstrumentID":@10277,                   //合约代码
                       @"FIELD_KEY_InstrumentName":@10278,                 //合约名称
                       @"FIELD_KEY_InstrumentStatus":@10279,               //合约交易状态
                       @"FIELD_KEY_Interest":@10280,                       //利息收入
                       @"FIELD_KEY_InterestBase":@10281,                   //利息基数
                       @"FIELD_KEY_InterfaceProductInfo":@10282,           //接口端产品信息
                       @"FIELD_KEY_InvestUnitID":@10283,                   //投资单元代码
                       @"FIELD_KEY_InvestorGroupID":@10284,                //投资者分组代码
                       @"FIELD_KEY_InvestorGroupName":@10285,              //投资者分组名称
                       @"FIELD_KEY_InvestorID":@10286,                     //投资者代码
                       @"FIELD_KEY_InvestorName":@10287,                   //投资者名称
                       @"FIELD_KEY_InvestorRange":@10288,                  //投资者范围
                       @"FIELD_KEY_InvestorUnitName":@10289,               //投资者单元名称
                       @"FIELD_KEY_IsActive":@10290,                       //是否活跃
                       @"FIELD_KEY_IsAuthForce":@10291,                    //是否强制终端认证
                       @"FIELD_KEY_IsAutoSuspend":@10292,                  //自动挂起标志
                       @"FIELD_KEY_IsBrokerUserEvent":@10293,              //是否启用用户事件
                       @"FIELD_KEY_IsForbidden":@10294,                    //是否禁止
                       @"FIELD_KEY_IsForce":@10295,                        //是否强制进行
                       @"FIELD_KEY_IsQryControl":@10296,                   //查询时是否需要流控
                       @"FIELD_KEY_IsRelative":@10297,                     //是否跟随交易所收取
                       @"FIELD_KEY_IsResult":@10298,                       //是否为认证结果
                       @"FIELD_KEY_IsSwapOrder":@10299,                    //互换单标志
                       @"FIELD_KEY_IsTrading":@10300,                      //当前是否交易
                       @"FIELD_KEY_IsUsingOTP":@10301,                     //是否使用令牌
                       @"FIELD_KEY_IsWhite":@10302,                        //是否白名单
                       @"FIELD_KEY_KeyID":@10303,                          //密钥编号
                       @"FIELD_KEY_KeyKind":@10304,                        //动态密钥类型
                       @"FIELD_KEY_LastDrift":@10305,                      //漂移值
                       @"FIELD_KEY_LastFragment":@10306,                   //最后分片标志
                       @"FIELD_KEY_LastLoginTime":@10307,                  //上次登陆时间
                       @"FIELD_KEY_LastPrice":@10308,                      //最新价
                       @"FIELD_KEY_LastReportDate":@10309,                 //上次报告日期
                       @"FIELD_KEY_LastReportTime":@10310,                 //上次报告时间
                       @"FIELD_KEY_LastSettlementPrice":@10311,            //昨结算价
                       @"FIELD_KEY_LastSuccess":@10312,                    //成功值
                       @"FIELD_KEY_LastUpdateTime":@10313,                 //上次修改时间
                       @"FIELD_KEY_LegID":@10314,                          //单腿编号
                       @"FIELD_KEY_LegInstrumentID":@10315,                //单腿合约代码
                       @"FIELD_KEY_LegMultiple":@10316,                    //单腿乘数
                       @"FIELD_KEY_LimitPrice":@10317,                     //价格
                       @"FIELD_KEY_LoginDate":@10318,                      //登录日期
                       @"FIELD_KEY_LoginMode":@10319,                      //登录模式
                       @"FIELD_KEY_LoginRemark":@10320,                    //登录备注
                       @"FIELD_KEY_LoginTime":@10321,                      //登录时间
                       @"FIELD_KEY_LongCustomerName":@10322,               //长客户姓名
                       @"FIELD_KEY_LongExchMargin":@10323,                 //交易所多头保证金
                       @"FIELD_KEY_LongExchOffsetAmount":@10324,           //交易所多头折抵总金额
                       @"FIELD_KEY_LongFrozen":@10325,                     //多头冻结
                       @"FIELD_KEY_LongFrozenAmount":@10326,               //开仓冻结金额
                       @"FIELD_KEY_LongFrozenMargin":@10327,               //多头冻结的保证金
                       @"FIELD_KEY_LongMarginRatio":@10328,                //多头保证金率
                       @"FIELD_KEY_LongMarginRatioByMoney":@10329,         //多头保证金率
                       @"FIELD_KEY_LongMarginRatioByVolume":@10330,        //多头保证金费
                       @"FIELD_KEY_LongOffsetAmount":@10331,               //多头折抵总金额
                       @"FIELD_KEY_LongUseMargin":@10332,                  //多头保证金
                       @"FIELD_KEY_LowerLimitPrice":@10333,                //跌停板价
                       @"FIELD_KEY_LowestPrice":@10334,                    //最低价
                       @"FIELD_KEY_MShortMarginRatioByMoney":@10335,       //做市商空头保证金调整系数
                       @"FIELD_KEY_MShortMarginRatioByVolume":@10336,      //做市商空头保证金调整系数
                       @"FIELD_KEY_MacAddress":@10337,                     //Mac地址
                       @"FIELD_KEY_MacKey":@10338,                         //MAC密钥
                       @"FIELD_KEY_Margin":@10339,                         //投资者保证金
                       @"FIELD_KEY_MarginModelID":@10340,                  //保证金率模板代码
                       @"FIELD_KEY_MarginModelName":@10341,                //模板名称
                       @"FIELD_KEY_MarginPriceType":@10342,                //保证金价格类型
                       @"FIELD_KEY_MarginRateByMoney":@10343,              //保证金率
                       @"FIELD_KEY_MarginRateByVolume":@10344,             //保证金率(按手数)
                       @"FIELD_KEY_MarketID":@10345,                       //市场代码
                       @"FIELD_KEY_MarketStatus":@10346,                   //合约交易状态
                       @"FIELD_KEY_MaxLimitOrderVolume":@10347,            //限价单最大下单量
                       @"FIELD_KEY_MaxMarginSideAlgorithm":@10348,         //是否使用大额单边保证金算法
                       @"FIELD_KEY_MaxMarketOrderVolume":@10349,           //市价单最大下单量
                       @"FIELD_KEY_MaxOrderMessageReference":@10350,       //本席位最大报单备拷
                       @"FIELD_KEY_MaxOrderRef":@10351,                    //最大报单引用
                       @"FIELD_KEY_MaxTradeID":@10352,                     //本席位最大成交编号
                       @"FIELD_KEY_MaxVolume":@10353,                      //最大允许报单数量
                       @"FIELD_KEY_Memo":@10354,                           //备注
                       @"FIELD_KEY_Message":@10355,                        //交易核心给银期报盘的消息
                       @"FIELD_KEY_MinLimitOrderVolume":@10356,            //限价单最小下单量
                       @"FIELD_KEY_MinMargin":@10357,                      //单位（手）期权合约最小保证金
                       @"FIELD_KEY_MinMarketOrderVolume":@10358,           //市价单最小下单量
                       @"FIELD_KEY_MinVolume":@10359,                      //最小成交量
                       @"FIELD_KEY_MiniMargin":@10360,                     //期权合约最小保证金
                       @"FIELD_KEY_Mobile":@10361,                         //手机
                       @"FIELD_KEY_MobilePhone":@10362,                    //手机
                       @"FIELD_KEY_MoneyAccountStatus":@10363,             //资金账户状态
                       @"FIELD_KEY_Mortgage":@10364,                       //质押金额
                       @"FIELD_KEY_MortgageAmount":@10365,                 //质押金额
                       @"FIELD_KEY_MortgageFundUseRange":@10366,           //质押资金可用范围
                       @"FIELD_KEY_MortgageSeqNo":@10367,                  //货币质押流水号
                       @"FIELD_KEY_MortgageableFund":@10368,               //可质押货币金额
                       @"FIELD_KEY_NewBankAccount":@10369,                 //新银行帐号
                       @"FIELD_KEY_NewBankPassWord":@10370,                //新银行密码
                       @"FIELD_KEY_NewPassword":@10371,                    //新的口令
                       @"FIELD_KEY_NewsType":@10372,                       //公告类型
                       @"FIELD_KEY_NewsUrgency":@10373,                    //紧急程度
                       @"FIELD_KEY_NoLongMarginRatioByMoney":@10374,       //不跟随交易所投资者多头保证金率
                       @"FIELD_KEY_NoLongMarginRatioByVolume":@10375,      //不跟随交易所投资者多头保证金费
                       @"FIELD_KEY_NoShortMarginRatioByMoney":@10376,      //不跟随交易所投资者空头保证金率
                       @"FIELD_KEY_NoShortMarginRatioByVolume":@10377,     //不跟随交易所投资者空头保证金费
                       @"FIELD_KEY_NotifySequence":@10378,                 //报单提示序号
                       @"FIELD_KEY_OTPType":@10379,                        //动态令牌类型
                       @"FIELD_KEY_OTPVendorsID":@10380,                   //动态令牌提供商
                       @"FIELD_KEY_Offset":@10381,                         //执行偏移值
                       @"FIELD_KEY_OffsetAmount":@10382,                   //折抵总金额
                       @"FIELD_KEY_OffsetFlag":@10383,                     //开平标志
                       @"FIELD_KEY_OffsetType":@10384,                     //执行偏移类型
                       @"FIELD_KEY_OldPassword":@10385,                    //原来的口令
                       @"FIELD_KEY_OneTimePassword":@10386,                //动态密码
                       @"FIELD_KEY_OpenAmount":@10387,                     //开仓金额
                       @"FIELD_KEY_OpenBank":@10388,                       //银行账户的开户行
                       @"FIELD_KEY_OpenCost":@10389,                       //开仓成本
                       @"FIELD_KEY_OpenDate":@10390,                       //开户日期
                       @"FIELD_KEY_OpenInterest":@10391,                   //持仓量
                       @"FIELD_KEY_OpenName":@10392,                       //银行账户的开户人名称
                       @"FIELD_KEY_OpenOrDestroy":@10393,                  //开销户类别
                       @"FIELD_KEY_OpenPrice":@10394,                      //开仓价
                       @"FIELD_KEY_OpenRatioByMoney":@10395,               //开仓手续费率
                       @"FIELD_KEY_OpenRatioByVolume":@10396,              //开仓手续费
                       @"FIELD_KEY_OpenVolume":@10397,                     //当日投机+套利开仓数量限制
                       @"FIELD_KEY_OperNo":@10398,                         //交易柜员
                       @"FIELD_KEY_OperateDate":@10399,                    //录入日期
                       @"FIELD_KEY_OperateTime":@10400,                    //录入时间
                       @"FIELD_KEY_OperatorCode":@10401,                   //操作员
                       @"FIELD_KEY_OperatorID":@10402,                     //录入员代码
                       @"FIELD_KEY_OptSelfCloseFlag":@10403,               //期权行权的头寸是否自对冲
                       @"FIELD_KEY_OptionRoyaltyPriceType":@10404,         //期权权利金价格类型
                       @"FIELD_KEY_OptionSelfCloseActionRef":@10405,       //期权自对冲操作引用
                       @"FIELD_KEY_OptionSelfCloseLocalID":@10406,         //本地期权自对冲编号
                       @"FIELD_KEY_OptionSelfCloseRef":@10407,             //期权自对冲引用
                       @"FIELD_KEY_OptionSelfCloseSysID":@10408,           //期权自对冲操作编号
                       @"FIELD_KEY_OptionsType":@10409,                    //期权类型
                       @"FIELD_KEY_OrderActionCommByVolume":@10410,        //撤单手续费
                       @"FIELD_KEY_OrderActionRef":@10411,                 //报单操作引用
                       @"FIELD_KEY_OrderActionStatus":@10412,              //报单操作状态
                       @"FIELD_KEY_OrderCommByVolume":@10413,              //报单手续费
                       @"FIELD_KEY_OrderLocalID":@10414,                   //本地报单编号
                       @"FIELD_KEY_OrderPriceType":@10415,                 //报单价格条件
                       @"FIELD_KEY_OrderRef":@10416,                       //报单引用
                       @"FIELD_KEY_OrderSource":@10417,                    //报单来源
                       @"FIELD_KEY_OrderStatus":@10418,                    //报单状态
                       @"FIELD_KEY_OrderSubmitStatus":@10419,              //报单提交状态
                       @"FIELD_KEY_OrderSysID":@10420,                     //报单编号
                       @"FIELD_KEY_OrderType":@10421,                      //报单类型
                       @"FIELD_KEY_OrigBrokerID":@10422,                   //原应用单元代码
                       @"FIELD_KEY_OrigDRIdentityID":@10423,               //原交易中心代码
                       @"FIELD_KEY_OriginDescrInfoForReturnCode":@10424,   //原始返回码描述
                       @"FIELD_KEY_OriginReturnCode":@10425,               //原始返回代码
                       @"FIELD_KEY_OutDate":@10426,                        //解约日期
                       @"FIELD_KEY_ParkedOrderActionID":@10427,            //预埋撤单编号
                       @"FIELD_KEY_ParkedOrderID":@10428,                  //预埋报单编号
                       @"FIELD_KEY_ParticipantID":@10429,                  //经纪公司统一编码
                       @"FIELD_KEY_Password":@10430,                       //期货密码
                       @"FIELD_KEY_PasswordDeprecated":@10431,             //密码,已弃用
                       @"FIELD_KEY_PersonFullName":@10432,                 //全称
                       @"FIELD_KEY_PersonName":@10433,                     //名称
                       @"FIELD_KEY_PersonType":@10434,                     //联系人类型
                       @"FIELD_KEY_PinKey":@10435,                         //PIN密钥
                       @"FIELD_KEY_PlateRepealSerial":@10436,              //被冲正平台流水号
                       @"FIELD_KEY_PlateSerial":@10437,                    //银期平台消息流水号
                       @"FIELD_KEY_PosiDirection":@10438,                  //保留头寸申请的持仓方向
                       @"FIELD_KEY_Position":@10439,                       //今日持仓
                       @"FIELD_KEY_PositionCost":@10440,                   //持仓成本
                       @"FIELD_KEY_PositionDate":@10441,                   //持仓日期
                       @"FIELD_KEY_PositionDateType":@10442,               //持仓日期类型
                       @"FIELD_KEY_PositionProfit":@10443,                 //持仓盈亏
                       @"FIELD_KEY_PositionProfitByDate":@10444,           //逐日盯市持仓盈亏
                       @"FIELD_KEY_PositionProfitByTrade":@10445,          //逐笔对冲持仓盈亏
                       @"FIELD_KEY_PositionType":@10446,                   //持仓类型
                       @"FIELD_KEY_PreBalance":@10447,                     //上次结算准备金
                       @"FIELD_KEY_PreClosePrice":@10448,                  //昨收盘
                       @"FIELD_KEY_PreCredit":@10449,                      //上次信用额度
                       @"FIELD_KEY_PreDelta":@10450,                       //昨虚实度
                       @"FIELD_KEY_PreDeposit":@10451,                     //上次存款额
                       @"FIELD_KEY_PreFundMortgageIn":@10452,              //上次货币质入金额
                       @"FIELD_KEY_PreFundMortgageOut":@10453,             //上次货币质出金额
                       @"FIELD_KEY_PreMargin":@10454,                      //上次占用的保证金
                       @"FIELD_KEY_PreMortgage":@10455,                    //上次质押金额
                       @"FIELD_KEY_PreOpenInterest":@10456,                //昨持仓量
                       @"FIELD_KEY_PreSettlementPrice":@10457,             //上次结算价
                       @"FIELD_KEY_Price":@10458,                          //报单价格
                       @"FIELD_KEY_PriceInterval":@10459,                  //价差
                       @"FIELD_KEY_PriceSource":@10460,                    //成交价来源
                       @"FIELD_KEY_PriceTick":@10461,                      //最小变动价位
                       @"FIELD_KEY_Priority":@10462,                       //优先级
                       @"FIELD_KEY_ProductClass":@10463,                   //产品类型
                       @"FIELD_KEY_ProductGroupID":@10464,                 //产品组代码
                       @"FIELD_KEY_ProductID":@10465,                      //产品代码
                       @"FIELD_KEY_ProductName":@10466,                    //产品名称
                       @"FIELD_KEY_ProtocolInfo":@10467,                   //协议信息
                       @"FIELD_KEY_QuoteActionRef":@10468,                 //报价操作引用
                       @"FIELD_KEY_QuoteCurrencyID":@10469,                //报价币种类型
                       @"FIELD_KEY_QuoteLocalID":@10470,                   //本地报价编号
                       @"FIELD_KEY_QuoteRef":@10471,                       //报价引用
                       @"FIELD_KEY_QuoteStatus":@10472,                    //报价状态
                       @"FIELD_KEY_QuoteSysID":@10473,                     //报价操作编号
                       @"FIELD_KEY_RandomString":@10474,                   //随机串
                       @"FIELD_KEY_RecordNum":@10475,                      //记录数，N/A
                       @"FIELD_KEY_Reference":@10476,                      //流水号
                       @"FIELD_KEY_RefrenceIssure":@10477,                 //本流水号发布者机构编码
                       @"FIELD_KEY_RefrenceIssureType":@10478,             //本流水号发布者的机构类型
                       @"FIELD_KEY_RegDate":@10479,                        //签约日期
                       @"FIELD_KEY_RelativeOrderSysID":@10480,             //相关报单
                       @"FIELD_KEY_RemainSwap":@10481,                     //剩余换汇额度
                       @"FIELD_KEY_RepealTimeInterval":@10482,             //冲正时间间隔
                       @"FIELD_KEY_RepealedTimes":@10483,                  //已经冲正次数
                       @"FIELD_KEY_RequestID":@10484,                      //请求编号
                       @"FIELD_KEY_Reserve":@10485,                        //基本准备金
                       @"FIELD_KEY_ReserveBalance":@10486,                 //保底期货结算准备金
                       @"FIELD_KEY_ReserveOpenAccStas":@10487,             //预约开户状态
                       @"FIELD_KEY_ReservePositionFlag":@10488,            //期权行权后是否保留期货头寸的标记,该字段已废弃
                       @"FIELD_KEY_RetCode":@10489,                        //响应代码
                       @"FIELD_KEY_RetInfo":@10490,                        //响应信息
                       @"FIELD_KEY_ReturnCode":@10491,                     //返回代码
                       @"FIELD_KEY_Royalty":@10492,                        //期权合约权利金
                       @"FIELD_KEY_SHFETime":@10493,                       //上期所时间
                       @"FIELD_KEY_SShortMarginRatioByMoney":@10494,       //投机空头保证金调整系数
                       @"FIELD_KEY_SShortMarginRatioByVolume":@10495,      //投机空头保证金调整系数
                       @"FIELD_KEY_SecondOTP":@10496,                      //第二个动态密码
                       @"FIELD_KEY_SecuPwdFlag":@10497,                    //期货资金密码核对标志
                       @"FIELD_KEY_SendTime":@10498,                       //发送时间
                       @"FIELD_KEY_SequenceLabel":@10499,                  //经纪公司通知内容序列号
                       @"FIELD_KEY_SequenceNo":@10500,                     //序列号
                       @"FIELD_KEY_SequenceSeries":@10501,                 //序列系列号
                       @"FIELD_KEY_SerialNumber":@10502,                   //动态令牌序列号
                       @"FIELD_KEY_SessionID":@10503,                      //会话号
                       @"FIELD_KEY_SettlementGroupID":@10504,              //结算组代码
                       @"FIELD_KEY_SettlementID":@10505,                   //结算编号
                       @"FIELD_KEY_SettlementPrice":@10506,                //结算价
                       @"FIELD_KEY_ShortExchMargin":@10507,                //交易所空头保证金
                       @"FIELD_KEY_ShortExchOffsetAmount":@10508,          //交易所空头折抵总金额
                       @"FIELD_KEY_ShortFrozen":@10509,                    //空头冻结
                       @"FIELD_KEY_ShortFrozenAmount":@10510,              //开仓冻结金额
                       @"FIELD_KEY_ShortFrozenMargin":@10511,              //空头冻结的保证金
                       @"FIELD_KEY_ShortMarginRatio":@10512,               //空头保证金率
                       @"FIELD_KEY_ShortMarginRatioByMoney":@10513,        //空头保证金率
                       @"FIELD_KEY_ShortMarginRatioByVolume":@10514,       //空头保证金费
                       @"FIELD_KEY_ShortOffsetAmount":@10515,              //空头折抵总金额
                       @"FIELD_KEY_ShortUseMargin":@10516,                 //空头保证金
                       @"FIELD_KEY_SourceIP":@10517,                       //源地址
                       @"FIELD_KEY_SpecOpenVolume":@10518,                 //当日投机开仓数量限制
                       @"FIELD_KEY_SpecProductCloseProfit":@10519,         //特殊产品平仓盈亏
                       @"FIELD_KEY_SpecProductCommission":@10520,          //特殊产品手续费
                       @"FIELD_KEY_SpecProductExchangeMargin":@10521,      //特殊产品交易所保证金
                       @"FIELD_KEY_SpecProductFrozenCommission":@10522,    //特殊产品冻结手续费
                       @"FIELD_KEY_SpecProductFrozenMargin":@10523,        //特殊产品冻结保证金
                       @"FIELD_KEY_SpecProductMargin":@10524,              //特殊产品占用保证金
                       @"FIELD_KEY_SpecProductPositionProfit":@10525,      //特殊产品持仓盈亏
                       @"FIELD_KEY_SpecProductPositionProfitByAlg":@10526, //根据持仓盈亏算法计算的特殊产品持仓盈亏
                       @"FIELD_KEY_StartDate":@10527,                      //启动日期
                       @"FIELD_KEY_StartDelivDate":@10528,                 //开始交割日
                       @"FIELD_KEY_StartTime":@10529,                      //启动时间
                       @"FIELD_KEY_Status":@10530,                         //预埋撤单状态
                       @"FIELD_KEY_StatusMsg":@10531,                      //状态信息
                       @"FIELD_KEY_StopPrice":@10532,                      //止损价
                       @"FIELD_KEY_StrikeFrozen":@10533,                   //执行冻结
                       @"FIELD_KEY_StrikeFrozenAmount":@10534,             //执行冻结金额
                       @"FIELD_KEY_StrikePrice":@10535,                    //执行价
                       @"FIELD_KEY_StrikeRatioByMoney":@10536,             //执行手续费率
                       @"FIELD_KEY_StrikeRatioByVolume":@10537,            //执行手续费
                       @"FIELD_KEY_SuspendTime":@10538,                    //挂起时间
                       @"FIELD_KEY_SystemID":@10539,                       //系统编号
                       @"FIELD_KEY_SystemName":@10540,                     //系统名称
                       @"FIELD_KEY_TID":@10541,                            //交易ID
                       @"FIELD_KEY_Telephone":@10542,                      //电话号码
                       @"FIELD_KEY_TimeCondition":@10543,                  //有效期类型
                       @"FIELD_KEY_ToAmount":@10544,                       //目标金额
                       @"FIELD_KEY_ToCurrencyID":@10545,                   //目标币种
                       @"FIELD_KEY_TodayPosition":@10546,                  //今日持仓
                       @"FIELD_KEY_Token":@10547,                          //动态令牌
                       @"FIELD_KEY_TotalAmt":@10548,                       //持仓量
                       @"FIELD_KEY_TradeAmount":@10549,                    //交易金额
                       @"FIELD_KEY_TradeAmt":@10550,                       //银行余额
                       @"FIELD_KEY_TradeCode":@10551,                      //业务功能码
                       @"FIELD_KEY_TradeCurrencyID":@10552,                //交易币种类型
                       @"FIELD_KEY_TradeDate":@10553,                      //交易日期
                       @"FIELD_KEY_TradeDay":@10554,                       //交易日期
                       @"FIELD_KEY_TradeGroupID":@10555,                   //成交组号
                       @"FIELD_KEY_TradeID":@10556,                        //撮合编号
                       @"FIELD_KEY_TradeParamID":@10557,                   //参数代码
                       @"FIELD_KEY_TradeParamValue":@10558,                //参数代码值
                       @"FIELD_KEY_TradeSerial":@10559,                    //发起方流水号，N/A
                       @"FIELD_KEY_TradeSource":@10560,                    //成交来源
                       @"FIELD_KEY_TradeTime":@10561,                      //交易时间
                       @"FIELD_KEY_TradeTimeEnd":@10562,                   //结束时间
                       @"FIELD_KEY_TradeTimeStart":@10563,                 //开始时间
                       @"FIELD_KEY_TradeType":@10564,                      //成交类型
                       @"FIELD_KEY_Tradeable":@10565,                      //能否交易
                       @"FIELD_KEY_TraderConnectStatus":@10566,            //交易所交易员连接状态
                       @"FIELD_KEY_TraderID":@10567,                       //交易所交易员代码
                       @"FIELD_KEY_TradingDay":@10568,                     //交易系统日期
                       @"FIELD_KEY_TradingRight":@10569,                   //交易权限
                       @"FIELD_KEY_TradingRole":@10570,                    //交易角色
                       @"FIELD_KEY_TradingSegmentSN":@10571,               //交易阶段编号
                       @"FIELD_KEY_TransferStatus":@10572,                 //转账交易状态
                       @"FIELD_KEY_Turnover":@10573,                       //成交金额
                       @"FIELD_KEY_TxAmount":@10574,                       //发生金额
                       @"FIELD_KEY_UOAZipCode":@10575,                     //开户邮政编码
                       @"FIELD_KEY_URLLink":@10576,                        //WEB地址
                       @"FIELD_KEY_UnderlyingInstrID":@10577,              //基础商品代码
                       @"FIELD_KEY_UnderlyingMultiple":@10578,             //合约基础商品乘数
                       @"FIELD_KEY_UnderlyingPrice":@10579,                //标的价格,填0则用昨结算价
                       @"FIELD_KEY_UpdateMillisec":@10580,                 //最后修改毫秒
                       @"FIELD_KEY_UpdateTime":@10581,                     //最后修改时间
                       @"FIELD_KEY_UpperLimitPrice":@10582,                //涨停板价
                       @"FIELD_KEY_UseAmt":@10583,                         //银行可用余额
                       @"FIELD_KEY_UseMargin":@10584,                      //占用的保证金
                       @"FIELD_KEY_UserEventInfo":@10585,                  //用户事件信息
                       @"FIELD_KEY_UserEventType":@10586,                  //用户事件类型
                       @"FIELD_KEY_UserForceClose":@10587,                 //用户强评标志
                       @"FIELD_KEY_UserID":@10588,                         //用户代码
                       @"FIELD_KEY_UserName":@10589,                       //用户名称
                       @"FIELD_KEY_UserProductInfo":@10590,                //用户端产品信息
                       @"FIELD_KEY_UserRightType":@10591,                  //客户权限类型
                       @"FIELD_KEY_UserType":@10592,                       //用户类型
                       @"FIELD_KEY_UsingRatio":@10593,                     //可提资金比例
                       @"FIELD_KEY_ValueMethod":@10594,                    //取值方式
                       @"FIELD_KEY_VerifyCertNoFlag":@10595,               //验证客户证件号码标志
                       @"FIELD_KEY_Version":@10596,                        //版本号，常量，1.0
                       @"FIELD_KEY_Volume":@10597,                         //数量
                       @"FIELD_KEY_VolumeChange":@10598,                   //数量变化
                       @"FIELD_KEY_VolumeCondition":@10599,                //成交量类型
                       @"FIELD_KEY_VolumeMultiple":@10600,                 //合约数量乘数
                       @"FIELD_KEY_VolumeTotal":@10601,                    //剩余数量
                       @"FIELD_KEY_VolumeTotalOriginal":@10602,            //数量
                       @"FIELD_KEY_VolumeTraded":@10603,                   //今成交数量
                       @"FIELD_KEY_WeakExpireDate":@10604,                 //弱密码过期时间
                       @"FIELD_KEY_Withdraw":@10605,                       //出金金额
                       @"FIELD_KEY_WithdrawAlgorithm":@10606,              //可提资金算法
                       @"FIELD_KEY_WithdrawQuota":@10607,                  //可取资金
                       @"FIELD_KEY_YdPosition":@10608,                     //上日持仓
                       @"FIELD_KEY_YdStrikeFrozen":@10609,                 //执行冻结的昨仓
                       @"FIELD_KEY_ZCETotalTradedVolume":@10610,           //郑商所成交数量
                       @"FIELD_KEY_ZipCode":@10611,                        //邮编
                       @"FIELD_KEY_bIsLast":@10612,                        //是否最后一条
                       @"FIELD_KEY_is_Accountregister_null":@10613,        //Accountregister是否为null
                       @"FIELD_KEY_is_BatchOrderAction_null":@10614,       //BatchOrderAction是否为null
                       @"FIELD_KEY_is_BrokerTradingAlgos_null":@10615,     //BrokerTradingAlgos是否为null
                       @"FIELD_KEY_is_BrokerTradingParams_null":@10616,    //BrokerTradingParams是否为null
                       @"FIELD_KEY_is_Bulletin_null":@10617,               //Bulletin是否为null
                       @"FIELD_KEY_is_CFMMCTradingAccountKey_null":@10618, //CFMMCTradingAccountKey是否为null
                       @"FIELD_KEY_is_CFMMCTradingAccountToken_null":@10619,//CFMMCTradingAccountToken是否为null
                       @"FIELD_KEY_is_CancelAccount_null":@10620,          //CancelAccount是否为null
                       @"FIELD_KEY_is_ChangeAccount_null":@10621,          //ChangeAccount是否为null
                       @"FIELD_KEY_is_CombAction_null":@10622,             //CombAction是否为null
                       @"FIELD_KEY_is_CombInstrumentGuard_null":@10623,    //CombInstrumentGuard是否为null
                       @"FIELD_KEY_is_ContractBank_null":@10624,           //ContractBank是否为null
                       @"FIELD_KEY_is_DepthMarketData_null":@10625,        //DepthMarketData是否为null
                       @"FIELD_KEY_is_EWarrantOffset_null":@10626,         //EWarrantOffset是否为null
                       @"FIELD_KEY_is_ErrorConditionalOrder_null":@10627,  //ErrorConditionalOrder是否为null
                       @"FIELD_KEY_is_ExchangeMarginRateAdjust_null":@10628,//ExchangeMarginRateAdjust是否为null
                       @"FIELD_KEY_is_ExchangeMarginRate_null":@10629,     //ExchangeMarginRate是否为null
                       @"FIELD_KEY_is_ExchangeRate_null":@10630,           //ExchangeRate是否为null
                       @"FIELD_KEY_is_Exchange_null":@10631,               //Exchange是否为null
                       @"FIELD_KEY_is_ExecOrderAction_null":@10632,        //ExecOrderAction是否为null
                       @"FIELD_KEY_is_ExecOrder_null":@10633,              //ExecOrder是否为null
                       @"FIELD_KEY_is_ForQuoteRsp_null":@10634,            //ForQuoteRsp是否为null
                       @"FIELD_KEY_is_ForQuote_null":@10635,               //ForQuote是否为null
                       @"FIELD_KEY_is_InputBatchOrderAction_null":@10636,  //InputBatchOrderAction是否为null
                       @"FIELD_KEY_is_InputCombAction_null":@10637,        //InputCombAction是否为null
                       @"FIELD_KEY_is_InputExecOrderAction_null":@10638,   //InputExecOrderAction是否为null
                       @"FIELD_KEY_is_InputExecOrder_null":@10639,         //InputExecOrder是否为null
                       @"FIELD_KEY_is_InputForQuote_null":@10640,          //InputForQuote是否为null
                       @"FIELD_KEY_is_InputOptionSelfCloseAction_null":@10641,//InputOptionSelfCloseAction是否为null
                       @"FIELD_KEY_is_InputOptionSelfClose_null":@10642,   //InputOptionSelfClose是否为null
                       @"FIELD_KEY_is_InputOrderAction_null":@10643,       //InputOrderAction是否为null
                       @"FIELD_KEY_is_InputOrder_null":@10644,             //InputOrder是否为null
                       @"FIELD_KEY_is_InputQuoteAction_null":@10645,       //InputQuoteAction是否为null
                       @"FIELD_KEY_is_InputQuote_null":@10646,             //InputQuote是否为null
                       @"FIELD_KEY_is_InstrumentCommissionRate_null":@10647,//InstrumentCommissionRate是否为null
                       @"FIELD_KEY_is_InstrumentMarginRate_null":@10648,   //InstrumentMarginRate是否为null
                       @"FIELD_KEY_is_InstrumentOrderCommRate_null":@10649,//InstrumentOrderCommRate是否为null
                       @"FIELD_KEY_is_InstrumentStatus_null":@10650,       //InstrumentStatus是否为null
                       @"FIELD_KEY_is_Instrument_null":@10651,             //Instrument是否为null
                       @"FIELD_KEY_is_InvestUnit_null":@10652,             //InvestUnit是否为null
                       @"FIELD_KEY_is_InvestorPositionCombineDetail_null":@10653,//InvestorPositionCombineDetail是否为null
                       @"FIELD_KEY_is_InvestorPositionDetail_null":@10654, //InvestorPositionDetail是否为null
                       @"FIELD_KEY_is_InvestorPosition_null":@10655,       //InvestorPosition是否为null
                       @"FIELD_KEY_is_InvestorProductGroupMargin_null":@10656,//InvestorProductGroupMargin是否为null
                       @"FIELD_KEY_is_Investor_null":@10657,               //Investor是否为null
                       @"FIELD_KEY_is_MMInstrumentCommissionRate_null":@10658,//MMInstrumentCommissionRate是否为null
                       @"FIELD_KEY_is_MMOptionInstrCommRate_null":@10659,  //MMOptionInstrCommRate是否为null
                       @"FIELD_KEY_is_Notice_null":@10660,                 //Notice是否为null
                       @"FIELD_KEY_is_NotifyQueryAccount_null":@10661,     //NotifyQueryAccount是否为null
                       @"FIELD_KEY_is_OpenAccount_null":@10662,            //OpenAccount是否为null
                       @"FIELD_KEY_is_OptionInstrCommRate_null":@10663,    //OptionInstrCommRate是否为null
                       @"FIELD_KEY_is_OptionInstrTradeCost_null":@10664,   //OptionInstrTradeCost是否为null
                       @"FIELD_KEY_is_OptionSelfCloseAction_null":@10665,  //OptionSelfCloseAction是否为null
                       @"FIELD_KEY_is_OptionSelfClose_null":@10666,        //OptionSelfClose是否为null
                       @"FIELD_KEY_is_OrderAction_null":@10667,            //OrderAction是否为null
                       @"FIELD_KEY_is_Order_null":@10668,                  //Order是否为null
                       @"FIELD_KEY_is_ParkedOrderAction_null":@10669,      //ParkedOrderAction是否为null
                       @"FIELD_KEY_is_ParkedOrder_null":@10670,            //ParkedOrder是否为null
                       @"FIELD_KEY_is_ProductExchRate_null":@10671,        //ProductExchRate是否为null
                       @"FIELD_KEY_is_ProductGroup_null":@10672,           //ProductGroup是否为null
                       @"FIELD_KEY_is_Product_null":@10673,                //Product是否为null
                       @"FIELD_KEY_is_QueryCFMMCTradingAccountToken_null":@10674,//QueryCFMMCTradingAccountToken是否为null
                       @"FIELD_KEY_is_QueryMaxOrderVolume_null":@10675,    //QueryMaxOrderVolume是否为null
                       @"FIELD_KEY_is_QuoteAction_null":@10676,            //QuoteAction是否为null
                       @"FIELD_KEY_is_Quote_null":@10677,                  //Quote是否为null
                       @"FIELD_KEY_is_RemoveParkedOrderAction_null":@10678,//RemoveParkedOrderAction是否为null
                       @"FIELD_KEY_is_RemoveParkedOrder_null":@10679,      //RemoveParkedOrder是否为null
                       @"FIELD_KEY_is_ReqQueryAccount_null":@10680,        //ReqQueryAccount是否为null
                       @"FIELD_KEY_is_ReqRepeal_null":@10681,              //ReqRepeal是否为null
                       @"FIELD_KEY_is_ReqTransfer_null":@10682,            //ReqTransfer是否为null
                       @"FIELD_KEY_is_RspAuthenticateField_null":@10683,   //RspAuthenticateField是否为null
                       @"FIELD_KEY_is_RspInfo_null":@10684,                //RspInfo是否为null
                       @"FIELD_KEY_is_RspRepeal_null":@10685,              //RspRepeal是否为null
                       @"FIELD_KEY_is_RspTransfer_null":@10686,            //RspTransfer是否为null
                       @"FIELD_KEY_is_RspUserLogin_null":@10687,           //RspUserLogin是否为null
                       @"FIELD_KEY_is_SecAgentACIDMap_null":@10688,        //SecAgentACIDMap是否为null
                       @"FIELD_KEY_is_SecAgentCheckMode_null":@10689,      //SecAgentCheckMode是否为null
                       @"FIELD_KEY_is_SettlementInfoConfirm_null":@10690,  //SettlementInfoConfirm是否为null
                       @"FIELD_KEY_is_SettlementInfo_null":@10691,         //SettlementInfo是否为null
                       @"FIELD_KEY_is_Trade_null":@10692,                  //Trade是否为null
                       @"FIELD_KEY_is_TradingAccountPasswordUpdate_null":@10693,//TradingAccountPasswordUpdate是否为null
                       @"FIELD_KEY_is_TradingAccount_null":@10694,         //TradingAccount是否为null
                       @"FIELD_KEY_is_TradingCode_null":@10695,            //TradingCode是否为null
                       @"FIELD_KEY_is_TradingNoticeInfo_null":@10696,      //TradingNoticeInfo是否为null
                       @"FIELD_KEY_is_TradingNotice_null":@10697,          //TradingNotice是否为null
                       @"FIELD_KEY_is_TransferBank_null":@10698,           //TransferBank是否为null
                       @"FIELD_KEY_is_TransferSerial_null":@10699,         //TransferSerial是否为null
                       @"FIELD_KEY_is_UserLogout_null":@10700,             //UserLogout是否为null
                       @"FIELD_KEY_is_UserPasswordUpdate_null":@10701,     //UserPasswordUpdate是否为null
                       @"FIELD_KEY_nRequestID":@10702,                     //请求的编号
                       @"FIELD_KEY_nResumeType":@10703,
                       };
    self.configModel.BESTSDKDEFINE_DICTS = @{
                                 //订阅私有流的数据。若不调用则不会收到私有流的数据。
                                 @"AS_SDK_USER_SUBSCRIBEPRIVATETOPIC" : @20001,
                                 //订阅公有流的数据。若不调用则不会收到公共流的数据。
                                 @"AS_SDK_USER_SUBSCRIBEPUBLICTOPIC" : @20002,
                                 //客户端认证请求
                                 @"AS_SDK_USER_REQAUTHENTICATE" : @20003,
                                 //用户登录请求
                                 @"AS_SDK_USER_REQUSERLOGIN" : @20004,
                                 //登出请求
                                 @"AS_SDK_USER_REQUSERLOGOUT" : @20005,
                                 //用户口令更新请求
                                 @"AS_SDK_USER_REQUSERPASSWORDUPDATE" : @20006,
                                 //资金账户口令更新请求
                                 @"AS_SDK_USER_REQTRADINGACCOUNTPASSWORDUPDATE" : @20007,
                                 //登录请求2
                                 @"AS_SDK_USER_REQUSERLOGIN2" : @20008,
                                 //用户口令更新请求2
                                 @"AS_SDK_USER_REQUSERPASSWORDUPDATE2" : @20009,
                                 //报单录入请求
                                 @"AS_SDK_USER_REQORDERINSERT" : @20010,
                                 //预埋单录入请求
                                 @"AS_SDK_USER_REQPARKEDORDERINSERT" : @20011,
                                 //预埋撤单录入请求
                                 @"AS_SDK_USER_REQPARKEDORDERACTION" : @20012,
                                 //报单操作请求
                                 @"AS_SDK_USER_REQORDERACTION" : @20013,
                                 //查询最大报单数量请求
                                 @"AS_SDK_USER_REQQUERYMAXORDERVOLUME" : @20014,
                                 //投资者结算结果确认
                                 @"AS_SDK_USER_REQSETTLEMENTINFOCONFIRM" : @20015,
                                 //请求删除预埋单
                                 @"AS_SDK_USER_REQREMOVEPARKEDORDER" : @20016,
                                 //请求删除预埋撤单
                                 @"AS_SDK_USER_REQREMOVEPARKEDORDERACTION" : @20017,
                                 //执行宣告录入请求
                                 @"AS_SDK_USER_REQEXECORDERINSERT" : @20018,
                                 //执行宣告操作请求
                                 @"AS_SDK_USER_REQEXECORDERACTION" : @20019,
                                 //询价录入请求
                                 @"AS_SDK_USER_REQFORQUOTEINSERT" : @20020,
                                 //报价录入请求
                                 @"AS_SDK_USER_REQQUOTEINSERT" : @20021,
                                 //报价操作请求
                                 @"AS_SDK_USER_REQQUOTEACTION" : @20022,
                                 //批量报单操作请求
                                 @"AS_SDK_USER_REQBATCHORDERACTION" : @20023,
                                 //期权自对冲录入请求
                                 @"AS_SDK_USER_REQOPTIONSELFCLOSEINSERT" : @20024,
                                 //期权自对冲操作请求
                                 @"AS_SDK_USER_REQOPTIONSELFCLOSEACTION" : @20025,
                                 //申请组合录入请求
                                 @"AS_SDK_USER_REQCOMBACTIONINSERT" : @20026,
                                 //请求查询报单
                                 @"AS_SDK_USER_REQQRYORDER" : @20027,
                                 //请求查询成交
                                 @"AS_SDK_USER_REQQRYTRADE" : @20028,
                                 //请求查询投资者持仓
                                 @"AS_SDK_USER_REQQRYINVESTORPOSITION" : @20029,
                                 //请求查询资金账户
                                 @"AS_SDK_USER_REQQRYTRADINGACCOUNT" : @20030,
                                 //请求查询投资者
                                 @"AS_SDK_USER_REQQRYINVESTOR" : @20031,
                                 //请求查询交易编码
                                 @"AS_SDK_USER_REQQRYTRADINGCODE" : @20032,
                                 //请求查询合约保证金率
                                 @"AS_SDK_USER_REQQRYINSTRUMENTMARGINRATE" : @20033,
                                 //请求查询合约手续费率
                                 @"AS_SDK_USER_REQQRYINSTRUMENTCOMMISSIONRATE" : @20034,
                                 //请求查询交易所
                                 @"AS_SDK_USER_REQQRYEXCHANGE" : @20035,
                                 //请求查询产品
                                 @"AS_SDK_USER_REQQRYPRODUCT" : @20036,
                                 //请求查询合约
                                 @"AS_SDK_USER_REQQRYINSTRUMENT" : @20037,
                                 //请求查询行情
                                 @"AS_SDK_USER_REQQRYDEPTHMARKETDATA" : @20038,
                                 //请求查询投资者结算结果
                                 @"AS_SDK_USER_REQQRYSETTLEMENTINFO" : @20039,
                                 //请求查询转帐银行
                                 @"AS_SDK_USER_REQQRYTRANSFERBANK" : @20040,
                                 //请求查询投资者持仓明细
                                 @"AS_SDK_USER_REQQRYINVESTORPOSITIONDETAIL" : @20041,
                                 //请求查询客户通知
                                 @"AS_SDK_USER_REQQRYNOTICE" : @20042,
                                 //请求查询结算信息确认
                                 @"AS_SDK_USER_REQQRYSETTLEMENTINFOCONFIRM" : @20043,
                                 //请求查询投资者持仓明细
                                 @"AS_SDK_USER_REQQRYINVESTORPOSITIONCOMBINEDETAIL" : @20044,
                                 //请求查询保证金监管系统经纪公司资金账户密钥
                                 @"AS_SDK_USER_REQQRYCFMMCTRADINGACCOUNTKEY" : @20045,
                                 //请求查询仓单折抵信息
                                 @"AS_SDK_USER_REQQRYEWARRANTOFFSET" : @20046,
                                 //请求查询投资者品种/跨品种保证金
                                 @"AS_SDK_USER_REQQRYINVESTORPRODUCTGROUPMARGIN" : @20047,
                                 //请求查询交易所保证金率
                                 @"AS_SDK_USER_REQQRYEXCHANGEMARGINRATE" : @20048,
                                 //请求查询交易所调整保证金率
                                 @"AS_SDK_USER_REQQRYEXCHANGEMARGINRATEADJUST" : @20049,
                                 //请求查询汇率
                                 @"AS_SDK_USER_REQQRYEXCHANGERATE" : @20050,
                                 //请求查询二级代理操作员银期权限
                                 @"AS_SDK_USER_REQQRYSECAGENTACIDMAP" : @20051,
                                 //请求查询产品报价汇率
                                 @"AS_SDK_USER_REQQRYPRODUCTEXCHRATE" : @20052,
                                 //请求查询产品组
                                 @"AS_SDK_USER_REQQRYPRODUCTGROUP" : @20053,
                                 //请求查询做市商合约手续费率
                                 @"AS_SDK_USER_REQQRYMMINSTRUMENTCOMMISSIONRATE" : @20054,
                                 //请求查询做市商期权合约手续费
                                 @"AS_SDK_USER_REQQRYMMOPTIONINSTRCOMMRATE" : @20055,
                                 //请求查询报单手续费
                                 @"AS_SDK_USER_REQQRYINSTRUMENTORDERCOMMRATE" : @20056,
                                 //请求查询资金账户
                                 @"AS_SDK_USER_REQQRYSECAGENTTRADINGACCOUNT" : @20057,
                                 //请求查询二级代理商资金校验模式
                                 @"AS_SDK_USER_REQQRYSECAGENTCHECKMODE" : @20058,
                                 //请求查询期权交易成本
                                 @"AS_SDK_USER_REQQRYOPTIONINSTRTRADECOST" : @20059,
                                 //请求查询期权合约手续费
                                 @"AS_SDK_USER_REQQRYOPTIONINSTRCOMMRATE" : @20060,
                                 //请求查询执行宣告
                                 @"AS_SDK_USER_REQQRYEXECORDER" : @20061,
                                 //请求查询询价
                                 @"AS_SDK_USER_REQQRYFORQUOTE" : @20062,
                                 //请求查询报价
                                 @"AS_SDK_USER_REQQRYQUOTE" : @20063,
                                 //请求查询期权自对冲
                                 @"AS_SDK_USER_REQQRYOPTIONSELFCLOSE" : @20064,
                                 //请求查询投资单元
                                 @"AS_SDK_USER_REQQRYINVESTUNIT" : @20065,
                                 //请求查询组合合约安全系数
                                 @"AS_SDK_USER_REQQRYCOMBINSTRUMENTGUARD" : @20066,
                                 //请求查询申请组合
                                 @"AS_SDK_USER_REQQRYCOMBACTION" : @20067,
                                 //请求查询转帐流水
                                 @"AS_SDK_USER_REQQRYTRANSFERSERIAL" : @20068,
                                 //请求查询银期签约关系
                                 @"AS_SDK_USER_REQQRYACCOUNTREGISTER" : @20069,
                                 //请求查询签约银行
                                 @"AS_SDK_USER_REQQRYCONTRACTBANK" : @20070,
                                 //请求查询预埋单
                                 @"AS_SDK_USER_REQQRYPARKEDORDER" : @20071,
                                 //请求查询预埋撤单
                                 @"AS_SDK_USER_REQQRYPARKEDORDERACTION" : @20072,
                                 //请求查询交易通知
                                 @"AS_SDK_USER_REQQRYTRADINGNOTICE" : @20073,
                                 //请求查询经纪公司交易参数
                                 @"AS_SDK_USER_REQQRYBROKERTRADINGPARAMS" : @20074,
                                 //请求查询经纪公司交易算法
                                 @"AS_SDK_USER_REQQRYBROKERTRADINGALGOS" : @20075,
                                 //请求查询监控中心用户令牌
                                 @"AS_SDK_USER_REQQUERYCFMMCTRADINGACCOUNTTOKEN" : @20076,
                                 //期货发起银行资金转期货请求
                                 @"AS_SDK_USER_REQFROMBANKTOFUTUREBYFUTURE" : @20077,
                                 //期货发起期货资金转银行请求
                                 @"AS_SDK_USER_REQFROMFUTURETOBANKBYFUTURE" : @20078,
                                 //期货发起查询银行余额请求
                                 @"AS_SDK_USER_REQQUERYBANKACCOUNTMONEYBYFUTURE" : @20079,
                                 
                                 
                                 //ctp报单通知
//                                 @"AS_SDK_ONRTN_ORDER_INSERT" : @20080,//废弃的名称
                                 @"AS_SDK_USER_ONRTNORDER" : @20080,//正式名称
                                 //ctp报单操作请求(撤单)的响应
//                                 @"AS_SDK_ONRTN_USER_REQORDERACTION" : @20081,//废弃的名称
                                 @"AS_SDK_USER_ONRSPORDERACTION" : @20081,//正式名称
                                 //ctp成交通知
//                                 @"AS_SDK_ONRTN_USER_ORDERTRADE" : @20082,//废弃的名称
                                 @"AS_SDK_USER_ONRTNTRADE" : @20082,//正式名称
                                 
                                 //查询报单响应
                                 @"AS_SDK_USER_ONRSPQRYORDER" : @20083,
                                 //查询成交响应
                                 @"AS_SDK_USER_ONRSPQRYTRADE" : @20084,
                                 //查询投资者持仓响应
                                 @"AS_SDK_USER_ONRSPQRYINVESTORPOSITION" : @20085,
                                 //查询资金账户响应
                                 @"AS_SDK_USER_ONRSPQRYTRADINGACCOUNT" : @20086,
                                 //查询合约响应
                                 @"AS_SDK_USER_ONRSPQRYINSTRUMENT" : @20087,
                                 //查询合约响应(主账户)
                                 @"AS_SDK_USER_ONRSPQRYINSTRUMENT_MAIN_ACCOUNT" : @20088,
                                 //查询投资者持仓响应(主账户)
                                 @"AS_SDK_USER_ONRSPQRYINVESTORPOSITION_MAIN_ACCOUNT" : @20089,
                                 //查询报单响应(主账户)
                                 @"AS_SDK_USER_ONRSPQRYORDER_MAIN_ACCOUNT" : @20090,
                                 //查询成交响应(主账户)
                                 @"AS_SDK_USER_ONRSPQRYTRADE_MAIN_ACCOUNT" : @20091,
                                 //查询投资者持仓明细响应(主账户)
                                 @"AS_SDK_USER_ONRSPQRYINVESTORPOSITIONDETAIL_MAIN_ACCOUNT" : @20092,
                                 //查询资金账户响应(主账户)
                                 @"AS_SDK_USER_ONRSPQRYTRADINGACCOUNT_MAIN_ACCOUNT" : @20093,
                                 //登录请求响应(主账户)
                                 @"AS_SDK_USER_ONRSPUSERLOGIN_MAIN_ACCOUNT" : @20094,
                                 //查询投资者持仓明细响应
                                 @"AS_SDK_USER_ONRSPQRYINVESTORPOSITIONDETAIL" : @20095,
                                 //报单有错误时的报单录入请求响应
                                 @"AS_SDK_USER_ONRSPORDERINSERT" : @20096,
                                 //查询深度行情响应(主账户)
                                 @"AS_SDK_USER_ONRSPQRYDEPTHMARKETDATA_MAIN_ACCOUNT" : @20097,
                                 //登录请求响应
                                 @"AS_SDK_USER_ONRSPUSERLOGIN" : @20098,
                                 //登出请求响应
                                 @"AS_SDK_USER_ONRSPUSERLOGOUT" : @20099,
                                 //用户登录后推送的报单通知
                                 @"AS_SDK_USER_ONRTNORDER_AFTER_LOGIN" : @20100,
                                 //用户登录后推送的成交通知
                                 @"AS_SDK_USER_ONRTNTRADE_AFTER_LOGIN" : @20101,
                                 //请求查询行情(主账户)
                                 @"AS_SDK_USER_REQQRYDEPTHMARKETDATA_MAIN_ACCOUNT" : @20102,
                                 //开始结算
                                 @"AS_SDK_USER_START_SETTLEMENT" : @20103,
                                 //投资者结算结果确认的响应
                                 @"AS_SDK_USER_ONRSPSETTLEMENTINFOCONFIRM" : @20104,
                                 //查询结算信息确认的响应
                                 @"AS_SDK_USER_ONRSPQRYSETTLEMENTINFOCONFIRM" : @20105,
                                 //查询投资者结算结果的响应
                                 @"AS_SDK_USER_ONRSPQRYSETTLEMENTINFO" : @20106,
                                 //单个分账户完成结算
                                 @"AS_SDK_USER_SETTLEMENT_FINISH" : @20107,
                                 //客户端认证响应
                                 @"AS_SDK_USER_ONRSPAUTHENTICATE" : @20200,
                                 //用户口令更新请求响应
                                 @"AS_SDK_USER_ONRSPUSERPASSWORDUPDATE" : @20201,
                                 //资金账户口令更新请求响应
                                 @"AS_SDK_USER_ONRSPTRADINGACCOUNTPASSWORDUPDATE" : @20202,
                                 //预埋单录入请求响应
                                 @"AS_SDK_USER_ONRSPPARKEDORDERINSERT" : @20203,
                                 //预埋撤单录入请求响应
                                 @"AS_SDK_USER_ONRSPPARKEDORDERACTION" : @20204,
                                 //查询最大报单数量响应
                                 @"AS_SDK_USER_ONRSPQUERYMAXORDERVOLUME" : @20205,
                                 //删除预埋单响应
                                 @"AS_SDK_USER_ONRSPREMOVEPARKEDORDER" : @20206,
                                 //删除预埋撤单响应
                                 @"AS_SDK_USER_ONRSPREMOVEPARKEDORDERACTION" : @20207,
                                 //执行宣告录入请求响应
                                 @"AS_SDK_USER_ONRSPEXECORDERINSERT" : @20208,
                                 //执行宣告操作请求响应
                                 @"AS_SDK_USER_ONRSPEXECORDERACTION" : @20209,
                                 //询价录入请求响应
                                 @"AS_SDK_USER_ONRSPFORQUOTEINSERT" : @20210,
                                 //报价录入请求响应
                                 @"AS_SDK_USER_ONRSPQUOTEINSERT" : @20211,
                                 //报价操作请求响应
                                 @"AS_SDK_USER_ONRSPQUOTEACTION" : @20212,
                                 //批量报单操作请求响应
                                 @"AS_SDK_USER_ONRSPBATCHORDERACTION" : @20213,
                                 //期权自对冲录入请求响应
                                 @"AS_SDK_USER_ONRSPOPTIONSELFCLOSEINSERT" : @20214,
                                 //期权自对冲操作请求响应
                                 @"AS_SDK_USER_ONRSPOPTIONSELFCLOSEACTION" : @20215,
                                 //申请组合录入请求响应
                                 @"AS_SDK_USER_ONRSPCOMBACTIONINSERT" : @20216,
                                 //请求查询投资者响应
                                 @"AS_SDK_USER_ONRSPQRYINVESTOR" : @20217,
                                 //请求查询交易编码响应
                                 @"AS_SDK_USER_ONRSPQRYTRADINGCODE" : @20218,
                                 //请求查询合约保证金率响应
                                 @"AS_SDK_USER_ONRSPQRYINSTRUMENTMARGINRATE" : @20219,
                                 //请求查询合约手续费率响应
                                 @"AS_SDK_USER_ONRSPQRYINSTRUMENTCOMMISSIONRATE" : @20220,
                                 //请求查询交易所响应
                                 @"AS_SDK_USER_ONRSPQRYEXCHANGE" : @20221,
                                 //请求查询产品响应
                                 @"AS_SDK_USER_ONRSPQRYPRODUCT" : @20222,
                                 //请求查询行情响应
                                 @"AS_SDK_USER_ONRSPQRYDEPTHMARKETDATA" : @20223,
                                 //请求查询转帐银行响应
                                 @"AS_SDK_USER_ONRSPQRYTRANSFERBANK" : @20224,
                                 //请求查询客户通知响应
                                 @"AS_SDK_USER_ONRSPQRYNOTICE" : @20225,
                                 //请求查询投资者持仓明细响应(组合持仓明细)
                                 @"AS_SDK_USER_ONRSPQRYINVESTORPOSITIONCOMBINEDETAIL" : @20226,
                                 //查询保证金监管系统经纪公司资金账户密钥响应
                                 @"AS_SDK_USER_ONRSPQRYCFMMCTRADINGACCOUNTKEY" : @20227,
                                 //请求查询仓单折抵信息响应
                                 @"AS_SDK_USER_ONRSPQRYEWARRANTOFFSET" : @20228,
                                 //请求查询投资者品种/跨品种保证金响应
                                 @"AS_SDK_USER_ONRSPQRYINVESTORPRODUCTGROUPMARGIN" : @20229,
                                 //请求查询交易所保证金率响应
                                 @"AS_SDK_USER_ONRSPQRYEXCHANGEMARGINRATE" : @20230,
                                 //请求查询交易所调整保证金率响应
                                 @"AS_SDK_USER_ONRSPQRYEXCHANGEMARGINRATEADJUST" : @20231,
                                 //请求查询汇率响应
                                 @"AS_SDK_USER_ONRSPQRYEXCHANGERATE" : @20232,
                                 //请求查询二级代理操作员银期权限响应
                                 @"AS_SDK_USER_ONRSPQRYSECAGENTACIDMAP" : @20233,
                                 //请求查询产品报价汇率
                                 @"AS_SDK_USER_ONRSPQRYPRODUCTEXCHRATE" : @20234,
                                 //请求查询产品组
                                 @"AS_SDK_USER_ONRSPQRYPRODUCTGROUP" : @20235,
                                 //请求查询做市商合约手续费率响应
                                 @"AS_SDK_USER_ONRSPQRYMMINSTRUMENTCOMMISSIONRATE" : @20236,
                                 //请求查询做市商期权合约手续费响应
                                 @"AS_SDK_USER_ONRSPQRYMMOPTIONINSTRCOMMRATE" : @20237,
                                 //请求查询报单手续费响应
                                 @"AS_SDK_USER_ONRSPQRYINSTRUMENTORDERCOMMRATE" : @20238,
                                 //请求查询资金账户响应
                                 @"AS_SDK_USER_ONRSPQRYSECAGENTTRADINGACCOUNT" : @20239,
                                 //请求查询二级代理商资金校验模式响应
                                 @"AS_SDK_USER_ONRSPQRYSECAGENTCHECKMODE" : @20240,
                                 //请求查询期权交易成本响应
                                 @"AS_SDK_USER_ONRSPQRYOPTIONINSTRTRADECOST" : @20241,
                                 //请求查询期权合约手续费响应
                                 @"AS_SDK_USER_ONRSPQRYOPTIONINSTRCOMMRATE" : @20242,
                                 //请求查询执行宣告响应
                                 @"AS_SDK_USER_ONRSPQRYEXECORDER" : @20243,
                                 //请求查询询价响应
                                 @"AS_SDK_USER_ONRSPQRYFORQUOTE" : @20244,
                                 //请求查询报价响应
                                 @"AS_SDK_USER_ONRSPQRYQUOTE" : @20245,
                                 //请求查询期权自对冲响应
                                 @"AS_SDK_USER_ONRSPQRYOPTIONSELFCLOSE" : @20246,
                                 //请求查询投资单元响应
                                 @"AS_SDK_USER_ONRSPQRYINVESTUNIT" : @20247,
                                 //请求查询组合合约安全系数响应
                                 @"AS_SDK_USER_ONRSPQRYCOMBINSTRUMENTGUARD" : @20248,
                                 //请求查询申请组合响应
                                 @"AS_SDK_USER_ONRSPQRYCOMBACTION" : @20249,
                                 //请求查询转帐流水响应
                                 @"AS_SDK_USER_ONRSPQRYTRANSFERSERIAL" : @20250,
                                 //请求查询银期签约关系响应
                                 @"AS_SDK_USER_ONRSPQRYACCOUNTREGISTER" : @20251,
                                 //错误应答
                                 @"AS_SDK_USER_ONRSPERROR" : @20252,
                                 //报单录入错误回报
                                 @"AS_SDK_USER_ONERRRTNORDERINSERT" : @20253,
                                 //报单操作错误回报
                                 @"AS_SDK_USER_ONERRRTNORDERACTION" : @20254,
                                 //合约交易状态通知
                                 @"AS_SDK_USER_ONRTNINSTRUMENTSTATUS" : @20255,
                                 //交易所公告通知
                                 @"AS_SDK_USER_ONRTNBULLETIN" : @20256,
                                 //交易通知
                                 @"AS_SDK_USER_ONRTNTRADINGNOTICE" : @20257,
                                 //提示条件单校验错误
                                 @"AS_SDK_USER_ONRTNERRORCONDITIONALORDER" : @20258,
                                 //执行宣告通知
                                 @"AS_SDK_USER_ONRTNEXECORDER" : @20259,
                                 //执行宣告录入错误回报
                                 @"AS_SDK_USER_ONERRRTNEXECORDERINSERT" : @20260,
                                 //执行宣告操作错误回报
                                 @"AS_SDK_USER_ONERRRTNEXECORDERACTION" : @20261,
                                 //询价录入错误回报
                                 @"AS_SDK_USER_ONERRRTNFORQUOTEINSERT" : @20262,
                                 //报价通知
                                 @"AS_SDK_USER_ONRTNQUOTE" : @20263,
                                 //报价录入错误回报
                                 @"AS_SDK_USER_ONERRRTNQUOTEINSERT" : @20264,
                                 //报价操作错误回报
                                 @"AS_SDK_USER_ONERRRTNQUOTEACTION" : @20265,
                                 //询价通知
                                 @"AS_SDK_USER_ONRTNFORQUOTERSP" : @20266,
                                 //保证金监控中心用户令牌
                                 @"AS_SDK_USER_ONRTNCFMMCTRADINGACCOUNTTOKEN" : @20267,
                                 //批量报单操作错误回报
                                 @"AS_SDK_USER_ONERRRTNBATCHORDERACTION" : @20268,
                                 //期权自对冲通知
                                 @"AS_SDK_USER_ONRTNOPTIONSELFCLOSE" : @20269,
                                 //期权自对冲录入错误回报
                                 @"AS_SDK_USER_ONERRRTNOPTIONSELFCLOSEINSERT" : @20270,
                                 //期权自对冲操作错误回报
                                 @"AS_SDK_USER_ONERRRTNOPTIONSELFCLOSEACTION" : @20271,
                                 //申请组合通知
                                 @"AS_SDK_USER_ONRTNCOMBACTION" : @20272,
                                 //申请组合录入错误回报
                                 @"AS_SDK_USER_ONERRRTNCOMBACTIONINSERT" : @20273,
                                 //请求查询签约银行响应
                                 @"AS_SDK_USER_ONRSPQRYCONTRACTBANK" : @20274,
                                 //请求查询预埋单响应
                                 @"AS_SDK_USER_ONRSPQRYPARKEDORDER" : @20275,
                                 //请求查询预埋撤单响应
                                 @"AS_SDK_USER_ONRSPQRYPARKEDORDERACTION" : @20276,
                                 //请求查询交易通知响应
                                 @"AS_SDK_USER_ONRSPQRYTRADINGNOTICE" : @20277,
                                 //请求查询经纪公司交易参数响应
                                 @"AS_SDK_USER_ONRSPQRYBROKERTRADINGPARAMS" : @20278,
                                 //请求查询经纪公司交易算法响应
                                 @"AS_SDK_USER_ONRSPQRYBROKERTRADINGALGOS" : @20279,
                                 //请求查询监控中心用户令牌
                                 @"AS_SDK_USER_ONRSPQUERYCFMMCTRADINGACCOUNTTOKEN" : @20280,
                                 //银行发起银行资金转期货通知
                                 @"AS_SDK_USER_ONRTNFROMBANKTOFUTUREBYBANK" : @20281,
                                 //银行发起期货资金转银行通知
                                 @"AS_SDK_USER_ONRTNFROMFUTURETOBANKBYBANK" : @20282,
                                 //银行发起冲正银行转期货通知
                                 @"AS_SDK_USER_ONRTNREPEALFROMBANKTOFUTUREBYBANK" : @20283,
                                 //银行发起冲正期货转银行通知
                                 @"AS_SDK_USER_ONRTNREPEALFROMFUTURETOBANKBYBANK" : @20284,
                                 //期货发起银行资金转期货通知
                                 @"AS_SDK_USER_ONRTNFROMBANKTOFUTUREBYFUTURE" : @20285,
                                 //期货发起期货资金转银行通知
                                 @"AS_SDK_USER_ONRTNFROMFUTURETOBANKBYFUTURE" : @20286,
                                 //系统运行时期货端手工发起冲正银行转期货请求，银行处理完毕后报盘发回的通知
                                 @"AS_SDK_USER_ONRTNREPEALFROMBANKTOFUTUREBYFUTUREMANUAL" : @20287,
                                 //系统运行时期货端手工发起冲正期货转银行请求，银行处理完毕后报盘发回的通知
                                 @"AS_SDK_USER_ONRTNREPEALFROMFUTURETOBANKBYFUTUREMANUAL" : @20288,
                                 //期货发起查询银行余额通知
                                 @"AS_SDK_USER_ONRTNQUERYBANKBALANCEBYFUTURE" : @20289,
                                 //期货发起银行资金转期货错误回报
                                 @"AS_SDK_USER_ONERRRTNBANKTOFUTUREBYFUTURE" : @20290,
                                 //期货发起期货资金转银行错误回报
                                 @"AS_SDK_USER_ONERRRTNFUTURETOBANKBYFUTURE" : @20291,
                                 //系统运行时期货端手工发起冲正银行转期货错误回报
                                 @"AS_SDK_USER_ONERRRTNREPEALBANKTOFUTUREBYFUTUREMANUAL" : @20292,
                                 //系统运行时期货端手工发起冲正期货转银行错误回报
                                 @"AS_SDK_USER_ONERRRTNREPEALFUTURETOBANKBYFUTUREMANUAL" : @20293,
                                 //期货发起查询银行余额错误回报
                                 @"AS_SDK_USER_ONERRRTNQUERYBANKBALANCEBYFUTURE" : @20294,
                                 //期货发起冲正银行转期货请求，银行处理完毕后报盘发回的通知
                                 @"AS_SDK_USER_ONRTNREPEALFROMBANKTOFUTUREBYFUTURE" : @20295,
                                 //期货发起冲正期货转银行请求，银行处理完毕后报盘发回的通知
                                 @"AS_SDK_USER_ONRTNREPEALFROMFUTURETOBANKBYFUTURE" : @20296,
                                 //期货发起银行资金转期货应答
                                 @"AS_SDK_USER_ONRSPFROMBANKTOFUTUREBYFUTURE" : @20297,
                                 //期货发起期货资金转银行应答
                                 @"AS_SDK_USER_ONRSPFROMFUTURETOBANKBYFUTURE" : @20298,
                                 //期货发起查询银行余额应答
                                 @"AS_SDK_USER_ONRSPQUERYBANKACCOUNTMONEYBYFUTURE" : @20399,
                                 //银行发起银期开户通知
                                 @"AS_SDK_USER_ONRTNOPENACCOUNTBYBANK" : @20300,
                                 //银行发起银期销户通知
                                 @"AS_SDK_USER_ONRTNCANCELACCOUNTBYBANK" : @20301,
                                 //银行发起变更银行账号通知
                                 @"AS_SDK_USER_ONRTNCHANGEACCOUNTBYBANK" : @20302,
                                 @"AS_SDK_USER_HEARTBEAT" : @20500,
                                 //行情推送
                                 @"AS_SDK_ONRTNDEPTHMARKETDATA" : @30001
                                 
                                 };
}

/**
 初始化路由
 */
-(void)initRoute{
    [[JLRoutes globalRoutes] addRoute:@"/user/view/:userID" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        NSString *userID = parameters[@"userID"];
        NSLog(@"userID --- %@",userID);
        return YES;
    }];
}
-(void)initSocketConnect{
     [[AMSSocketManager shareInstance] addSocketClient:SOCKET_NAME_DEFAULT withHost:SOCKET_HOST_DEFAULT withPort:SOCKET_PORT_DEFAULT];
}
/**
 监听网络发生变化之后的回调
 @param notification 通知内容
 */
-(void)networkChanged:(NSNotification*) notification{
    RealReachability *realReachaility = (RealReachability*)notification.object;
    ReachabilityStatus status = [realReachaility currentReachabilityStatus];
    NSLog(@"currentStatus:%@",@(status));
    switch (status) {
        case RealStatusNotReachable:
            [JDStatusBarNotification showWithStatus:@"当前无网络连接" dismissAfter:2 styleName:JDStatusBarStyleError];
            break;
        case RealStatusViaWiFi:
            [JDStatusBarNotification showWithStatus:@"已连接WiFi" dismissAfter:2 styleName:JDStatusBarStyleSuccess];
            break;
        case RealStatusViaWWAN:
            NSLog(@"当前有WWAN连接");
            if ([realReachaility currentWWANtype] == WWANType4G) {
                 [JDStatusBarNotification showWithStatus:@"已连接4G" dismissAfter:2 styleName:JDStatusBarStyleSuccess];
            }
            break;
        default:
            NSLog(@"未知网络连接");
            break;
    }
}
//处理挂单委托表
-(void)dealOrderInsertResponse:(User_Onrtnorder *)model{
    //这种情况下不处理
    if([model.OrderStatus isEqualToString:@"a"] && model.OrderSysID.length == 0){
        return;
    }
    [self.guadanOrderArray removeAllObjects];
    if (self.weituoOrderArray.count == 0) {
        [self.weituoOrderArray addObject:model];
    }else{
        __block BOOL exsitFlag = NO;
        [self.weituoOrderArray.copy enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            User_Onrtnorder *item = (User_Onrtnorder *)obj;
            //已存在合约
            if (item.InstrumentID == model.InstrumentID) { 
                //方向相同更新状态
                if ([item.Direction isEqualToString:model.Direction]) {
                    self.weituoOrderArray[idx] = model;
                    exsitFlag = YES;
                    *stop = YES;
                }
            }
        }];
        if (!exsitFlag) {
             [self.weituoOrderArray insertObject:model atIndex:0];
        }
    }
    [self.weituoOrderArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        User_Onrtnorder *model = (User_Onrtnorder *)obj;
        if (![model.OrderStatus isEqualToString:@"0"] && ![model.OrderStatus isEqualToString:@"2"]&& ![model.OrderStatus isEqualToString:@"5"] ) {
            [self.guadanOrderArray addObject:model];
        }
    }];
     [kNotificationCenter postNotificationName:UPDTAE_INSERT_ORDER_NOTIFICATION_NAME object:model];
}
//处理成交表
-(void)dealOrderTradeResponse:(User_Onrtntrade *)model{
    if (self.chengjiaoOrderArray.count == 0) {
        [self.chengjiaoOrderArray addObject:model];
    }else{
         __block BOOL exsitFlag = NO;
        [self.chengjiaoOrderArray.copy enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            User_Onrtntrade *item = (User_Onrtntrade *)obj;
            //已存在合约
            if ([item.TradeID isEqualToString:model.TradeID]) {
                self.chengjiaoOrderArray[idx] = model;
                 exsitFlag = YES;
                *stop = YES;
            }
        }];
        if (!exsitFlag) {
          [self.chengjiaoOrderArray insertObject:model atIndex:0];
        }
    }

    [kNotificationCenter postNotificationName:UPDTAE_TRADE_ORDER_NOTIFICATION_NAME object:nil];
}

//处理持仓表
-(void)dealOrderPosition:(NSArray *)models{
    //登录后的响应
    if (self.chicangOrderArray.count == 0) {
        [self.chicangOrderArray addObjectsFromArray:models];
    }else{
        User_Onrspqryinvestorposition *model = models.firstObject;
        [self.chicangOrderArray.copy enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            User_Onrspqryinvestorposition *item = (User_Onrspqryinvestorposition *)obj;
            //存在持仓先删除
            if ([item.InstrumentID isEqualToString:model.InstrumentID]) {
                [self.chicangOrderArray removeObject:item];
            }
        }];
        // 更新持仓
        NSRange range = NSMakeRange(0,models.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.chicangOrderArray insertObjects:models atIndexes:indexSet];
    }
    
}

@end
