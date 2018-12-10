//
//  NetWorking.h
//  btc123
//
//  Created by jarze on 16/1/18.
//  Copyright © 2016年 btc123. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorking : NSObject
+(void)Get:(NSString*) url params:(id)params success:(void (^)(NSDictionary *response))success fail:(void(^)(NSDictionary *info))fail;
+(void)requestWithApi:(NSString *)url param:(NSMutableDictionary *)param thenSuccess:(void (^)(NSDictionary *responseObject))success fail:(void (^)(void))fail;

+(void)request:(NSString *)url param:(NSMutableDictionary *)param thenSuccess:(void (^)(NSArray *responseObject))success fail:(void (^)(void))fail;

@end
