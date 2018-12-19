//
//  AMSSocketClient.m
//  AMS
//
//  Created by jianlu on 2018/10/25.
//  Copyright © 2018年 jianlu. All rights reserved.
//

#import "AMSSocketClient.h"
#import "BestMessageUtil.h"
#import "AMSSocketManager.h"

@interface AMSSocketClient()

/**
 服务器地址
 */
@property(nonatomic,copy) NSString *socketHost;

/**
 端口号
 */
@property(nonatomic,assign) uint16_t socketPort;

/**
 心跳计时器
 */
@property(nonatomic,strong) NSTimer *socketTimer;


@end
@implementation AMSSocketClient

-(instancetype)initWithDelegate:(id<GCDAsyncSocketDelegate>)aDelegate delegateQueue:(dispatch_queue_t)dq{
    if (self = [super initWithDelegate:aDelegate delegateQueue:dq]) {
        self.reconnectCount = 0;
        self.heartBeatCount = 0;
        self.offlineType = AMSSocketOfflineOutTime;
    }
    return self;
}

/**
 设置socket属性

 @param tag tag值（唯一标识）
 @param host 主机host
 @param port 主机port
 */
-(void)setTag:(NSString *)tag withHost:(NSString *)host withPort:(uint16_t)port{
        self.socketHost = host;
        self.socketPort = port;
        self.userData = tag;
}

#pragma mark 实例方法
/**
 连接Socket
 */
-(void)socketConnectHost{
     NSLog(@"----开始连接tag为%@的socket----",self.userData);
    if(self.isConnected){
        NSLog(@"tag为的%@socket已处于连接状态",self.userData);
        return;
    }
    NSLog(@"----tag为%@的socket正在连接----",self.userData);
    if (self.socketTimer) {
        [self.socketTimer invalidate];
        self.socketTimer = nil;
    }
    NSError *error;
    [self connectToHost:self.socketHost onPort:self.socketPort viaInterface:nil withTimeout:-1 error:&error];
    if (error) {
        NSLog(@"tag为%@的socket连接出错----%@",self.userData,error);
    }
}

/**
 切断Socket
 */
-(void)cutOffSocket{
    [self disconnectAfterReadingAndWriting];
    if (self.socketTimer) {
        [self.socketTimer invalidate];
        self.socketTimer = nil;
    }
} 

/**
 开始心跳计时器
 */
-(void)startTimer{
    if (self.socketTimer) {
        [self.socketTimer invalidate];
        self.socketTimer = nil;
    }
    self.socketTimer = [NSTimer scheduledTimerWithTimeInterval:AMSSocketTimerTime target:self selector:@selector(socketTimerConnectSocket) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.socketTimer forMode:NSRunLoopCommonModes];
}

/**
 心跳检测方法
 */
- (void)socketTimerConnectSocket{
    //与后台定义发送心跳包
//    NSLog(@"----Socket(%@)发送心跳包----",self.userData);
//    if (self.heartBeatCount < AMSHeartBeatTime) {
//        self.heartBeatCount ++;
//        [[AMSSocketManager shareInstance] writeData: [BestMessageUtil generateHeartBeatMessage]toSocket:self.userData];
////        [se writeData: [BestMessageUtil generateHeartBeatMessage] withTimeout:1 tag:1];
//
//    }else{
//        NSLog(@"心跳连接超出最大次数，断开连接");
//        [self cutOffSocket];
//    }
//    NSString *heartPackPrama = @"heartBeat";
//    [self writeData: [heartPackPrama dataUsingEncoding:NSUTF8StringEncoding] withTimeout:1 tag:1];
}

-(void)resetHeartBeatTime{
    self.heartBeatCount = 0;
}


@end
