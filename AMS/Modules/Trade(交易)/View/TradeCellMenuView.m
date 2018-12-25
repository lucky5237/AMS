//
//  TradeCellMenuView.m
//  AMS
//
//  Created by jianlu on 2018/11/19.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "TradeCellMenuView.h"

@implementation TradeCellMenuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    [super awakeFromNib];
    self.backButton.userInteractionEnabled = YES;
    [[self.backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (self.tradeCellMenuClickBlock) {
            self.tradeCellMenuClickBlock(x.tag);
        }
    }];
}

- (IBAction)pingcangMenuBtnTapped:(UIButton *)sender {
    if (self.tradeCellMenuClickBlock) {
        self.tradeCellMenuClickBlock(sender.tag);
    }
}

- (IBAction)fanshouMenuBtnTapped:(UIButton *)sender {
    if (self.tradeCellMenuClickBlock) {
        self.tradeCellMenuClickBlock(sender.tag);
    }
}

- (IBAction)suocangMenuBtnTapped:(UIButton *)sender {
    if (self.tradeCellMenuClickBlock) {
        self.tradeCellMenuClickBlock(sender.tag);
    }
}


-(void)configType:(NSInteger)type{
    //持仓表
    if (type == 0) {
        self.leftButton.hidden = NO;
        self.centerButton.hidden = NO;
        self.rightButton.hidden = NO;
        self.backButton.hidden = YES;
    }else if(type == 1){
        self.leftButton.hidden = YES;
        self.centerButton.hidden = YES;
        self.rightButton.hidden = YES;
        self.backButton.hidden = NO;
        [self bringSubviewToFront:self.backButton];
    }
   
}
@end
