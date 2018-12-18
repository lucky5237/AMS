//
//  BaseResponseModel.h
//  AMS
//
//  Created by jianlu on 2018/12/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
//#import "best_message.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseResponseModel : NSObject
@property(nonatomic,strong)NSNumber *function_FuncNo;
@property(nonatomic,strong)NSNumber *packet_type;
@property(nonatomic,strong)NSNumber *is_RspInfo_null;//RspInfo是否为null    1->是null;0->不是null
@property(nonatomic,strong)NSNumber *ErrorID_in_RspInfo ;//错误代码   0-正确，其他错误
@property(nonatomic,copy)NSString *ErrorMsg_in_RspInfo;//错误信息
@property(nonatomic,strong)NSNumber *nRequestID;//请求的编号
@property(nonatomic,strong)NSNumber *bIsLast;//是否最后一条    1->是最后一条;0->不是最后一条


@end

NS_ASSUME_NONNULL_END
