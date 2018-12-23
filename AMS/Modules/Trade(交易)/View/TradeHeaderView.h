//
//  TradeHeaderView.h
//  AMS
//
//  Created by jianlu on 2018/11/16.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AMSLdatum;
@class User_Onrspqrytradingaccount;

NS_ASSUME_NONNULL_BEGIN

@interface TradeHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *equityLabel;
@property (weak, nonatomic) IBOutlet UILabel *canUseLabel;
@property (weak, nonatomic) IBOutlet UILabel *usePerLabel;
@property (weak, nonatomic) IBOutlet UILabel *theNewPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *theNewNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *salePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *saleNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyMoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *saleEmptyLabel;
@property (weak, nonatomic) IBOutlet UILabel *eveningUpLabel;
@property (weak, nonatomic) IBOutlet UIView *buyMoreView;

@property (weak, nonatomic) IBOutlet UIView *saleEmptyView;
@property (weak, nonatomic) IBOutlet UIView *eveningUpView;
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *priceTf;
@property (weak, nonatomic) IBOutlet UITextField *numTf;
@property (weak, nonatomic) IBOutlet UILabel *buyMoreDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *saleEmptyDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *eveningUpDescLabel;
@property(nonatomic,strong) UIButton *lockBtn;

-(void)configPriceData:(AMSLdatum*)data keyBoardType:(CustomKeyBoardBtnType)type;
-(void)configAccountData:(User_Onrspqrytradingaccount*)data;
@end

NS_ASSUME_NONNULL_END
