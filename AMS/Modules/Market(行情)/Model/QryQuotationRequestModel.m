//
//  QryQuotationRequestModel.m
//  AMS
//
//  Created by jianlu on 2018/12/19.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "QryQuotationRequestModel.h"
@class QryQuotationRequestSubModel;

@implementation QryQuotationRequestModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"stockTradeMins" : [QryQuotationRequestSubModel class]};
}

@end

@implementation QryQuotationRequestSubModel



@end
