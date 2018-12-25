//
//  AMSSocketManager.h
//  SocketDemo
//
//  Created by jianlu on 2018/10/23.
//  Copyright © 2018年 jianlu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AMSSocketClient;

NS_ASSUME_NONNULL_BEGIN

@interface AMSSocketManager : NSObject

+(AMSSocketManager*)shareInstance;
-(AMSSocketClient *)addSocketClient:(NSString*)tag withHost:(NSString*)host withPort:(NSUInteger)port;//添加tcp连接
-(void)cutOffSocketClient:(NSString*)tag;//断开tcp连接
-(AMSSocketClient*)socketClient:(NSString*)tag;//获取tcp连接
-(void)writeData:(NSData*)data toSocket:(NSString*)tag;//给socket写数据
-(void)writeData:(NSData*)data toSocket:(NSString*)name tag:(NSInteger)tag;
-(void)showSocketDictInfo;//打印当前socket字典的信息
-(void)cutOffAllClient;//断开所有tcp连接
@end

NS_ASSUME_NONNULL_END
