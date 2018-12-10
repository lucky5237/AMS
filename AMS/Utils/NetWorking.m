//
//  NetWorking.m
//  btc123
//
//  Created by jarze on 16/1/18.
//  Copyright © 2016年 btc123. All rights reserved.
//

#import "NetWorking.h"
#import <AFNetworking.h>
@implementation NetWorking
+ (void)Get:(NSString*) url params:(id)params success:(void (^)(NSDictionary *response))success fail:(void(^)(NSDictionary *info))fail {
    if ([url isEqualToString:@"minute"]) {
        success([NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"minuteData" ofType:@"plist"]]);
    }
    if ([url isEqualToString:@"day"]) {
        success([NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dayData" ofType:@"plist"]]);
    }
    if ([url isEqualToString:@"five"]) {
        success([NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fiveData" ofType:@"plist"]]);
    }
}

+(void)requestWithApi:(NSString *)url param:(NSMutableDictionary *)param thenSuccess:(void (^)(NSDictionary *responseObject))success fail:(void (^)(void))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            !success ? : success(responseObject);
        });
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            !fail ? : fail();
        });
    }];
    
    
}
+(void)request:(NSString *)url param:(NSMutableDictionary *)param thenSuccess:(void (^)(NSArray *responseObject))success fail:(void (^)(void))fail{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            !success ? : success(responseObject);
        });
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            !fail ? : fail();
        });
    }];
}
@end
