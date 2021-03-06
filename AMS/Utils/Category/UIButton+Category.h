//
//  UIButton+Category.h
//  AMS
//
//  Created by jianlu on 2018/10/30.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonActionCallBack)(UIButton *button);
@interface UIButton (Category)

-(void)addCallBackAction:(ButtonActionCallBack)action
        forControlEvents:(UIControlEvents)controlEvents;

-(void)addCallBackAction:(ButtonActionCallBack)action;

@end

@interface UIButton (EnlargeTouchArea)

/**
 *  扩大 UIButton 的點擊範圍
 *  控制上下左右的延長範圍
 *
 *  @param top    top description
 *  @param right  right description
 *  @param bottom bottom description
 *  @param left   left description
 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

@end
