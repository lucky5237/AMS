//
//  AMSDBManager.h
//  AMS
//
//  Created by jianlu on 2018/12/18.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class CollectQuatationDBModel;
@interface AMSDBManager : NSObject
+(AMSDBManager*) shareInstance;
-(NSArray *)queryAllQuotations;
-(BOOL) addQuotations:(CollectQuatationDBModel *)quotations;
-(BOOL) deleteQuotation:(NSString*)queryId;
-(BOOL) isQuotationCollected:(NSString*)queryId;
@end

NS_ASSUME_NONNULL_END
