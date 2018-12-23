//
//  AMSDBManager.h
//  AMS
//
//  Created by jianlu on 2018/12/18.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class InstrumentDBModel;
@interface AMSDBManager : NSObject
+(AMSDBManager*) shareInstance;
-(NSArray *)queryAllCollectInstuments;//查本地收藏的合约
-(NSArray *)queryAllInstuments:(NSString *)exchangeId;
//-(InstrumentDBModel *)queryInstumentById:(NSString*)instumentId;//查特定合约
//-(BOOL) addInstuments:(NSArray*)instumentArray;//添加合约
//-(BOOL) addInstumentById:(NSString*)instumentId;//通过合约id添加合约
//查本地所有合约
-(BOOL)saveAllInstuments:(NSArray*)array;
-(BOOL)collectInstumentById:(NSString*)instumentId;//收藏合约
-(BOOL)canCelCollectInstumentById:(NSString*)instumentId;//取消收藏
-(BOOL)hasInstrumentCollected:(NSString*)instumentId;//合约是否收藏
-(NSArray *)queryInstumentByKeyWord:(NSString*)keyWord;
-(BOOL)hasSaveData;
@end

NS_ASSUME_NONNULL_END
