//
//  CustomPopView.h
//  AMS
//
//  Created by jianlu on 2018/11/23.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ConfirmButtonClickBlock)(void);
@interface CustomPopView : UIView
@property(nonatomic,copy) ConfirmButtonClickBlock confirmButtonClickBlock;
+(instancetype)customPopView;
-(void)showPopView:(NSString *)message completion:(ConfirmButtonClickBlock)confirmButtonClickBlock;
-(void)showPopView:(NSString *)message;

-(void)hidePopView;
@end

NS_ASSUME_NONNULL_END
