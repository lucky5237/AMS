//
//  AMSDBManager.m
//  AMS
//
//  Created by jianlu on 2018/12/18.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "AMSDBManager.h"
#import "InstrumentDBModel.h"
#import <JQFMDB.h>
@interface AMSDBManager ()
@property(nonatomic,strong)JQFMDB *db;
@end
@implementation AMSDBManager
+(AMSDBManager*) shareInstance{
    static AMSDBManager *manager = nil;
    static dispatch_once_t onceSocketToken;
    dispatch_once(&onceSocketToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
-(JQFMDB *)db{
    return [JQFMDB shareDatabase];
}
//查本地所有合约
-(NSArray *)queryAllCollectInstuments{
    NSArray *resultArr = [self.db jq_lookupTable:@"InstrumentDBModel" dicOrModel:[InstrumentDBModel class] whereFormat:@"where hasCollect = 1"];
    return resultArr;
}

-(NSArray *)queryAllInstuments:(NSString*)exchangeId{
    if (exchangeId.length == 0) {
        NSArray *resultArr = [self.db jq_lookupTable:@"InstrumentDBModel" dicOrModel:[InstrumentDBModel class] whereFormat:nil];
        return resultArr;
    }else{
        NSArray *resultArr = [self.db jq_lookupTable:@"InstrumentDBModel" dicOrModel:[InstrumentDBModel class] whereFormat:@"where exchangeID = '%@'",exchangeId];
        return resultArr;
    }
   
}

//保存本地合约
-(BOOL)saveAllInstuments:(NSArray*)array{
   return [self.db jq_insertTable:@"InstrumentDBModel" dicOrModelArray:array];
}

//是否有数据
-(BOOL)hasSaveData{
    NSInteger dataNum = [self.db jq_tableItemCount:@"InstrumentDBModel"];
    return dataNum > 0;
}

//查特定合约
-(NSArray *)queryInstumentByKeyWord:(NSString*)keyWord{
    NSArray *resultArr = [self.db jq_lookupTable:@"InstrumentDBModel" dicOrModel:[InstrumentDBModel class] whereFormat:@"where instrumentID LIKE '%@%%'or  instrumentName LIKE '%@%%'",keyWord,keyWord];
    return resultArr;
}
////添加合约
//-(BOOL) addInstuments:(NSArray*)instumentArray{
//     [[JQFMDB shareDatabase] jqins
//}
////通过合约id添加合约
//-(BOOL) addInstument:(InstrumentDBModel *)instument{
//    //存在更新，否则添加
//    if ([self queryInstumentById:instument.instrumentID]) {
//        [[JQFMDB shareDatabase] jq_updateTable:NSStringFromClass([InstrumentDBModel class]) dicOrModel:instument whereFormat:@"WHERE instrumentID = '%@' ",instument.instrumentID];
//    }else{
//        [[JQFMDB shareDatabase] jq_insertTable:NSStringFromClass([InstrumentDBModel class]) dicOrModel:instument];
//    }
//}
//收藏合约
-(BOOL) collectInstumentById:(NSString*)instumentId{
    
    return [self.db jq_updateTable:@"InstrumentDBModel" dicOrModel:@{@"hasCollect" : @1} whereFormat:@"where instrumentID = '%@'",instumentId];

}
//取消收藏
-(BOOL)canCelCollectInstumentById:(NSString*)instumentId{
    return [self.db jq_updateTable:@"InstrumentDBModel" dicOrModel:@{@"hasCollect" : @0} whereFormat:@"where instrumentID = '%@'",instumentId];
}
//合约是否收藏
-(BOOL)hasInstrumentCollected:(NSString*)instumentId{
    NSArray *resultArr = [self.db jq_lookupTable:@"InstrumentDBModel" dicOrModel:[InstrumentDBModel class] whereFormat:@"where instrumentID = '%@' and hasCollect = 1",instumentId];
    return resultArr.count > 0;
}
//
//-(BOOL)addQuotations:(CollectQuatationDBModel *)quotations{
//    if ([self isQuotationCollected:quotations.instrumentID]) {
//        NSLog(@"%@数据库已存在，插入失败",quotations.instrumentID);
//        return false;
//    }
//    return [[JQFMDB shareDatabase] jq_insertTable:NSStringFromClass([CollectQuatationDBModel class]) dicOrModel:quotations];
//}
//
//-(NSArray *)queryAllQuotations {
//    return [[JQFMDB shareDatabase] jq_lookupTable:NSStringFromClass([CollectQuatationDBModel class]) dicOrModel:[CollectQuatationDBModel class] whereFormat:nil];
//}
//-(BOOL)deleteQuotation:(NSString*)queryId{
//   return [[JQFMDB shareDatabase] jq_deleteTable:NSStringFromClass([CollectQuatationDBModel class]) whereFormat:@"WHERE instrumentID = %@",queryId];
//}
//
//-(BOOL)isQuotationCollected:(NSString*)queryId{
//     return [[JQFMDB shareDatabase] jq_lookupTable:NSStringFromClass([CollectQuatationDBModel class]) dicOrModel:[CollectQuatationDBModel class] whereFormat:@"WHERE instrumentID = '%@' ",queryId].count > 0;
//}

@end
