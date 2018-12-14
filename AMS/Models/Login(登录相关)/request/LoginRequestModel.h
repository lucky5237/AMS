//
//  LoginModel.h
//  AMS
//  登录请求
//  Created by jianlu on 2018/12/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "BaseRequsetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginRequestModel : BaseRequsetModel
@property(nonatomic,copy) NSString *TradingDay;//交易日
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *UserID;//用户代码
@property(nonatomic,copy) NSString *Password;//密码
@property(nonatomic,copy) NSString *UserProductInfo;//用户端产品信息
@property(nonatomic,copy) NSString *InterfaceProductInfo;//接口端产品信息
@property(nonatomic,copy) NSString *ProtocolInfo;//协议信息
@property(nonatomic,copy) NSString *MacAddress;//Mac地址
@property(nonatomic,copy) NSString *OneTimePassword;//动态密码
@property(nonatomic,copy) NSString *ClientIPAddress;//终端IP地址
@property(nonatomic,copy) NSString *LoginRemark;//登录备注

@end

NS_ASSUME_NONNULL_END
