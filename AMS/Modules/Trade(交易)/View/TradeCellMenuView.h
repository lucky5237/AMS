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
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *centerButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
- (IBAction)pingcangMenuBtnTapped:(UIButton *)sender;
- (IBAction)fanshouMenuBtnTapped:(UIButton *)sender;
- (IBAction)suocangMenuBtnTapped:(UIButton *)sender;
@property(nonatomic,copy) TradeCellMenuClickBlock tradeCellMenuClickBlock;
@property(nonatomic,assign) BOOL isShowing;//是否正在展示
-(void)configType:(NSInteger)type;//0-持仓表样式 1-挂单表样式
@end

NS_ASSUME_NONNULL_END
