//
//  KLineLongTapParamView.h
//  AMS
//
//  Created by jianlu on 2018/11/27.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Y_KLineModel;
NS_ASSUME_NONNULL_BEGIN

@interface KLineLongTapParamView : UIView
@property(nonatomic,assign) BOOL isShowing;
+(instancetype)kLineLongTapParamView;
-(void)maProfileWithModel:(Y_KLineModel*)model;
@property(nonatomic,assign) ParamShowType type;
@end

NS_ASSUME_NONNULL_END
