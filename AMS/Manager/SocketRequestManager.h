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
@class User_Reqorderinsert;
@class User_Reqqryinvestorposition;
@class User_Reqqrytradingaccount;
@class User_Reqqrytrade;
@interface SocketRequestManager : NSObject
+(SocketRequestManager*) shareInstance;
+(NSDictionary *)responseDictWithBestMessage:(best_protocol::IBestMessage *)bestMessage;

-(void)doLogin:(User_Requserlogin *)model;//登录
-(void)loginOut;//登出
-(void)qryInstrument:(User_Reqqryinstrument *)model;//查询合约
-(void)reqorderinsert:(User_Reqorderinsert *)model;//下单
-(void)reqqryinvestorposition:(User_Reqqryinvestorposition *)model;//查询资金
-(void)reqqrytrade:(User_Reqqrytrade *)model;//查询成交
-(void)reqqrytradingaccount:(User_Reqqrytradingaccount*)model;//查询资金
@end

NS_ASSUME_NONNULL_END
