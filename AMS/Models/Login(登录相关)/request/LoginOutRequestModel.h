//
//  LoginOutRequestModel.h
//  AMS
//  登出请求
//  Created by jianlu on 2018/12/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "BaseRequsetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginOutRequestModel : BaseRequsetModel
@property(nonatomic,copy) NSString *BrokerID;//经纪公司代码
@property(nonatomic,copy) NSString *UserID;//用户代码
@end

NS_ASSUME_NONNULL_END
