//
//  HandicapTableViewCell.m
//  AMS
//
//  Created by jianlu on 2018/11/20.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "HandicapTableViewCell.h"
#import "DealDetailModel.h"
@implementation HandicapTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)configData:(DealDetailModel *)model isHeader:(BOOL)isHeader{
    if (isHeader) {
        self.timeLabel.text = @"时间";
        self.priceLabel.text = @"价位";
        self.xianShouLabel.text = @"现手";
        self.zengCangLabel.text = @"增仓";
        self.kaiPingLabel.text = @"开平";
//        self.timeLabel.font = kFontSize(13);
//        self.priceLabel.font = kFontSize(13);
//        self.xianShouLabel.font = kFontSize(13);
//        self.zengCangLabel.font = kFontSize(13);
//        self.kaiPingLabel.font = kFontSize(13);
        self.timeLabel.textColor = kTableViewHeaderGrayTextColor;
        self.priceLabel.textColor = kTableViewHeaderGrayTextColor;
        self.xianShouLabel.textColor = kTableViewHeaderGrayTextColor;
        self.zengCangLabel.textColor = kTableViewHeaderGrayTextColor;
        self.kaiPingLabel.textColor = kTableViewHeaderGrayTextColor;
    }else{
        self.timeLabel.text = model.time;
        self.priceLabel.text = model.price;
        self.xianShouLabel.text = model.xianShouNum.stringValue;
        self.zengCangLabel.text = model.zengCangNum.stringValue;
        self.kaiPingLabel.text = model.kaiPing;
//        self.timeLabel.font = kFontSize(14);
//        self.priceLabel.font = kFontSize(14);
//        self.xianShouLabel.font = kFontSize(14);
//        self.zengCangLabel.font = kFontSize(14);
//        self.kaiPingLabel.font = kFontSize(14);
        self.timeLabel.textColor = [UIColor whiteColor];
       
        self.zengCangLabel.textColor = [UIColor whiteColor];
        self.kaiPingLabel.textColor = [UIColor whiteColor];
        
        self.priceLabel.textColor = model.isPriceRise ? kRedTextColor : kGreenTextColor;
        self.xianShouLabel.textColor = model.isXianShouRise ? kRedTextColor :kGreenTextColor;
    }
}
@end
