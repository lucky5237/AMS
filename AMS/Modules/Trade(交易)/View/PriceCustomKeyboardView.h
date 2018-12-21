//
//  PriceCustomKeyboardView.h
//  AMS
//
//  Created by jianlu on 2018/11/19.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^PriceCustomKeyboardBtnTappedBlock)(CustomKeyBoardBtnType type);

@interface PriceCustomKeyboardView : UIView
@property (weak, nonatomic) IBOutlet UILabel *topHintLabel;
//- (IBAction)HideKeyBoardBtnTapped:(UIButton *)sender;
//- (IBAction)paiduiPriceBtnTapped:(UIButton *)sender;
//- (IBAction)duishouPriceBtnTapped:(UIButton *)sender;
//- (IBAction)shiPriceBtnTapped:(UIButton *)sender;
//- (IBAction)newPriceBtnTapped:(UIButton *)sender;
//- (IBAction)superPriceBtnTapped:(UIButton *)sender;
//- (IBAction)oneBtnTapped:(UIButton *)sender;
//- (IBAction)twoPriceBtnTapped:(UIButton *)sender;
//@property (weak, nonatomic) IBOutlet UILabel *topHintLabel;
@property(nonatomic,copy)PriceCustomKeyboardBtnTappedBlock priceCustomKeyboardBtnTappedBlock;
@property(nonatomic,assign) BOOL isUsingSystemPrice;
@property(nonatomic,assign)CustomKeyBoardBtnType type;
-(void)configTopHintMsg:(double)minChangePrice riseStopPrice:(double) riseStopPrice fallStopPrice:(double)fallStopPrice;

@end

NS_ASSUME_NONNULL_END
