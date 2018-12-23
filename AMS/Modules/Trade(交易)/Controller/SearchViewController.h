//
//  SearchViewController.h
//  AMS
//
//  Created by jianlu on 2018/11/21.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "BaseViewController.h"
@class InstrumentDBModel;
NS_ASSUME_NONNULL_BEGIN
typedef void(^DidSelectItemBlock)(InstrumentDBModel * dict);
@interface SearchViewController : BaseViewController
@property(nonatomic,copy) DidSelectItemBlock didSelectItemBlock;
@end

NS_ASSUME_NONNULL_END
