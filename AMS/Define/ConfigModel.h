//
//  ConfigModel.h
//  AMS
//
//  Created by jianlu on 2018/12/19.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface ConfigModel : NSObject
@property (copy,nonatomic) NSDictionary *FIELD_KEY_DICTS;
@property (copy,nonatomic) NSDictionary *BESTSDKDEFINE_DICTS;
@property (copy,nonatomic) NSArray *delegateReport;
@end

NS_ASSUME_NONNULL_END
