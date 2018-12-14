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
@class BaseResponseModel;
@interface BestMessageUtil : NSObject
+(best_protocol::IBestDataMessage*) GetBestMessageDataMessage:(best_protocol::IBestMessge* )lpBestMsg index:(int32) iIndex;
+(best_protocol::IBestHeadMessage* )GetBestRouteHead:(best_protocol::IBestMessge* )lpBestMsg index:(int32) iIndex;
+(NSData *)generateBestMsg:(uint32)fucntionType modelClass:(id)model;
+(best_protocol::IBestMessge*)packMessage:(NSData*)data;
+(int32)generateRequestID;
+(best_protocol::IBestHeadMessage*)generateCommonField;
+(id)modelWithDataMessage:(best_protocol::IBestDataMessage*)dataMessage modelClass:(Class) clazz;
@end

NS_ASSUME_NONNULL_END
