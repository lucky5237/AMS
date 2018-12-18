//
//  QryMinuteLineResponse.m
//  AMS
//
//  Created by jianlu on 2018/12/16.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "QryMinuteLineResponseModel.h"

@implementation QryMinuteLineResponseModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"periodTypeList" : [AMSPeriodTypeList class]};
}
@end

@implementation QryMinuteLineMdata
@end

@implementation AMSStockInfo
@end

@implementation AMSPeriodTypeList
@end

@implementation AMSTimeSharingList
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"periodAxisData" : [AMSPeriodAxisDatum class],
             @"periodData" : AMSPeriodDatum.class,};
}
@end

@implementation AMSPeriodAxisDatum
@end

@implementation AMSPeriodDatum
@end
