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
@class User_Requserlogin;
@class User_Reqqryinstrument;
@interface SocketRequestManager : NSObject
+(SocketRequestManager*) shareInstance;
+(NSDictionary *)responseDictWithBestMessage:(best_protocol::IBestMessage *)bestMessage;

-(void)doLogin:(User_Requserlogin *)model;
-(void)loginOut;
-(void)qryInstrument:(User_Reqqryinstrument *)model;
@end

NS_ASSUME_NONNULL_END
