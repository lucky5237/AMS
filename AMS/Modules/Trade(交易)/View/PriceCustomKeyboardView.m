//
//  PriceCustomKeyboardView.m
//  AMS
//
//  Created by jianlu on 2018/11/19.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "PriceCustomKeyboardView.h"

@implementation PriceCustomKeyboardView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = NO;
    
    for(UIView *view in self.subviews){
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *menuBtn = (UIButton *)view;
            [menuBtn setZj_btnOnTouchUp:^(UIButton * sender) {
                self.type = sender.tag;
                if (self.priceCustomKeyboardBtnTappedBlock) {
                    self.priceCustomKeyboardBtnTappedBlock(sender.tag);
                }
            }];
            
        }else if ([view isKindOfClass:[UIView class]] && view.tag == 100) {
            for(UIView *subView in view.subviews){
                UIButton *menuBtn = (UIButton *)subView;
                if ([menuBtn isKindOfClass:[UIButton class]]) {
                    [menuBtn setZj_btnOnTouchUp:^(UIButton * sender) {
                        if (self.priceCustomKeyboardBtnTappedBlock) {
                            self.priceCustomKeyboardBtnTappedBlock(sender.tag);
                        }
                    }];
//                    if (menuBtn.tag == PaiDui_Price) {
//                        [AMSUtil drawCorner:UIRectCornerTopLeft| UIRectCornerBottomLeft cornerRadii:CGSizeMake(5,5) view:menuBtn];
//                        [menuBtn layoutIfNeeded];
//                    }else if (menuBtn.tag == Super_Price){
//                        [AMSUtil drawCorner:UIRectCornerTopRight| UIRectCornerBottomRight cornerRadii:CGSizeMake(5,5) view:menuBtn];
//                        [menuBtn layoutIfNeeded];
//                    }
                }
            }
        }
    }
    
}

-(void)configTopHintMsg:(double)minChangePrice riseStopPrice:(double)riseStopPrice fallStopPrice:(double)fallStopPrice{
    self.topHintLabel.text = [NSString stringWithFormat:@"最小变动价为%.1f，涨停%.1f，跌停%.1f",minChangePrice,riseStopPrice,fallStopPrice];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (IBAction)HideKeyBoardBtnTapped:(UIButton *)sender {
//}
//
//- (IBAction)paiduiPriceBtnTapped:(UIButton *)sender {
//}
//
//- (IBAction)duishouPriceBtnTapped:(UIButton *)sender {
//}
//
//- (IBAction)shiPriceBtnTapped:(UIButton *)sender {
//}
//
//- (IBAction)newPriceBtnTapped:(UIButton *)sender {
//}
//
//- (IBAction)superPriceBtnTapped:(UIButton *)sender {
//}
//
//- (IBAction)oneBtnTapped:(UIButton *)sender {
//}
//
//- (IBAction)twoPriceBtnTapped:(UIButton *)sender {
//}
@end
