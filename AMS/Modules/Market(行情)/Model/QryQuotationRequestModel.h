//
//  QryQuotationRequestModel.h
//  AMS
//
//  Created by jianlu on 2018/12/19.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QryQuotationRequestModel : NSObject
@property(nonatomic,copy)NSArray *stockTradeMins;
@end

@interface QryQuotationRequestSubModel: NSObject
@property(nonatomic,copy)NSString *stockCodeInternal;
@property(nonatomic,copy)NSString *tradeMins;
@end

NS_ASSUME_NONNULL_END
