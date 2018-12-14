//
//  SocketRequestManager.h
//  AMS
//
//  Created by jianlu on 2018/12/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "default_message.h"

NS_ASSUME_NONNULL_BEGIN
@class LoginRequestModel;
@interface SocketRequestManager : NSObject
+(SocketRequestManager*) shareInstance;
+(NSDictionary *)responseDictWithBestMessage:(best_protocol::IBestMessage *)bestMessage;
-(void)doLogin:(LoginRequestModel *)model;
-(void)loginOut;

@end

NS_ASSUME_NONNULL_END
