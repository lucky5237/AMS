//
//  AMSConstant.h
//  AMS
//
//  Created by jianlu on 2018/11/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#ifndef AMSConstant_h
#define AMSConstant_h

#define NEWS_URL @"http://baidu.com"
#define MARKET_CELL_NAME_WIDTH (KScreenWidth - 10) / 4
#define MARKET_CELL_PRICE_WIDTH (KScreenWidth - 10) / 4
#define MARKET_CELL_FALLRISE_WIDTH (KScreenWidth - 10) / 4
#define MARKET_CELL_VOLUME_WIDTH (KScreenWidth - 10) / 4

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

//userDefaults 参数
//交易声音提示
#define TRADE_SOUND_OPEN @"TRADE_SOUND_OPEN"
//平仓下单价格
#define CLOSE_ORDER_PRICE @"CLOSE_ORDER_PRICE"
//反手下单价格
#define REVERSE_ORDER_PRICE @"REVERSE_ORDER_PRICE"
//锁单下单价格
#define LOCK_ORDER_PRICE @"LOCK_ORDER_PRICE"

#endif /* AMSConstant_h */
