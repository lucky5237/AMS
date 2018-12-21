//
//  CustomStatusBarView.m
//  AMS
//
//  Created by jianlu on 2018/11/27.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "CustomStatusBarView.h"
@interface CustomStatusBarView ()
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property(nonatomic,assign) NSTimeInterval limitTime;
@property(nonatomic,assign) BOOL isShowing;
@property(nonatomic,assign) BOOL isAnimation;
@end
@implementation CustomStatusBarView
- (IBAction)closeBtnTapped:(UIButton *)sender {
    if (self.isShowing) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.frame = CGRectMake(0, -kNavBarHeight, KScreenWidth, kNavBarHeight);
                         } completion:^(BOOL finished) {
                             self.isShowing = false;
                         }];
    }
}
static CustomStatusBarView *__onetimeClass;
+(instancetype )sharedInstance
{
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        
        __onetimeClass = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CustomStatusBarView class]) owner:nil options:nil]lastObject];
    });
    return __onetimeClass;
}

-(void)showMessage:(NSString*)msg limitTime:(NSTimeInterval) time{
    if (self.isShowing) {
        return;
    }
    self.isShowing = YES;
    self.limitTime = time;
    self.messageLabel.text = msg;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.frame = CGRectMake(0, kStatusBarHeight, KScreenWidth, kNavBarHeight);
                     }completion:^(BOOL finished) {
                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.limitTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             if (self.isShowing) {
                                 [UIView animateWithDuration:0.2
                                                  animations:^{
                                                      
                                                      self.frame = CGRectMake(0, -kNavBarHeight, KScreenWidth, kNavBarHeight);
                                                  } completion:^(BOOL finished) {
                                                      self.isShowing = false;
                                                  }];
                             }
                         });
                     }];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
