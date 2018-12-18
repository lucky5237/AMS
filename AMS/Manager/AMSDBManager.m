//
//  AMSDBManager.m
//  AMS
//
//  Created by jianlu on 2018/12/18.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "AMSDBManager.h"
#import "CollectQuatationDBModel.h"
#import <JQFMDB.h>
@implementation AMSDBManager
+(AMSDBManager*) shareInstance{
    static AMSDBManager *manager = nil;
    static dispatch_once_t onceSocketToken;
    dispatch_once(&onceSocketToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

-(BOOL)addQuotations:(CollectQuatationDBModel *)quotations{
    return [[JQFMDB shareDatabase] jq_insertTable:NSStringFromClass([CollectQuatationDBModel class]) dicOrModel:quotations];
}

-(NSArray *)queryAllQuotations {
    return [[JQFMDB shareDatabase] jq_lookupTable:NSStringFromClass([CollectQuatationDBModel class]) dicOrModel:[CollectQuatationDBModel class] whereFormat:nil];
}
-(BOOL)deleteQuotation:(NSString*)queryId{
   return [[JQFMDB shareDatabase] jq_deleteTable:NSStringFromClass([CollectQuatationDBModel class]) whereFormat:@"WHERE instrumentID = %@",queryId];
}

-(BOOL)isQuotationCollected:(NSString*)queryId{
     return [[JQFMDB shareDatabase] jq_lookupTable:NSStringFromClass([CollectQuatationDBModel class]) dicOrModel:[CollectQuatationDBModel class] whereFormat:@"WHERE instrumentID = %@",queryId].count > 0;
}

@end
