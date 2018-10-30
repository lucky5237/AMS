//
//  AMSSocketClient.m
//  AMS
//
//  Created by jianlu on 2018/10/25.
//  Copyright © 2018年 jianlu. All rights reserved.
//

#import "AMSSocketClient.h"
#define AMSSocketHost @"10.131.11.161"//Host地址
#define AMSSocketPort 1234 //端口号

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
    if(self.isConnected){
        NSLog(@"socket 已连接");
        return;
    }
    NSLog(@"socket 正在连接---");
    [self cutOffSocket];
    NSError *error;
    [self connectToHost:self.socketHost onPort:self.socketPort viaInterface:nil withTimeout:-1 error:&error];
    if (error) {
        NSLog(@"socket连接出错--%@",error);
    }
}

/**
 切断Socket
 */
-(void)cutOffSocket{
    [self disconnect];
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
    NSLog(@"模拟发送心跳包");
    NSString *heartPackPrama = @"heartBeat";
    [self writeData: [heartPackPrama dataUsingEncoding:NSUTF8StringEncoding] withTimeout:1 tag:1];
}



@end
