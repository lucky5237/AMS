//
//  BestMessageUtil.h
//  AMS
//
//  Created by jianlu on 2018/10/30.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "default_message.h"
NS_ASSUME_NONNULL_BEGIN

@interface BestMessageUtil : NSObject
+(NSData *)GenerateBestMsg:(NSString*)message;//生成best消息
+(best_protocol::IBestMessge*)packMessage:(NSData*)data;
@end

NS_ASSUME_NONNULL_END
