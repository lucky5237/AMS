//
//  LoginResponseModel.h
//  AMS
//
//  Created by jianlu on 2018/12/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginResponseModel : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_RspUserLogin_null; //RspUserLogin是否为null    1->是null;0->不是null
@property(nonatomic,strong) NSNumber *FrontID; //前置编号
@property(nonatomic,strong) NSNumber *SessionID; //会话编号
@property(nonatomic,copy) NSString *TradingDay; //交易日
@property(nonatomic,copy) NSString *LoginTime; //登录成功时间
@property(nonatomic,copy) NSString *BrokerID; //经纪公司代码
@property(nonatomic,copy) NSString *UserID; //用户代码
@property(nonatomic,copy) NSString *SystemName; //交易系统名称
@property(nonatomic,copy) NSString *MaxOrderRef; //最大报单引用
@property(nonatomic,copy) NSString *SHFETime; //上期所时间
@property(nonatomic,copy) NSString *DCETime; //大商所时间
@property(nonatomic,copy) NSString *CZCETime; //郑商所时间
@property(nonatomic,copy) NSString *FFEXTime; //中金所时间
@property(nonatomic,copy) NSString *INETime; //能源中心时间
@end

NS_ASSUME_NONNULL_END
