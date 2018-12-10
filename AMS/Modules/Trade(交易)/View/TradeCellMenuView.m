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
@end
