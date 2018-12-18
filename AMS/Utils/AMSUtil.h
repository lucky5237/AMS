//
//  AMSUtil.h
//  AMS
//  通用t工具类
//  Created by jianlu on 2018/10/25.
//  Copyright © 2018年 jianlu. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "default_message.h"
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

@interface AMSUtil : NSObject

+(UIViewController *)getCurrentVC;
+(UIViewController *)getCurrentUIVC;
+(UIImage *)imageWithColor:(UIColor *)color;
+(BOOL)isUserLogin;
+(BOOL)isVaildMoney:(NSString *) money;//验证交易界面金额的输入
+(void)drawCorner:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii view:(UIView*) view;
+(CGRect)rectOfNSString:(NSString *)string attribute:(NSDictionary *)attribute;
+(const char *)getPropertyType:(objc_property_t)property;
@end

NS_ASSUME_NONNULL_END
