//
//  SocketRequestManager.m
//  AMS
//
//  Created by jianlu on 2018/12/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "SocketRequestManager.h"
#import "AMSSocketManager.h"
#import "BestMessageUtil.h"
#import "best_sdk_define.h"
#import "field_key.h"
#import "LoginRequestModel.h"
#import "LoginResponseModel.h"

@implementation SocketRequestManager
+(SocketRequestManager*) shareInstance{
    static SocketRequestManager *manager = nil;
    static dispatch_once_t onceSocketToken;
    dispatch_once(&onceSocketToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}



-(void)doLogin:(LoginRequestModel *)model{
  NSData* data = [BestMessageUtil generateBestMsg:AS_SDK_USER_REQUSERLOGIN modelClass:model];
  [[AMSSocketManager shareInstance] writeData:data toSocket:SOCKET_NAME_DEFAULT];
}
-(void)loginOut{
    
}
@end
