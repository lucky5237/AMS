//
//  BaseHttpResponseModel.h
//  AMS
//
//  Created by jianlu on 2018/12/16.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseHttpResponseModel<T> : NSObject
@property(nonatomic,assign) NSInteger result;
@property(nonatomic,copy) NSString *message;
@property(nonatomic,strong) T mdata;
@property(nonatomic,strong) NSDictionary *ldata;
@property(nonatomic,copy) NSString *rows;
@property(nonatomic,copy) NSString *total;
@end

NS_ASSUME_NONNULL_END
