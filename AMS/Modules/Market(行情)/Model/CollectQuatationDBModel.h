//
//  CollectQuatationDBModel.h
//  AMS
//
//  Created by jianlu on 2018/12/18.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectQuatationDBModel : NSObject
@property (nonatomic, assign)NSInteger pkid;
@property (nonatomic, copy)NSString *instrumentID;
@property (nonatomic, copy)NSString *instrumentName;
@end

NS_ASSUME_NONNULL_END
