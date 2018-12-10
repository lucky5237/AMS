//
//  MarketTableViewHeaderView.m
//  AMS
//
//  Created by jianlu on 2018/11/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "MarketTableViewHeaderView.h"

@implementation MarketTableViewHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
//    self.currentFallRiseBtnType = FallRise;
//    self.currentVolumeBtnType = Volume;
    self.fallRiseBtn.tag = FallRise;
    self.volumeBtn.tag = Volume;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (IBAction)fallRiseBtnTapped:(UIButton *)sender {
    
    self.fallRiseBtn.tag = (self.fallRiseBtn.tag + 1) % 2;
    if (self.fallRiseBtn.tag == FallRise) {
        [self.fallRiseBtn setTitle:@"涨跌" forState:UIControlStateNormal];
    }else if (self.fallRiseBtn.tag == FallRisePer){
        [self.fallRiseBtn setTitle:@"涨幅" forState:UIControlStateNormal];
    }
    if (self.fallRiseBtnBlock) {
        self.fallRiseBtnBlock(self.fallRiseBtn.tag);
    }
    
}
- (IBAction)volumeBtnTapped:(UIButton *)sender {
    self.volumeBtn.tag = (self.volumeBtn.tag + 1) % 3;
    if (self.volumeBtn.tag == Volume) {
        [self.volumeBtn setTitle:@"成交量" forState:UIControlStateNormal];
    }else if (self.volumeBtn.tag == OpenInterest){
        [self.volumeBtn setTitle:@"持仓量" forState:UIControlStateNormal];
    }else if (self.volumeBtn.tag == DailyIncrement){
        [self.volumeBtn setTitle:@"日增仓" forState:UIControlStateNormal];
    }
    if (self.volumeBtnBlock) {
        self.volumeBtnBlock(self.volumeBtn.tag);
    }
}
@end
