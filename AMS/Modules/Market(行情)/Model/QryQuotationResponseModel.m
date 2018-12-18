//
//  AMSQryQuotationResponse.m
//  AMS
//
//  Created by jianlu on 2018/12/16.
//  Copyright © 2018 jianlu. All rights reserved.
//

// AMSQryQuotationResponse.m

#import "QryQuotationResponseModel.h"

@implementation QryQuotationResponseModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"ldata" : [AMSLdatum class]};
}
@end

@implementation AMSLdatum
@end

@implementation QryQuotationTimeDescription
@end

@implementation QryQuotationMdata
@end
