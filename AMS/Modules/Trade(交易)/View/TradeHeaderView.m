//
//  TradeHeaderView.m
//  AMS
//
//  Created by jianlu on 2018/11/16.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "TradeHeaderView.h"
#import "QryQuotationResponseModel.h"
@interface TradeHeaderView()

@end

@implementation TradeHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    //添加价格左侧label和右边间隔
    UILabel *priceLabel = [[UILabel alloc] init];
   
    priceLabel.textColor = kTableViewHeaderGrayTextColor;
    priceLabel.font = kFontSize(13);
    priceLabel.text = @"价格";
    priceLabel.textAlignment = NSTextAlignmentRight;
    priceLabel.frame =CGRectMake(0, 0, 34, 34);
    self.priceTf.leftView = priceLabel;
    self.priceTf.leftViewMode = UITextFieldViewModeAlways;
//    self.priceTf.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 34)];
//    self.priceTf.rightViewMode = UITextFieldViewModeAlways;
    
    //添加数目左侧label和右边间隔
    UILabel *numLabel = [[UILabel alloc] init];
    numLabel.frame = CGRectMake(0, 0, 34, 34);
    numLabel.textColor = kTableViewHeaderGrayTextColor;
    numLabel.textAlignment = NSTextAlignmentRight;
    numLabel.font = kFontSize(13);
    numLabel.text = @"手数";
    self.numTf.leftView = numLabel;
    self.numTf.leftViewMode = UITextFieldViewModeAlways;
//    self.numTf.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 34)];
//    self.numTf.rightViewMode = UITextFieldViewModeAlways;
    
    //配置搜索框
    UIButton *lockBtn = [[UIButton alloc] init];
    [lockBtn setImage:kImageName(@"unlock") forState:UIControlStateNormal];
    [lockBtn setImage:kImageName(@"lock") forState:UIControlStateSelected];
    lockBtn.frame = CGRectMake(0, 0, 29, 29);
    lockBtn.tag = 0;
//    lockBtn.layer.masksToBounds = YES;
//    lockBtn.layer.borderWidth = 1.f;
//    lockBtn.layer.borderColor = kBlackColor.CGColor;
    self.lockBtn = lockBtn;
    self.nameTf.rightView = lockBtn;
    self.nameTf.rightViewMode = UITextFieldViewModeAlways;
//    self.nameTf.delegate = self;
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn setImage:kImageName(@"搜索") forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(0, 0, 34, 34);
//    searchBtn.layer.borderColor = kBlackColor.CGColor;
    self.nameTf.leftView = searchBtn;
    self.nameTf.leftViewMode = UITextFieldViewModeAlways;

}
-(void)configPriceData:(AMSLdatum *)data{
    self.theNewPriceLabel.text = data.latestPrice;
    self.salePriceLabel.text = data.salePrice1;
    self.buyPriceLabel.text = data.buyPrice1;
    self.saleNumLabel.text = data.saleAmount1;
    self.buyNumLabel.text = data.buyAmount1;
    self.buymo
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
