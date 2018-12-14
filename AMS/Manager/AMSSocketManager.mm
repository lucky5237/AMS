//
//  AMSSocketManager.m
//  SocketDemo
//
//  Created by jianlu on 2018/10/23.
//  Copyright © 2018年 jianlu. All rights reserved.
//

#import "AMSSocketManager.h"
#import "AMSSocketClient.h"
#import <GCDAsyncSocket.h>
#import "field_key.h"
#import "best_sdk_define.h"
#import "BestMessageUtil.h"
#import "LoginResponseModel.h"
#import "SocketResponseManager.h"

@interface AMSSocketManager()<GCDAsyncSocketDelegate>

/**
 socket字典
 */
@property(nonatomic,strong) NSMutableDictionary *socketClientDict;


@end


@implementation AMSSocketManager

+(AMSSocketManager*) shareInstance{
    static AMSSocketManager *manager = nil;
    static dispatch_once_t onceSocketToken;
    dispatch_once(&onceSocketToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

//-(instancetype)init{
//    if (self = [super init]) {
//        self.socketHost = AMSSocketHost;
//        self.socketPort = AMSSocketPort;
//        self.reconnectCount = 1;
//        self.offlineType = AMSSocketOfflineOutTime;
//    }
//    return self;
//}
#pragma mark 懒加载
//-(GCDAsyncSocket *)clientSocket{
//    if (!_clientSocket) {
//        _clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
//    }
//    return _clientSocket;
//}

-(NSMutableDictionary *)socketClientDict{
    if (!_socketClientDict) {
        _socketClientDict = [NSMutableDictionary dictionary];
    }
    return _socketClientDict;
}
/**
 添加socket连接
 @param tag 标识符
 @param host 主机host
 @param port 主机port
 */
-(AMSSocketClient *)addSocketClient:(NSString *)tag withHost:(NSString *)host withPort:(NSUInteger)port{
    if (tag == nil || tag.length == 0 ) {
        NSLog(@"客户端Tag标识符不能为空");
        return nil;
    }
    if([[self.socketClientDict allKeys] containsObject:tag]){
        AMSSocketClient *socketClient = [self socketClient:tag];
        //socketClient没连接的情况下，连接socket
        if (socketClient!= nil && !socketClient.isConnected) {
            [socketClient socketConnectHost];
        }else{
            NSLog(@"socketClient已连接");
        }
        return socketClient;
    }else{
        AMSSocketClient *socketClient = [[AMSSocketClient alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        [socketClient setTag:tag withHost:host withPort:port];
        [socketClient socketConnectHost];
        return socketClient;
    }
}

/**
 获取socket连接实例
 @param tag tag唯一标识符
 @return socket实例
 */
-(AMSSocketClient *)socketClient:(NSString *)tag{
    if (tag == nil || tag.length == 0) {
        NSLog(@"获取socket连接---Tag不能为空");
        return nil;
    }
    AMSSocketClient *socketClient;
    if (![[self.socketClientDict allKeys] containsObject:tag]) {
        NSLog(@"获取socket连接---key为%@的socket为空",tag);
        if ([tag isEqualToString:SOCKET_NAME_DEFAULT]) {
            socketClient = [self addSocketClient:tag withHost:SOCKET_HOST_DEFAULT withPort:SOCKET_PORT_DEFAULT];
        }
    }else{
        socketClient = (AMSSocketClient *)[self.socketClientDict objectForKey:tag];
    }
    
    return socketClient;
}

/**
 断开socket连接
 @param tag tag唯一标识
 */
-(void)removeSocketClient:(NSString *)tag{
    if (tag == nil || tag.length == 0) {
        NSLog(@"断开连接---socketTag不能为空");
        return;
    }
    if (![[self.socketClientDict allKeys] containsObject:tag]) {
        NSLog(@"断开连接---key为%@的socket为空",tag);
        return ;
    }
    AMSSocketClient *socketClient = [self socketClient:tag];
    socketClient.offlineType = AMSSocketOfflineCutByUser;
    [socketClient cutOffSocket];
    NSLog(@"tag为%@的socket连接已断开",tag);
}


/**
 socket写数据
 
 @param data 要写的数据
 @param tag 要写的socket的tag
 */
-(void)writeData:(NSData*)data toSocket:(NSString*)tag{
    AMSSocketClient *toClient = [self socketClient:tag];
    if (toClient == nil) {
        return;
    }
    if (toClient.isConnected == YES) {
        NSLog(@"发送数据成功");
        // withTimeout -1 : 无穷大,一直等
        // tag : 消息标记
        [toClient writeData:data withTimeout:- 1 tag:0];
    }else{
        NSLog(@"socket未连接，无法发送数据");
    }
}

-(void)showSocketDictInfo{
    NSLog(@"当前socket字典---%@",self.socketClientDict.description);
}

#pragma mark GCDAsyncSocketDelegate 代理相关
/**socket连接成功*/
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    
    //连接成功开启定时器
    AMSSocketClient *client = (AMSSocketClient *)sock;
    client.reconnectCount = 1;
    client.offlineType = AMSSocketOfflineOutTime;
    [self.socketClientDict setObject:client forKey:sock.userData];
    NSLog(@"socket(tag = %@)连接成功，host=%@，port=%d ,当前共有%ld个连接",client.userData,host,port,self.socketClientDict.count);
    [client startTimer];
    //连接后开始读取服务端数据
    [client readDataWithTimeout:-1 tag:0];
}

/**socket断开连接*/
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    AMSSocketClient *client = (AMSSocketClient*) sock;
    [self.socketClientDict removeObjectForKey:sock.userData];
    NSLog(@"socket (tag = %@)断开连接，%@",sock.userData,err);
    //判断网络，网络不好的情况下不重连
    if(client.offlineType == AMSSocketOfflineCutByUser){
        client.delegate = nil;
        client = nil;
        NSLog(@"用户主动切断网络断开，不重连");
    }else{
        if (client.reconnectCount >= AMSReconnectTime) {
            NSLog(@"连接超过最大限度%d次数,不再重连",AMSReconnectTime);
            client.delegate = nil;
            client = nil;
        }else{
            client.reconnectCount++;
            NSLog(@"正尝试第%ld次重连",(long)client.reconnectCount);
            [client socketConnectHost];
        }
    }
}

/**读取到服务端数据*/
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    AMSSocketClient *client = (AMSSocketClient*) sock;
    
//    NSLog(@"socket(tag = %@)读取到数据----- %@",sock.userData,text);
    best_protocol::IBestMessge* bestMessage = [BestMessageUtil packMessage:data];
    best_protocol::IBestDataMessage* dataMessage = [BestMessageUtil GetBestMessageDataMessage:bestMessage index:0];
    if (dataMessage) {
        //rsp != null
        if(dataMessage->GetField(FIELD_KEY_is_RspInfo_null)->GetInt8() == 0 && dataMessage->GetField(FIELD_KEY_ErrorID_in_RspInfo)->GetInt8() != 0){
            //	说明错误,展示错误信息
                NSString *errorMsg = [NSString stringWithUTF8String:dataMessage->GetField(FIELD_KEY_ErrorMsg_in_RspInfo)->GetString()];
                if (errorMsg.length > 0) {
                    //发送名字为tag的通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:SOCKET_RESPONSE_ERROR_NOTIFICATION_NAME object:errorMsg];
                    NSLog(@"RESPONSE有错误--- %@",errorMsg);
                }else{
                    NSLog(@"RESPONSE有错误消息为空");
                }
        }else{
            //说明正确，解析数据
            int32 functionNo = bestMessage->GetRpcHead()->GetFuncNo();
            NSString *responseJson;
            switch (functionNo) {
                    //登录响应
                case AS_SDK_USER_ONRSPUSERLOGIN:{
                    LoginResponseModel* loginResponse = (LoginResponseModel*)[BestMessageUtil modelWithDataMessage:dataMessage modelClass:[LoginResponseModel class]];
                    responseJson = [LoginResponseModel yy_modelToJSONString];
                    break;
                }
            
                default:
                    break;
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:sock.userData object:responseJson];
        }
//        else{
//            bestMessage ->GetRpcHead()->GetFuncNo();
//            //RESPONSE 正确，解析数据
//            NSDictionary *responseDict = @{};
        
//        }
//        const char* username= routeHead->GetField(FIELD_KEY_UserID)->GetString();
//        const char* password = routeHead->GetField(FIELD_KEY_Password)->GetString();
//
//        NSLog(@"username = %s ,password = %s",username,password);
        
    }
   
    
   
    // 读取到服务端数据值后,能再次读取
    [client readDataWithTimeout:- 1 tag:0];
}

@end