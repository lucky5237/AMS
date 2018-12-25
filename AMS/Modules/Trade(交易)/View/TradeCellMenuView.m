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
        self.leftButton.hidden = false;
//        self.centerButton.hidden = false;
        [self.centerButton setTitle:@"快捷反手" forState:UIControlStateNormal];
        self.rightButton.hidden = false;
         self.centerButton.tag = 1;
    }else if(type == 1){
        self.leftButton.hidden = YES;
//        self.centerButton.hidden = false;
        [self.centerButton setTitle:@"撤单" forState:UIControlStateNormal];
        self.rightButton.hidden = YES;
        self.centerButton.tag = 999;
    }
   
}
@end
