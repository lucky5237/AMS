//
//  CustomPopView.m
//  AMS
//
//  Created by jianlu on 2018/11/23.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "CustomPopView.h"
@interface CustomPopView()
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
- (IBAction)confirmBtnTapped:(UIButton *)sender;
@property(nonatomic,copy) NSString *message;
@end

@implementation CustomPopView

+(instancetype)customPopView{
    CustomPopView *customPopView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CustomPopView class]) owner:nil options:nil]lastObject];
    return customPopView;
}
-(void)awakeFromNib{
    [super awakeFromNib];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)confirmBtnTapped:(UIButton *)sender {
    if (self.confirmButtonClickBlock) {
        self.confirmButtonClickBlock();
    }
    [self hidePopView];
}

-(void)showPopView:(NSString *)message completion:(nonnull ConfirmButtonClickBlock)confirmButtonClickBlock{
    self.message = message;
    self.messageLabel.text = message;
    [self removeFromSuperview];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.frame =CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    self.confirmButtonClickBlock = confirmButtonClickBlock;
}
-(void)showPopView:(NSString *)message{
    [self showPopView:message completion:nil];
}
-(void)hidePopView{
    [self removeFromSuperview];
}
@end
