//
//  AMSSocketClient.h
//  AMS
//
//  Created by jianlu on 2018/10/25.
//  Copyright © 2018年 jianlu. All rights reserved.
//

#import "GCDAsyncSocket.h"

NS_ASSUME_NONNULL_BEGIN

#define AMSReconnectTime 10//最大重连次数
#define AMSSocketTimerTime 3//心跳包检测时间
#define AMSHeartBeatTime 7//心跳包最多次数
/**
 超时类型
 - AMSSocketOfflineOutTime: 连接超时
 - AMSSocketOfflineCutByUser: 用户主动切断
 */
typedef NS_ENUM(NSUInteger, AMSSocketOfflineType) {
    AMSSocketOfflineOutTime = 0,
    AMSSocketOfflineCutByUser,
};

@interface AMSSocketClient : GCDAsyncSocket

@property(nonatomic,assign)AMSSocketOfflineType offlineType;//socket状态
@property(nonatomic,assign)NSInteger reconnectCount;//socket重连次数限定
@property(nonatomic,assign)NSInteger heartBeatCount;//当前心跳次数

-(void)setTag:(NSString*)tag withHost:(NSString*)host withPort:(uint16_t)port;//设置socket属性
-(void)socketConnectHost;//连接socket
-(void)cutOffSocket;//断开socket连接
-(void)startTimer;//开启心跳计时器
-(void)resetHeartBeatTime;//重置心跳次数;
@end

NS_ASSUME_NONNULL_END
