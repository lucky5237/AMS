//
//  QryKLineResponseModel.m
//  AMS
//
//  Created by jianlu on 2018/12/16.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "QryKLineResponseModel.h"


@implementation QryKLineResponseModel
@end

@implementation QryKLineMdata
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [AMSList class]};
}
@end

@implementation AMSList
@end
