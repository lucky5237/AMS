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
#import "User_Onrspuserlogin.h"
#import "User_Onrspqryinstrument.h"
#import "AMSConstant.h"
#import "AppDelegate.h"
#import "ConfigModel.h"
#import "AppDelegate+AppSevice.h"
#import "User_Reqqryinvestorposition.h"
#import "SocketRequestManager.h"
#import "User_Onrtnorder.h"
#import "User_Onrtntrade.h"
//#import "SocketResponseManager.h"

@interface AMSSocketManager()<GCDAsyncSocketDelegate>

/**
 socket字典
 */
@property(nonatomic,strong) NSMutableDictionary *socketClientDict;
@property(nonatomic,assign) BOOL readRPCHead;
@property(nonatomic,strong) NSMutableData* readBuf;
@property(nonatomic,strong)NSMutableArray *mResponseArray;
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

-(NSMutableData *)readBuf{
    if (!_readBuf) {
        _readBuf = [NSMutableData data];
    }
    return _readBuf;
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

-(NSMutableArray *)mResponseArray{
    if (!_mResponseArray) {
        _mResponseArray = [NSMutableArray array];
    }
    return _mResponseArray;
}
/**
 添加socket连接
 @param tag 标识符
 @param host 主机host
 @param port 主机port
 */
-(AMSSocketClient *)addSocketClient:(NSString *)tag withHost:(NSString *)host withPort:(NSUInteger)port{
    
    NSLog(@"----正在新增tag为%@的socket连接----",tag);
    if (tag == nil || tag.length == 0 ) {
        NSLog(@"tag不能为空");
        return nil;
    }
    if([[self.socketClientDict allKeys] containsObject:tag]){
        AMSSocketClient *socketClient = [self socketClient:tag];
        //socketClient没连接的情况下，连接socket
        if (socketClient!= nil && !socketClient.isConnected) {
            [socketClient socketConnectHost];
        }else{
            NSLog(@"tag为%@的socket已处于连接状态",tag);
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
    //    NSLog(@"----获取socket连接----");
    if (tag == nil || tag.length == 0) {
        NSLog(@"Tag不能为空");
        return nil;
    }
    //    AMSSocketClient *socketClient;
    //    if (![[self.socketClientDict allKeys] containsObject:tag]) {
    //        NSLog(@"获取socket连接---tag为%@的socket为空",tag);
    ////        if ([tag isEqualToString:SOCKET_NAME_DEFAULT]) {
    ////            socketClient = [self addSocketClient:tag withHost:SOCKET_HOST_DEFAULT withPort:SOCKET_PORT_DEFAULT];
    ////        }
    //    }else{
    //        socketClient = (AMSSocketClient *)[self.socketClientDict objectForKey:tag];
    //    }
    //
    return (AMSSocketClient *)[self.socketClientDict objectForKey:tag];
}

/**
 断开socket连接
 @param tag tag唯一标识
 */
-(void)cutOffSocketClient:(NSString *)tag{
    
    if (tag == nil || tag.length == 0) {
        NSLog(@"socket的Tag不能为空");
        return;
    }
    NSLog(@"----主动断开连接tag为%@----",tag);
    if (![[self.socketClientDict allKeys] containsObject:tag]) {
        NSLog(@"不存在key为%@的socket",tag);
        return ;
    }
    
    AMSSocketClient *socketClient = [self socketClient:tag];
    socketClient.offlineType = AMSSocketOfflineCutByUser;
    [socketClient cutOffSocket];
    NSLog(@"tag为%@的socket连接已断开",tag);
}

-(void)cutOffAllClient{
    NSLog(@"----主动断开所有socket连接----");
    if (self.socketClientDict.count == 0) {
        NSLog(@"当前没有连接的socket");
        return;
    }
    [self.socketClientDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *tag = key;
        [self cutOffSocketClient:tag];
    }];
}


/**
 socket写数据
 
 @param data 要写的数据
 @param tag 要写的socket的tag
 */
-(void)writeData:(NSData*)data toSocket:(NSString*)tag{
//    NSLog(@"----开始发送数据----");
//    AMSSocketClient *toClient = [self socketClient:tag];
//    if (toClient == nil) {
//        [MBProgressHUD showErrorMessage:@"未连接服务器"];
//        NSLog(@"tag 为%@的socket不存在",tag);
//        return;
//    }
//    if (toClient.isConnected == YES) {
//        [toClient writeData:data withTimeout:- 1 tag:0];
//        NSLog(@"发送数据,数据已发送");
//    }else{
//        NSLog(@"----发送数据,socket未连接----");
//        [toClient socketConnectHost];
//    }
    [self writeData:data toSocket:tag tag:0];
}

-(void)writeData:(NSData*)data toSocket:(NSString*)name tag:(NSInteger)tag{
    NSLog(@"----开始发送数据----");
    AMSSocketClient *toClient = [self socketClient:name];
    if (toClient == nil) {
        [MBProgressHUD showErrorMessage:@"未连接服务器"];
        NSLog(@"tag 为%@的socket不存在",name);
        return;
    }
    if (toClient.isConnected == YES) {
        [toClient writeData:data withTimeout:- 1 tag:tag];
        NSLog(@"发送数据,数据已发送");
    }else{
        NSLog(@"----发送数据,socket未连接----");
        [toClient socketConnectHost];
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
    client.reconnectCount = 0;
    client.offlineType = AMSSocketOfflineOutTime;
    [self.socketClientDict setObject:client forKey:sock.userData];
    NSLog(@"----Socket(tag = %@)连接成功，host = %@，port = %d ,当前共有%ld个连接----",client.userData,host,port,self.socketClientDict.count);
    [client startTimer];
    [kNotificationCenter postNotificationName:SOCKET_DID_CONNECT_NOTIFICATION_NAME object:client.userData];
    //连接后开始读取服务端数据
    //    [client readDataToLength:40 withTimeout:-1 tag:0];
    _readBuf = [[NSMutableData alloc] init];
//    NSString *userId = [kUserDefaults objectForKey:UserDefaults_User_ID_key];
//    NSString *password = [kUserDefaults objectForKey:UserDefaults_User_Password_key];
//    if (userId!=nil && userId.length > 0 &&  password!=nil && password.length > 0   ) {
//        [requestm]
//    }
    [client readDataWithTimeout:-1 tag:0];
//    self.readRPCHead = YES;
}
/**socket断开连接*/
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    AMSSocketClient *client = (AMSSocketClient*) sock;    NSLog(@"----socket (tag = %@)断开连接，%@----",sock.userData,err.localizedDescription);
    [self.socketClientDict removeObjectForKey:sock.userData];
    
    //判断网络，网络不好的情况下不重连
    if(client.offlineType == AMSSocketOfflineCutByUser){
        [client cutOffSocket];
        client.delegate = nil;
        client = nil;
        NSLog(@"用户主动断开Socket（tag = %@）的连接",client.userData);
    }else{
        if (client.reconnectCount >= AMSReconnectTime) {
            NSLog(@"Socket（tag = %@)连接超过最大限度%d次,不再重连",client.userData, AMSReconnectTime);
            [client cutOffSocket];
            [MBProgressHUD hideHUD];
            [MBProgressHUD showErrorMessage:@"服务器连接失败"];
            client.delegate = nil;
            client = nil;
        }else{
            client.reconnectCount ++;
            NSLog(@"Socket（tag = %@) 正尝试第%ld次重连",client.userData,(long)client.reconnectCount);
            [client socketConnectHost];
        }
    }
}

-(void)handleTcpResponseData:(NSData*)data socket:(GCDAsyncSocket *)sock tag:(long)tag{
//    NSLog(@"handleTcpResponseData -- data length is %ld",data.length);
    const void* message = data.bytes;
    int32 length = (int32)data.length;
    InitBestMessge();
    best_protocol::IBestMessgeFactory *m_factory = CreateBestMessgeFactrotyInstance();
    best_protocol::IBestMessge* phase_best_message = m_factory->CreateBestMessage();
    phase_best_message->SetBuffer(message, length);
    phase_best_message->Deserialize();
    best_protocol::IBestRPCHead* rpcHeader = phase_best_message ->GetRpcHead();
    if (rpcHeader != NULL) {
        auto functionNo = rpcHeader->GetFuncNo();
        if(functionNo != 0){
            NSLog(@"fuctionNo  is  %u",functionNo);
        }else{
            NSLog(@"fuctionNo  is  0");
        }
    }else{
        NSLog(@"rpcHeader is NULL");
    }
    best_protocol::IBestDataMessage* dataMessage = [BestMessageUtil GetBestMessageDataMessage:phase_best_message index:0];
    //说明正确，解析数据
    int32 functionNo = phase_best_message->GetRpcHead()->GetFuncNo();
    if (dataMessage) {
        
        if(dataMessage->GetField(FIELD_KEY_is_RspInfo_null)->GetInt32() == 0 && dataMessage->GetField(FIELD_KEY_ErrorID_in_RspInfo)->GetInt32() != 0){
            //    说明错误,展示错误信息
            
            const char * errorMessage = dataMessage ->GetField(FIELD_KEY_ErrorMsg_in_RspInfo) ->GetString();
            //                    NSData *data = [[NSData alloc] initWithBytes:errorMessage length:strlen(errorMessage)];
            NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            NSString * errorMsg = [[NSString alloc] initWithCString:errorMessage encoding:gbkEncoding];
            if (errorMsg.length > 0) {
                //发送名字为tag的通知
               
                [[NSNotificationCenter defaultCenter] postNotificationName:SOCKET_RESPONSE_ERROR_NOTIFICATION_NAME object:@{@"functionNo":@(functionNo),@"errorMsg":errorMsg}];
                
                NSLog(@"RESPONSE有错误--- %@",errorMsg);
            }else{
                NSLog(@"RESPONSE有错误 消息为空");
            }
        }else{
          //特殊处理的响应
            //心跳答复
            if(functionNo == AS_SDK_USER_HEARTBEAT){
                [(AMSSocketClient*)sock resetHeartBeatTime];
            }else{
                NSArray *array = [kAppDelegate.configModel.BESTSDKDEFINE_DICTS allKeysForObject:@(functionNo)];
                
                if (array != nil && array.count > 0) {
                    NSString *key = array[0];
                    NSString *prefix = Best_message_filed_key_prefix;
                    if ([key hasPrefix:prefix]) {
                        key = [key substringFromIndex:prefix.length];
                        key = [key capitalizedString];
                        Class clazz = NSClassFromString(key);
                        id model = [[clazz alloc] init];
                        if (clazz !=nil) {
                            model = [BestMessageUtil modelWithDataMessage:dataMessage modelClass:clazz];
                            //判断响应是否有mlast字段，有则等待到结束通知，否则立即响应
                            if (dataMessage -> IsExistField(FIELD_KEY_bIsLast)) {
                                [self.mResponseArray addObject:model];
                                if (dataMessage->GetField(FIELD_KEY_bIsLast)->GetInt32() == 1) {
                                    
                                    //查询持仓
                                    if (functionNo == AS_SDK_USER_ONRSPQRYINVESTORPOSITION){
                                        if(tag == 999){
                                            //发送通知
                                            
                                            [kNotificationCenter postNotificationName:UPDTAE_CHICANG_ORDER_NOTIFICATION_NAME object:nil];
                                        }else{
                                            //持仓表响应
                                            [kAppDelegate dealOrderPosition:self.mResponseArray];
                                        }
                                      
                                        
                                    }else{
                                        [kNotificationCenter postNotificationName:sock.userData object:@{@"functionNo":@(functionNo),@"response":self.mResponseArray.copy}];
                                    }
                                   [self.mResponseArray removeAllObjects];
                                }
                            }else{
                                //报单响应
                                if(functionNo == AS_SDK_USER_ONRTNORDER){
                                   
                                    NSLog(@"报单响应 ---- %@",[model yy_modelToJSONString]);
                                        [kAppDelegate dealOrderInsertResponse:model];
                                    //查询持仓
                                    User_Reqqryinvestorposition *request = [[User_Reqqryinvestorposition alloc] init];
                                    request.BrokerID = @"9999";
                                    User_Onrtnorder *res = (User_Onrtnorder *)model;
                                    request.InstrumentID = res.InstrumentID;
                                    request.InvestorID = [kUserDefaults objectForKey:UserDefaults_User_ID_key];
                                    [[SocketRequestManager shareInstance]  reqqryinvestorposition:request];
                                    
                                }else if (functionNo == AS_SDK_USER_ONRTNORDER_AFTER_LOGIN){
                                     NSLog(@"登录后的报单响应 ---- %@",[model yy_modelToJSONString]);
                                     [kAppDelegate dealOrderInsertResponse:model];
                                    
                                }
                                
                                else if(functionNo == AS_SDK_USER_ONRTNTRADE){
                                      NSLog(@"成交响应 ---- %@",[model yy_modelToJSONString]);
                                    //成交通知
                                    [kAppDelegate dealOrderTradeResponse:model];
//                                    //普通成交通知还要更新持仓明细
                                    //                                    if(functionNo == AS_SDK_USER_ONRTNTRADE){
                                    User_Onrtntrade *item  = (User_Onrtntrade *)model;
                                    User_Reqqryinvestorposition *request = [[User_Reqqryinvestorposition alloc] init];
                                    request.BrokerID = @"9999";
                                    request.InstrumentID = item.InstrumentID;
                                    request.InvestorID = [kUserDefaults objectForKey:UserDefaults_User_ID_key];
                                    [[SocketRequestManager shareInstance]  reqqryinvestorposition:request];

                                }else if (functionNo == AS_SDK_USER_ONRTNTRADE_AFTER_LOGIN){
                                     NSLog(@"登录后的成交响应 ---- %@",[model yy_modelToJSONString]);
                                      [kAppDelegate dealOrderTradeResponse:model];
                                }
                                
                                else{
                                     [kNotificationCenter postNotificationName:sock.userData object:@{@"functionNo":@(functionNo),@"response":@[model]}];
                                }
                            }

                        }
                    }
                }else{
                    DLog(@"model 不存在,请添加该model");
                }
            }
            
        }
    }else{
        NSLog(@"response DATA MESSAGE is NULL");
    }
    phase_best_message->Release();
}

/**读取到服务端数据*/
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"----读取到数据----");
    dispatch_async(dispatch_get_main_queue(), ^{
        if (data.length > 0) {
            [self.readBuf appendData:data];
            
        }
        
        //我们这边定义的head的长度为16个字节，按具体情况。如果大于16个字节就循环取包
        while (self.readBuf.length > 40) {
            
            NSData *head = [self.readBuf subdataWithRange:NSMakeRange(0, 40)];//取得头部数据
            auto rpcHead = [BestMessageUtil packMessageRPCHead:head];
            
            NSInteger packageLength = rpcHead ->GetTotalLenght();//得出内容长度
            
            //从head中取出和服务器协商的消息协议
            //        NSData *operation = [head subdataWithRange:NSMakeRange(8, 4)];;
            //如果包的长度没有实际包的长度，读取数据等下次拼接
            if (packageLength > self.readBuf.length) {
                [sock readDataWithTimeout:-1 tag:0];
                return;
            }
            //        取出boday
            NSData *bodyData = [self.readBuf subdataWithRange:NSMakeRange(0, packageLength)];
            
            //从cacheData中去掉已读取的数据
            self.readBuf = [NSMutableData dataWithData:[self.readBuf subdataWithRange:NSMakeRange(packageLength, self.readBuf.length - packageLength)]];
            
//            __weak typeof(self) weakSelf = self;
//            dispatch_async(dispatch_get_main_queue(), ^{
                //异步处理数据，根据不同数据类型处理不同的事件
            [self handleTcpResponseData:bodyData socket:sock tag:tag];
                
//            });
        }
        
        [sock readDataWithTimeout:-1 tag:0];
    });

}

     
     @end
