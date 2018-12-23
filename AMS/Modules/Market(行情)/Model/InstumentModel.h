//
//  InstumentModel.h
//  AMS
//
//  Created by jianlu on 2018/12/22.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User_Onrspqryinstrument.h"
#import "InstrumentDBModel.h"
#import "QryQuotationResponseModel.h"
NS_ASSUME_NONNULL_BEGIN


@interface InstumentModel : NSObject

@property(nonatomic,strong) User_Onrspqryinstrument *instrument;
@property(nonatomic,strong) AMSLdatum * quotation;
@property(nonatomic,assign) BOOL hasCollect;
-(instancetype) initWithInstumentDBModel:(InstrumentDBModel*)dbModel;

@end

NS_ASSUME_NONNULL_END
