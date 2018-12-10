//
//  TradeCellMenuView.h
//  AMS
//
//  Created by jianlu on 2018/11/19.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^TradeCellMenuClickBlock)(TradeCellMenuBtnType type);
@interface TradeCellMenuView : UIView
- (IBAction)pingcangMenuBtnTapped:(UIButton *)sender;
- (IBAction)fanshouMenuBtnTapped:(UIButton *)sender;
- (IBAction)suocangMenuBtnTapped:(UIButton *)sender;
@property(nonatomic,copy) TradeCellMenuClickBlock tradeCellMenuClickBlock;
@property(nonatomic,assign) BOOL isShowing;//是否正在展示

@end

NS_ASSUME_NONNULL_END
