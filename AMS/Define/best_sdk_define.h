#ifndef BEST_MESSAGE_SDK_DEFINE_H
#define BEST_MESSAGE_SDK_DEFINE_H

typedef enum PLUG_NAME
{
	PLUG_BASE_MGR    = 1,
	PLUG_DATA_MGR    = 2,
	PLUG_CLIENT_MGR  = 3,
	PLUG_CTP_MGR     = 4,
	PLUG_MYSQL_MGR   = 5,
	PLUG_REDIS_MGR   = 6,
	PLUG_QUOTE_MGR   = 7,
	PLUG_CACULATE_PLUG = 8,
	PLUG_RISK_CONTROL_PLUG = 9,
}PLUG_NAME;

///数据管理模块内部
const int GW_ROUTE_MESSAGE_PHASE         = 10000 ;
const int GW_ROUTE_MESSAGE_PHASE_TREE    = 10001 ;
const int GW_ROUTE_MESSAGE_SRC_CONNECTID = 10002 ;
const int GW_ROUTE_MESSAGE_DATA_INTERNAL_REQUEST = 10003 ;
/// 数据类型：uint32; 域名：路由层错误号
const int GW_ROUTE_ERROR_NO  = 10003 ;
const int GW_ROUTE_MOUDLE_ID = 10004 ;
const int GW_ROUTE_ORDER_ID  = 10005 ;


///业务请求
//订阅私有流的数据。若不调用则不会收到私有流的数据。
const int AS_SDK_USER_SUBSCRIBEPRIVATETOPIC                   = 20001;
//订阅公有流的数据。若不调用则不会收到公共流的数据。
const int AS_SDK_USER_SUBSCRIBEPUBLICTOPIC                    = 20002;
//客户端认证请求
const int AS_SDK_USER_REQAUTHENTICATE                         = 20003;
//用户登录请求
const int AS_SDK_USER_REQUSERLOGIN                            = 20004;
//登出请求
const int AS_SDK_USER_REQUSERLOGOUT                           = 20005;
//用户口令更新请求
const int AS_SDK_USER_REQUSERPASSWORDUPDATE                   = 20006;
//资金账户口令更新请求
const int AS_SDK_USER_REQTRADINGACCOUNTPASSWORDUPDATE         = 20007;
//登录请求2
const int AS_SDK_USER_REQUSERLOGIN2                           = 20008;
//用户口令更新请求2
const int AS_SDK_USER_REQUSERPASSWORDUPDATE2                  = 20009;
//报单录入请求
const int AS_SDK_USER_REQORDERINSERT                          = 20010;
//预埋单录入请求
const int AS_SDK_USER_REQPARKEDORDERINSERT                    = 20011;
//预埋撤单录入请求
const int AS_SDK_USER_REQPARKEDORDERACTION                    = 20012;
//报单操作请求
const int AS_SDK_USER_REQORDERACTION                          = 20013;
//查询最大报单数量请求
const int AS_SDK_USER_REQQUERYMAXORDERVOLUME                  = 20014;
//投资者结算结果确认
const int AS_SDK_USER_REQSETTLEMENTINFOCONFIRM                = 20015;
//请求删除预埋单
const int AS_SDK_USER_REQREMOVEPARKEDORDER                    = 20016;
//请求删除预埋撤单
const int AS_SDK_USER_REQREMOVEPARKEDORDERACTION              = 20017;
//执行宣告录入请求
const int AS_SDK_USER_REQEXECORDERINSERT                      = 20018;
//执行宣告操作请求
const int AS_SDK_USER_REQEXECORDERACTION                      = 20019;
//询价录入请求
const int AS_SDK_USER_REQFORQUOTEINSERT                       = 20020;
//报价录入请求
const int AS_SDK_USER_REQQUOTEINSERT                          = 20021;
//报价操作请求
const int AS_SDK_USER_REQQUOTEACTION                          = 20022;
//批量报单操作请求
const int AS_SDK_USER_REQBATCHORDERACTION                     = 20023;
//期权自对冲录入请求
const int AS_SDK_USER_REQOPTIONSELFCLOSEINSERT                = 20024;
//期权自对冲操作请求
const int AS_SDK_USER_REQOPTIONSELFCLOSEACTION                = 20025;
//申请组合录入请求
const int AS_SDK_USER_REQCOMBACTIONINSERT                     = 20026;
//请求查询报单
const int AS_SDK_USER_REQQRYORDER                             = 20027;
//请求查询成交
const int AS_SDK_USER_REQQRYTRADE                             = 20028;
//请求查询投资者持仓
const int AS_SDK_USER_REQQRYINVESTORPOSITION                  = 20029;
//请求查询资金账户
const int AS_SDK_USER_REQQRYTRADINGACCOUNT                    = 20030;
//请求查询投资者
const int AS_SDK_USER_REQQRYINVESTOR                          = 20031;
//请求查询交易编码
const int AS_SDK_USER_REQQRYTRADINGCODE                       = 20032;
//请求查询合约保证金率
const int AS_SDK_USER_REQQRYINSTRUMENTMARGINRATE              = 20033;
//请求查询合约手续费率
const int AS_SDK_USER_REQQRYINSTRUMENTCOMMISSIONRATE          = 20034;
//请求查询交易所
const int AS_SDK_USER_REQQRYEXCHANGE                          = 20035;
//请求查询产品
const int AS_SDK_USER_REQQRYPRODUCT                           = 20036;
//请求查询合约
const int AS_SDK_USER_REQQRYINSTRUMENT                        = 20037;
//请求查询行情
const int AS_SDK_USER_REQQRYDEPTHMARKETDATA                   = 20038;
//请求查询投资者结算结果
const int AS_SDK_USER_REQQRYSETTLEMENTINFO                    = 20039;
//请求查询转帐银行
const int AS_SDK_USER_REQQRYTRANSFERBANK                      = 20040;
//请求查询投资者持仓明细
const int AS_SDK_USER_REQQRYINVESTORPOSITIONDETAIL            = 20041;
//请求查询客户通知
const int AS_SDK_USER_REQQRYNOTICE                            = 20042;
//请求查询结算信息确认
const int AS_SDK_USER_REQQRYSETTLEMENTINFOCONFIRM             = 20043;
//请求查询投资者持仓明细
const int AS_SDK_USER_REQQRYINVESTORPOSITIONCOMBINEDETAIL     = 20044;
//请求查询保证金监管系统经纪公司资金账户密钥
const int AS_SDK_USER_REQQRYCFMMCTRADINGACCOUNTKEY            = 20045;
//请求查询仓单折抵信息
const int AS_SDK_USER_REQQRYEWARRANTOFFSET                    = 20046;
//请求查询投资者品种/跨品种保证金
const int AS_SDK_USER_REQQRYINVESTORPRODUCTGROUPMARGIN        = 20047;
//请求查询交易所保证金率
const int AS_SDK_USER_REQQRYEXCHANGEMARGINRATE                = 20048;
//请求查询交易所调整保证金率
const int AS_SDK_USER_REQQRYEXCHANGEMARGINRATEADJUST          = 20049;
//请求查询汇率
const int AS_SDK_USER_REQQRYEXCHANGERATE                      = 20050;
//请求查询二级代理操作员银期权限
const int AS_SDK_USER_REQQRYSECAGENTACIDMAP                   = 20051;
//请求查询产品报价汇率
const int AS_SDK_USER_REQQRYPRODUCTEXCHRATE                   = 20052;
//请求查询产品组
const int AS_SDK_USER_REQQRYPRODUCTGROUP                      = 20053;
//请求查询做市商合约手续费率
const int AS_SDK_USER_REQQRYMMINSTRUMENTCOMMISSIONRATE        = 20054;
//请求查询做市商期权合约手续费
const int AS_SDK_USER_REQQRYMMOPTIONINSTRCOMMRATE             = 20055;
//请求查询报单手续费
const int AS_SDK_USER_REQQRYINSTRUMENTORDERCOMMRATE           = 20056;
//请求查询资金账户
const int AS_SDK_USER_REQQRYSECAGENTTRADINGACCOUNT            = 20057;
//请求查询二级代理商资金校验模式
const int AS_SDK_USER_REQQRYSECAGENTCHECKMODE                 = 20058;
//请求查询期权交易成本
const int AS_SDK_USER_REQQRYOPTIONINSTRTRADECOST              = 20059;
//请求查询期权合约手续费
const int AS_SDK_USER_REQQRYOPTIONINSTRCOMMRATE               = 20060;
//请求查询执行宣告
const int AS_SDK_USER_REQQRYEXECORDER                         = 20061;
//请求查询询价
const int AS_SDK_USER_REQQRYFORQUOTE                          = 20062;
//请求查询报价
const int AS_SDK_USER_REQQRYQUOTE                             = 20063;
//请求查询期权自对冲
const int AS_SDK_USER_REQQRYOPTIONSELFCLOSE                   = 20064;
//请求查询投资单元
const int AS_SDK_USER_REQQRYINVESTUNIT                        = 20065;
//请求查询组合合约安全系数
const int AS_SDK_USER_REQQRYCOMBINSTRUMENTGUARD               = 20066;
//请求查询申请组合
const int AS_SDK_USER_REQQRYCOMBACTION                        = 20067;
//请求查询转帐流水
const int AS_SDK_USER_REQQRYTRANSFERSERIAL                    = 20068;
//请求查询银期签约关系
const int AS_SDK_USER_REQQRYACCOUNTREGISTER                   = 20069;
//请求查询签约银行
const int AS_SDK_USER_REQQRYCONTRACTBANK                      = 20070;
//请求查询预埋单
const int AS_SDK_USER_REQQRYPARKEDORDER                       = 20071;
//请求查询预埋撤单
const int AS_SDK_USER_REQQRYPARKEDORDERACTION                 = 20072;
//请求查询交易通知
const int AS_SDK_USER_REQQRYTRADINGNOTICE                     = 20073;
//请求查询经纪公司交易参数
const int AS_SDK_USER_REQQRYBROKERTRADINGPARAMS               = 20074;
//请求查询经纪公司交易算法
const int AS_SDK_USER_REQQRYBROKERTRADINGALGOS                = 20075;
//请求查询监控中心用户令牌
const int AS_SDK_USER_REQQUERYCFMMCTRADINGACCOUNTTOKEN        = 20076;
//期货发起银行资金转期货请求
const int AS_SDK_USER_REQFROMBANKTOFUTUREBYFUTURE             = 20077;
//期货发起期货资金转银行请求
const int AS_SDK_USER_REQFROMFUTURETOBANKBYFUTURE             = 20078;
//期货发起查询银行余额请求
const int AS_SDK_USER_REQQUERYBANKACCOUNTMONEYBYFUTURE        = 20079;


//ctp报单通知
//const int AS_SDK_ONRTN_ORDER_INSERT                           = 20080;//废弃的名称
const int AS_SDK_USER_ONRTNORDER                              = 20080;//正式名称
//ctp报单操作请求(撤单)的响应
//const int AS_SDK_ONRTN_USER_REQORDERACTION                    = 20081;//废弃的名称
const int AS_SDK_USER_ONRSPORDERACTION                        = 20081;//正式名称
//ctp成交通知
//const int AS_SDK_ONRTN_USER_ORDERTRADE                        = 20082;//废弃的名称
const int AS_SDK_USER_ONRTNTRADE                              = 20082;//正式名称

//查询报单响应
const int AS_SDK_USER_ONRSPQRYORDER                                = 20083;
//查询成交响应
const int AS_SDK_USER_ONRSPQRYTRADE                                = 20084;
//查询投资者持仓响应
const int AS_SDK_USER_ONRSPQRYINVESTORPOSITION                     = 20085;
//查询资金账户响应
const int AS_SDK_USER_ONRSPQRYTRADINGACCOUNT                       = 20086;
//查询合约响应
const int AS_SDK_USER_ONRSPQRYINSTRUMENT                           = 20087;
//查询合约响应(主账户)
const int AS_SDK_USER_ONRSPQRYINSTRUMENT_MAIN_ACCOUNT              = 20088;
//查询投资者持仓响应(主账户)
const int AS_SDK_USER_ONRSPQRYINVESTORPOSITION_MAIN_ACCOUNT        = 20089;
//查询报单响应(主账户)
const int AS_SDK_USER_ONRSPQRYORDER_MAIN_ACCOUNT                   = 20090;
//查询成交响应(主账户)
const int AS_SDK_USER_ONRSPQRYTRADE_MAIN_ACCOUNT                   = 20091;
//查询投资者持仓明细响应(主账户)
const int AS_SDK_USER_ONRSPQRYINVESTORPOSITIONDETAIL_MAIN_ACCOUNT  = 20092;
//查询资金账户响应(主账户)
const int AS_SDK_USER_ONRSPQRYTRADINGACCOUNT_MAIN_ACCOUNT          = 20093;
//登录请求响应(主账户)
const int AS_SDK_USER_ONRSPUSERLOGIN_MAIN_ACCOUNT                  = 20094;
//查询投资者持仓明细响应
const int AS_SDK_USER_ONRSPQRYINVESTORPOSITIONDETAIL               = 20095;
//报单有错误时的报单录入请求响应
const int AS_SDK_USER_ONRSPORDERINSERT                             = 20096;
//查询深度行情响应(主账户)
const int AS_SDK_USER_ONRSPQRYDEPTHMARKETDATA_MAIN_ACCOUNT         = 20097;
//登录请求响应
const int AS_SDK_USER_ONRSPUSERLOGIN                               = 20098;
//登出请求响应
const int AS_SDK_USER_ONRSPUSERLOGOUT                              = 20099;
//用户登录后推送的报单通知
const int AS_SDK_USER_ONRTNORDER_AFTER_LOGIN                       = 20100;
//用户登录后推送的成交通知
const int AS_SDK_USER_ONRTNTRADE_AFTER_LOGIN                       = 20101;
//请求查询行情(主账户)
const int AS_SDK_USER_REQQRYDEPTHMARKETDATA_MAIN_ACCOUNT           = 20102;
//开始结算
const int AS_SDK_USER_START_SETTLEMENT                             = 20103;
//投资者结算结果确认的响应
const int AS_SDK_USER_ONRSPSETTLEMENTINFOCONFIRM                   = 20104;
//查询结算信息确认的响应
const int AS_SDK_USER_ONRSPQRYSETTLEMENTINFOCONFIRM                = 20105;
//查询投资者结算结果的响应
const int AS_SDK_USER_ONRSPQRYSETTLEMENTINFO                       = 20106;
//单个分账户完成结算
const int AS_SDK_USER_SETTLEMENT_FINISH                            = 20107;

//客户端认证响应
const int AS_SDK_USER_ONRSPAUTHENTICATE                            = 20200;
//用户口令更新请求响应
const int AS_SDK_USER_ONRSPUSERPASSWORDUPDATE                      = 20201;
//资金账户口令更新请求响应
const int AS_SDK_USER_ONRSPTRADINGACCOUNTPASSWORDUPDATE            = 20202;
//预埋单录入请求响应
const int AS_SDK_USER_ONRSPPARKEDORDERINSERT                       = 20203;
//预埋撤单录入请求响应
const int AS_SDK_USER_ONRSPPARKEDORDERACTION                       = 20204;
//查询最大报单数量响应
const int AS_SDK_USER_ONRSPQUERYMAXORDERVOLUME                     = 20205;
//删除预埋单响应
const int AS_SDK_USER_ONRSPREMOVEPARKEDORDER                       = 20206;
//删除预埋撤单响应
const int AS_SDK_USER_ONRSPREMOVEPARKEDORDERACTION                 = 20207;
//执行宣告录入请求响应
const int AS_SDK_USER_ONRSPEXECORDERINSERT                         = 20208;
//执行宣告操作请求响应
const int AS_SDK_USER_ONRSPEXECORDERACTION                         = 20209;
//询价录入请求响应
const int AS_SDK_USER_ONRSPFORQUOTEINSERT                          = 20210;
//报价录入请求响应
const int AS_SDK_USER_ONRSPQUOTEINSERT                             = 20211;
//报价操作请求响应
const int AS_SDK_USER_ONRSPQUOTEACTION                             = 20212;
//批量报单操作请求响应
const int AS_SDK_USER_ONRSPBATCHORDERACTION                        = 20213;
//期权自对冲录入请求响应
const int AS_SDK_USER_ONRSPOPTIONSELFCLOSEINSERT                   = 20214;
//期权自对冲操作请求响应
const int AS_SDK_USER_ONRSPOPTIONSELFCLOSEACTION                   = 20215;
//申请组合录入请求响应
const int AS_SDK_USER_ONRSPCOMBACTIONINSERT                        = 20216;
//请求查询投资者响应
const int AS_SDK_USER_ONRSPQRYINVESTOR                             = 20217;
//请求查询交易编码响应
const int AS_SDK_USER_ONRSPQRYTRADINGCODE                          = 20218;
//请求查询合约保证金率响应
const int AS_SDK_USER_ONRSPQRYINSTRUMENTMARGINRATE                 = 20219;
//请求查询合约手续费率响应
const int AS_SDK_USER_ONRSPQRYINSTRUMENTCOMMISSIONRATE             = 20220;
//请求查询交易所响应
const int AS_SDK_USER_ONRSPQRYEXCHANGE                             = 20221;
//请求查询产品响应
const int AS_SDK_USER_ONRSPQRYPRODUCT                              = 20222;
//请求查询行情响应
const int AS_SDK_USER_ONRSPQRYDEPTHMARKETDATA                      = 20223;
//请求查询转帐银行响应
const int AS_SDK_USER_ONRSPQRYTRANSFERBANK                         = 20224;
//请求查询客户通知响应
const int AS_SDK_USER_ONRSPQRYNOTICE                               = 20225;
//请求查询投资者持仓明细响应(组合持仓明细)
const int AS_SDK_USER_ONRSPQRYINVESTORPOSITIONCOMBINEDETAIL        = 20226;
//查询保证金监管系统经纪公司资金账户密钥响应
const int AS_SDK_USER_ONRSPQRYCFMMCTRADINGACCOUNTKEY               = 20227;
//请求查询仓单折抵信息响应
const int AS_SDK_USER_ONRSPQRYEWARRANTOFFSET                       = 20228;
//请求查询投资者品种/跨品种保证金响应
const int AS_SDK_USER_ONRSPQRYINVESTORPRODUCTGROUPMARGIN           = 20229;
//请求查询交易所保证金率响应
const int AS_SDK_USER_ONRSPQRYEXCHANGEMARGINRATE                   = 20230;
//请求查询交易所调整保证金率响应
const int AS_SDK_USER_ONRSPQRYEXCHANGEMARGINRATEADJUST             = 20231;
//请求查询汇率响应
const int AS_SDK_USER_ONRSPQRYEXCHANGERATE                         = 20232;
//请求查询二级代理操作员银期权限响应
const int AS_SDK_USER_ONRSPQRYSECAGENTACIDMAP                      = 20233;
//请求查询产品报价汇率
const int AS_SDK_USER_ONRSPQRYPRODUCTEXCHRATE                      = 20234;
//请求查询产品组
const int AS_SDK_USER_ONRSPQRYPRODUCTGROUP                         = 20235;
//请求查询做市商合约手续费率响应
const int AS_SDK_USER_ONRSPQRYMMINSTRUMENTCOMMISSIONRATE           = 20236;
//请求查询做市商期权合约手续费响应
const int AS_SDK_USER_ONRSPQRYMMOPTIONINSTRCOMMRATE                = 20237;
//请求查询报单手续费响应
const int AS_SDK_USER_ONRSPQRYINSTRUMENTORDERCOMMRATE              = 20238;
//请求查询资金账户响应
const int AS_SDK_USER_ONRSPQRYSECAGENTTRADINGACCOUNT               = 20239;
//请求查询二级代理商资金校验模式响应
const int AS_SDK_USER_ONRSPQRYSECAGENTCHECKMODE                    = 20240;
//请求查询期权交易成本响应
const int AS_SDK_USER_ONRSPQRYOPTIONINSTRTRADECOST                 = 20241;
//请求查询期权合约手续费响应
const int AS_SDK_USER_ONRSPQRYOPTIONINSTRCOMMRATE                  = 20242;
//请求查询执行宣告响应
const int AS_SDK_USER_ONRSPQRYEXECORDER                            = 20243;
//请求查询询价响应
const int AS_SDK_USER_ONRSPQRYFORQUOTE                             = 20244;
//请求查询报价响应
const int AS_SDK_USER_ONRSPQRYQUOTE                                = 20245;
//请求查询期权自对冲响应
const int AS_SDK_USER_ONRSPQRYOPTIONSELFCLOSE                      = 20246;
//请求查询投资单元响应
const int AS_SDK_USER_ONRSPQRYINVESTUNIT                           = 20247;
//请求查询组合合约安全系数响应
const int AS_SDK_USER_ONRSPQRYCOMBINSTRUMENTGUARD                  = 20248;
//请求查询申请组合响应
const int AS_SDK_USER_ONRSPQRYCOMBACTION                           = 20249;
//请求查询转帐流水响应
const int AS_SDK_USER_ONRSPQRYTRANSFERSERIAL                       = 20250;
//请求查询银期签约关系响应
const int AS_SDK_USER_ONRSPQRYACCOUNTREGISTER                      = 20251;
//错误应答
const int AS_SDK_USER_ONRSPERROR                                   = 20252;
//报单录入错误回报
const int AS_SDK_USER_ONERRRTNORDERINSERT                          = 20253;
//报单操作错误回报
const int AS_SDK_USER_ONERRRTNORDERACTION                          = 20254;
//合约交易状态通知
const int AS_SDK_USER_ONRTNINSTRUMENTSTATUS                        = 20255;
//交易所公告通知
const int AS_SDK_USER_ONRTNBULLETIN                                = 20256;
//交易通知
const int AS_SDK_USER_ONRTNTRADINGNOTICE                           = 20257;
//提示条件单校验错误
const int AS_SDK_USER_ONRTNERRORCONDITIONALORDER                   = 20258;
//执行宣告通知
const int AS_SDK_USER_ONRTNEXECORDER                               = 20259;
//执行宣告录入错误回报
const int AS_SDK_USER_ONERRRTNEXECORDERINSERT                      = 20260;
//执行宣告操作错误回报
const int AS_SDK_USER_ONERRRTNEXECORDERACTION                      = 20261;
//询价录入错误回报
const int AS_SDK_USER_ONERRRTNFORQUOTEINSERT                       = 20262;
//报价通知
const int AS_SDK_USER_ONRTNQUOTE                                   = 20263;
//报价录入错误回报
const int AS_SDK_USER_ONERRRTNQUOTEINSERT                          = 20264;
//报价操作错误回报
const int AS_SDK_USER_ONERRRTNQUOTEACTION                          = 20265;
//询价通知
const int AS_SDK_USER_ONRTNFORQUOTERSP                             = 20266;
//保证金监控中心用户令牌
const int AS_SDK_USER_ONRTNCFMMCTRADINGACCOUNTTOKEN                = 20267;
//批量报单操作错误回报
const int AS_SDK_USER_ONERRRTNBATCHORDERACTION                     = 20268;
//期权自对冲通知
const int AS_SDK_USER_ONRTNOPTIONSELFCLOSE                         = 20269;
//期权自对冲录入错误回报
const int AS_SDK_USER_ONERRRTNOPTIONSELFCLOSEINSERT                = 20270;
//期权自对冲操作错误回报
const int AS_SDK_USER_ONERRRTNOPTIONSELFCLOSEACTION                = 20271;
//申请组合通知
const int AS_SDK_USER_ONRTNCOMBACTION                              = 20272;
//申请组合录入错误回报
const int AS_SDK_USER_ONERRRTNCOMBACTIONINSERT                     = 20273;
//请求查询签约银行响应
const int AS_SDK_USER_ONRSPQRYCONTRACTBANK                         = 20274;
//请求查询预埋单响应
const int AS_SDK_USER_ONRSPQRYPARKEDORDER                          = 20275;
//请求查询预埋撤单响应
const int AS_SDK_USER_ONRSPQRYPARKEDORDERACTION                    = 20276;
//请求查询交易通知响应
const int AS_SDK_USER_ONRSPQRYTRADINGNOTICE                        = 20277;
//请求查询经纪公司交易参数响应
const int AS_SDK_USER_ONRSPQRYBROKERTRADINGPARAMS                  = 20278;
//请求查询经纪公司交易算法响应
const int AS_SDK_USER_ONRSPQRYBROKERTRADINGALGOS                   = 20279;
//请求查询监控中心用户令牌
const int AS_SDK_USER_ONRSPQUERYCFMMCTRADINGACCOUNTTOKEN           = 20280;
//银行发起银行资金转期货通知
const int AS_SDK_USER_ONRTNFROMBANKTOFUTUREBYBANK                  = 20281;
//银行发起期货资金转银行通知
const int AS_SDK_USER_ONRTNFROMFUTURETOBANKBYBANK                  = 20282;
//银行发起冲正银行转期货通知
const int AS_SDK_USER_ONRTNREPEALFROMBANKTOFUTUREBYBANK            = 20283;
//银行发起冲正期货转银行通知
const int AS_SDK_USER_ONRTNREPEALFROMFUTURETOBANKBYBANK            = 20284;
//期货发起银行资金转期货通知
const int AS_SDK_USER_ONRTNFROMBANKTOFUTUREBYFUTURE                = 20285;
//期货发起期货资金转银行通知
const int AS_SDK_USER_ONRTNFROMFUTURETOBANKBYFUTURE                = 20286;
//系统运行时期货端手工发起冲正银行转期货请求，银行处理完毕后报盘发回的通知
const int AS_SDK_USER_ONRTNREPEALFROMBANKTOFUTUREBYFUTUREMANUAL    = 20287;
//系统运行时期货端手工发起冲正期货转银行请求，银行处理完毕后报盘发回的通知
const int AS_SDK_USER_ONRTNREPEALFROMFUTURETOBANKBYFUTUREMANUAL    = 20288;
//期货发起查询银行余额通知
const int AS_SDK_USER_ONRTNQUERYBANKBALANCEBYFUTURE                = 20289;
//期货发起银行资金转期货错误回报
const int AS_SDK_USER_ONERRRTNBANKTOFUTUREBYFUTURE                 = 20290;
//期货发起期货资金转银行错误回报
const int AS_SDK_USER_ONERRRTNFUTURETOBANKBYFUTURE                 = 20291;
//系统运行时期货端手工发起冲正银行转期货错误回报
const int AS_SDK_USER_ONERRRTNREPEALBANKTOFUTUREBYFUTUREMANUAL     = 20292;
//系统运行时期货端手工发起冲正期货转银行错误回报
const int AS_SDK_USER_ONERRRTNREPEALFUTURETOBANKBYFUTUREMANUAL     = 20293;
//期货发起查询银行余额错误回报
const int AS_SDK_USER_ONERRRTNQUERYBANKBALANCEBYFUTURE             = 20294;
//期货发起冲正银行转期货请求，银行处理完毕后报盘发回的通知
const int AS_SDK_USER_ONRTNREPEALFROMBANKTOFUTUREBYFUTURE          = 20295;
//期货发起冲正期货转银行请求，银行处理完毕后报盘发回的通知
const int AS_SDK_USER_ONRTNREPEALFROMFUTURETOBANKBYFUTURE          = 20296;
//期货发起银行资金转期货应答
const int AS_SDK_USER_ONRSPFROMBANKTOFUTUREBYFUTURE                = 20297;
//期货发起期货资金转银行应答
const int AS_SDK_USER_ONRSPFROMFUTURETOBANKBYFUTURE                = 20298;
//期货发起查询银行余额应答
const int AS_SDK_USER_ONRSPQUERYBANKACCOUNTMONEYBYFUTURE           = 20399;
//银行发起银期开户通知
const int AS_SDK_USER_ONRTNOPENACCOUNTBYBANK                       = 20300;
//银行发起银期销户通知
const int AS_SDK_USER_ONRTNCANCELACCOUNTBYBANK                     = 20301;
//银行发起变更银行账号通知
const int AS_SDK_USER_ONRTNCHANGEACCOUNTBYBANK                     = 20302;
const int AS_SDK_USER_HEARTBEAT                     = 20500;
//行情推送
const int AS_SDK_ONRTNDEPTHMARKETDATA                              = 30001;

#endif
