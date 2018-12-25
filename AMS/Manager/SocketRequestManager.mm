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
#import "User_Requserlogin.h"
#import "User_Onrspuserlogin.h"
#import "User_Requserlogout.h"
#import "User_Onrspuserlogout.h"
#import "User_Reqorderinsert.h"
#import "User_Reqqryinvestorposition.h"
#import "User_Reqqrytrade.h"
#import "User_Reqqrytradingaccount.h"
@implementation SocketRequestManager
+(SocketRequestManager*) shareInstance{
    static SocketRequestManager *manager = nil;
    static dispatch_once_t onceSocketToken;
    dispatch_once(&onceSocketToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

//-(void)doSocketRequest:(int32)functionNo className:(NSString*)clazzName{
//    NSData* data = [BestMessageUtil generateBestMsg:functionNo modelClass:NSClassFromString(clazzName)];
//    [[AMSSocketManager shareInstance] writeData:data toSocket:SOCKET_NAME_DEFAULT];
//}

-(void)doLogin:(User_Requserlogin *)model{
  NSData* data = [BestMessageUtil generateBestMsg:AS_SDK_USER_REQUSERLOGIN model:model];
  [[AMSSocketManager shareInstance] writeData:data toSocket:SOCKET_NAME_DEFAULT];
}
-(void)loginOut{
    User_Requserlogout *request = [[User_Requserlogout alloc] init];
    request.UserID = [kUserDefaults objectForKey:UserDefaults_User_ID_key];
    request.BrokerID = @"9999";
    NSData* data = [BestMessageUtil generateBestMsg:AS_SDK_USER_REQUSERLOGOUT model:request];
    [[AMSSocketManager shareInstance] writeData:data toSocket:SOCKET_NAME_DEFAULT];
}

-(void)qryInstrument:(User_Reqqryinstrument *)model{
    NSData* data = [BestMessageUtil generateBestMsg:AS_SDK_USER_REQQRYINSTRUMENT model:model];
    [[AMSSocketManager shareInstance] writeData:data toSocket:SOCKET_NAME_DEFAULT tag:999];
}

-(void)reqorderinsert:(User_Reqorderinsert *)model{
    NSData* data = [BestMessageUtil generateBestMsg:AS_SDK_USER_REQORDERINSERT model:model];
    [[AMSSocketManager shareInstance] writeData:data toSocket:SOCKET_NAME_DEFAULT];
}

-(void)reqqryinvestorposition:(User_Reqqryinvestorposition *)model{
    NSData* data = [BestMessageUtil generateBestMsg:AS_SDK_USER_REQQRYINVESTORPOSITION model:model];
    [[AMSSocketManager shareInstance] writeData:data toSocket:SOCKET_NAME_DEFAULT];
}

-(void)reqqrytrade:(User_Reqqrytrade *)model{
    NSData* data = [BestMessageUtil generateBestMsg:AS_SDK_USER_REQQRYTRADE model:model];
    [[AMSSocketManager shareInstance] writeData:data toSocket:SOCKET_NAME_DEFAULT];
}
-(void)reqqrytradingaccount:(User_Reqqrytradingaccount*)model{
    NSData* data = [BestMessageUtil generateBestMsg:AS_SDK_USER_REQQRYTRADINGACCOUNT model:model];
    [[AMSSocketManager shareInstance] writeData:data toSocket:SOCKET_NAME_DEFAULT];
}
@end
