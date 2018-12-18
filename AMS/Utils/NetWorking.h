//
//  NetWorking.h
//  btc123
//
//  Created by jarze on 16/1/18.
//  Copyright © 2016年 btc123. All rights reserved.
//

#import <Foundation/Foundation.h>
#define BaseUrl @"http://47.100.198.54:8182"
#define QryQuotation_URL @"/FutureTrade/QryQuotation"
#define QryMinuteLine_URL @"/FutureTrade/QryMinuteLine"
#define QryKLine_URL @"/FutureTrade/QryKLine"
#define QryExchangeInstrust_URL @"/FutureTrade/QryExchangeInstrust"
#define QryExchangeAllInstrust_URL @"/FutureTrade/QryExchangeAllInstrust"

@interface NetWorking : NSObject

+(void)requestWithApi:(NSString *)url reqeustType:(RequestType)type param:(NSDictionary *)param thenSuccess:(void (^)(NSDictionary *responseObject))success fail:(void (^)(NSString*))fail;

+(void)request:(NSString *)url param:(NSMutableDictionary *)param thenSuccess:(void (^)(NSArray *responseObject))success fail:(void (^)(void))fail;

@end
