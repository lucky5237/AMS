//
//  CustomStatusBarView.h
//  AMS
//
//  Created by jianlu on 2018/11/27.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomStatusBarView : UIView

+(instancetype)sharedInstance;
-(void)showMessage:(NSString*)msg limitTime:(NSTimeInterval) time;
@end

NS_ASSUME_NONNULL_END
