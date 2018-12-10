//
//  DealDetailModel.h
//  AMS
//
//  Created by jianlu on 2018/11/21.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DealDetailModel : NSObject
@property(nonatomic,copy) NSString *time;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,strong) NSNumber *xianShouNum;
@property(nonatomic,strong) NSNumber *zengCangNum;
@property(nonatomic,copy) NSString *kaiPing;
@property(nonatomic,assign) BOOL isXianShouRise;
@property(nonatomic,assign) BOOL isPriceRise;
@end

NS_ASSUME_NONNULL_END
