//
//  AMSConstant.h
//  AMS
//
//  Created by jianlu on 2018/11/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#ifndef AMSConstant_h
#define AMSConstant_h

#define SOCKET_NAME_DEFAULT @"SOCKET_NAME_DEFAULT"
#define SOCKET_DID_CONNECT_NOTIFICATION_NAME @"SOCKET_DID_CONNECT_NOTIFICATION_NAME"
#define SOCKET_RESPONSE_ERROR_NOTIFICATION_NAME @"SOCKET_RESPONSE_ERROR_NOTIFICATION_NAME"
#define UPDTAE_INSERT_ORDER_NOTIFICATION_NAME @"UPDTAE_INSERT_ORDER_NOTIFICATION_NAME"
#define UPDTAE_TRADE_ORDER_NOTIFICATION_NAME @"UPDTAE_TRADE_ORDER_NOTIFICATION_NAME"
#define UPDTAE_CHICANG_ORDER_NOTIFICATION_NAME @"UPDTAE_CHICANG_ORDER_NOTIFICATION_NAME"
//#define SOCKET_HOST_DEFAULT @"10.131.11.161"//公司
//#define SOCKET_PORT_DEFAULT 1234
//#define SOCKET_HOST_DEFAULT @"192.168.189.134"//家
//#define SOCKET_PORT_DEFAULT 1234
#define SOCKET_HOST_DEFAULT @"10.131.4.157"//huangjie
#define SOCKET_PORT_DEFAULT 2235
#define HTTP_REQUEST_TIME 2


#define NEWS_URL @"https://www.baidu.com/"
#define MARKET_CELL_NAME_WIDTH (KScreenWidth - 20) / 4
#define MARKET_CELL_PRICE_WIDTH (KScreenWidth - 20) / 4
#define MARKET_CELL_FALLRISE_WIDTH (KScreenWidth - 20) / 4
#define MARKET_CELL_VOLUME_WIDTH (KScreenWidth - 20) / 4
//背景颜色
#define kNavBackGroundColor [UIColor zj_colorWithHexString:@"#21212D" alpha:1]
#define kBackGroundColor [UIColor zj_colorWithHexString:@"#1A1A26" alpha:1]
#define kCellBackGroundColor [UIColor zj_colorWithHexString:@"#21212D" alpha:1]
#define kTabBarBackGroundColor [UIColor zj_colorWithHexString:@"#21202E" alpha:1]
#define kTabBarSelectTextColor [UIColor zj_colorWithHexString:@"#C80E42" alpha:1]
#define kTabBarNormalTextColor [UIColor zj_colorWithHexString:@"#BFC0D2" alpha:1]
#define kTableViewBackGroundColor kBackGroundColor
#define kMenuRedBackGroundColor [UIColor zj_colorWithHexString:@"#C80E42" alpha:1]

//字体颜色
#define kNormalTextColor [UIColor zj_colorWithHexString:@"#BFC0D2" alpha:1]
#define kYellowTextColor [UIColor zj_colorWithHexString:@"#D5AC0E" alpha:1]
#define kGreenTextColor [UIColor zj_colorWithHexString:@"#1C9212" alpha:1]
#define kRedTextColor [UIColor zj_colorWithHexString:@"#9F0C0C" alpha:1]
#define kBlueTextColor [UIColor zj_colorWithHexString:@"#4899FF" alpha:1]
#define kTableViewHeaderGrayTextColor [UIColor zj_colorWithHexString:@"#B9B8CA" alpha:1]
#define klineBgLineRedColor [UIColor zj_colorWithHexString:@"#DA2638" alpha:1]
#define TIME_OUT 60
#define KEYBOARD_HEIGHT 265

typedef NS_ENUM(NSInteger,FallRiseBtnType) {
    FallRise = 0,//涨跌
    FallRisePer//涨幅
};

typedef NS_ENUM(NSInteger,VolumeBtnType) {
    Volume = 0,//成交量
    OpenInterest,//持仓量
    DailyIncrement//日增仓
};

typedef NS_ENUM(NSInteger,OrderPlaceSettingType) {
    Close = 0,//平仓
    Reverse,//反手
    Lock//锁单
};

typedef NS_ENUM(NSInteger,TradeCellMenuBtnType) {
    CloseBtn = 0,//平仓
    ReverseBtn,//反手
    LockBtn//锁单
};

//键盘相关
typedef NS_ENUM(NSInteger,CustomKeyBoardBtnType) {
    Zero = 0,
    One,
    Two,
    Three,
    Four,
    Five,
    Six,
    Seven,
    Eight,
    Nine,
    Decimal,//小数点
    Cancel,//清空
    Add,//加
    Minus,//减
    PaiDui_Price,//排队价
    DuiShou_Price,//对手价
    Shi_Price,//市价
    New_Price,//最新价
    Super_Price,//超价
    Hide//隐藏键盘
};

typedef NS_ENUM(NSInteger,Y_KlineViewType) {
    MainView = 0,//主图
    VolView,//成交量
    AccessoryView//辅助图
};

typedef NS_ENUM(NSInteger,ParamShowType) {
    NoneType= 0,//未显示
    LeftType,//在左边
    RightType//在右边
    
};
typedef NS_ENUM(NSInteger,ChartType) {
    PriceType = 0,//价格
    RisePerType,//涨跌幅
    VolumeType,//成交量
    MACDType,
};

typedef NS_ENUM(NSInteger,TradeReportViewType){
    ChiChangType = 0,
    GuaDanType,
    WeiTuoType,
    ChengjiaoType
};

typedef NS_ENUM(NSInteger,RequestType) {
    GET_Type,
    POST_Type
};
#define MAX_NUMBER_BEFORE_DECIMAL 6
#define MAX_NUMBER_AFTER_DECIMAL 2

//userDefaults 参数

#pragma mark 交易设置相关

#define CheckMark_Button_Tag 100
//交易声音提示
#define TRADE_SOUND_OPEN @"TRADE_SOUND_OPEN"
//平仓下单价格
#define CLOSE_ORDER_PRICE @"CLOSE_ORDER_PRICE"
//反手下单价格
#define REVERSE_ORDER_PRICE @"REVERSE_ORDER_PRICE"
//锁单下单价格
#define LOCK_ORDER_PRICE @"LOCK_ORDER_PRICE"

static NSString *kOrderPriceItems[4] = {
    @"对价",
    @"市价",
    @"排队价",
    @"最新价"
};

static NSString *kOrderPriceKeys[3] = {
    CLOSE_ORDER_PRICE,
    REVERSE_ORDER_PRICE,
    LOCK_ORDER_PRICE
};

static NSString *kHandicapParamNames[20] = {
    @"卖价",@"卖量",@"买价",@"买量",@"最新",@"涨跌",@"开盘",@"成交量",@"最高",@"持仓量",@"最低",@"日增仓",@"均价",@"外盘",@"结算",@"内盘",@"咋结",@"涨停",@"昨收",@"跌停"
};


#pragma mark 板块设置相关
#define PLATE_SETTING_DICT @"PLATE_SETTING_DICT"

#pragma mark k线图相关

#define MAIN_MAVIEW_HEADER 25
#define KLINE_PARAMVIEW_HEIGHT 368
#define TIMELINE_PARAMVIEW_HEIGHT 288
#define PARAMVIEW_WIDTH 83
#define ANIMATION_TIME 0.2
#define LeftXViewPadding 0
#define kNotification_Name_Param_Update @"kNotification_Name_Param_Update"
//交易表格宽度
#define REPORT_VIEW_BOARDER_WIDTH 1

//socket Response key define
#define Best_message_filed_key_prefix @"AS_SDK_"
#define function_FuncNo_key @"function_FuncNo"
#define packet_type_key @"packet_type"
//#define nRequestID @"packet_type"
//#define packet_type_key @"packet_type"


#pragma mark userdefaults
#define UserDefaults_User_Is_Login @"UserDefaults_User_Is_Login"
#define UserDefaults_User_ID_key @"UserDefaults_User_ID_key"
#define UserDefaults_User_Password_key @"UserDefaults_User_Password_key"

#pragma mark db相关
#define DB_NAME @"AMS.db"
#endif /* AMSConstant_h */
