//
//  LoginOutResponse.h
//  AMS
//
//  Created by jianlu on 2018/12/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "BaseResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginOutResponse : BaseResponseModel
@property(nonatomic,strong) NSNumber *is_UserLogout_null; //UserLogout是否为null    1->是null;0->不是null;
@property(nonatomic,copy) NSString *BrokerID; //经纪公司代码
@property(nonatomic,copy) NSString *UserID; //用户代码
@end

NS_ASSUME_NONNULL_END
