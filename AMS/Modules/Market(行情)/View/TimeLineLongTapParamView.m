//
//  KLineLongTapParamView.m
//  AMS
//
//  Created by jianlu on 2018/11/27.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "TimeLineLongTapParamView.h"
#import "Y_KLineModel.h"

@interface TimeLineLongTapParamView ()
@property (weak, nonatomic) IBOutlet UILabel *yValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *aveargePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *riseChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *riseChangePerLabel;
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;
@property (weak, nonatomic) IBOutlet UILabel *storageNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *storageChangeLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *volumeChangeLabel;
@end


@implementation TimeLineLongTapParamView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)timeLineLongTapParamView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1.f;
    self.layer.borderColor = [UIColor zj_colorWithHexString:@"#7F8197" alpha:1].CGColor;
    self.type = NoneType;
}
-(void)maProfileWithModel:(Y_KLineModel *)model{
//    self.currentPriceLabel.text
//    if ([model.Date containsString:@":"]) {
//
//        self.timeLabel.text = model.Date;
//
//    }else{
//        NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.Date.doubleValue];
//        NSDateFormatter *formatter = [NSDateFormatter new];
//        formatter.dateFormat = @"HH:mm";
//        NSString *dateStr = [formatter stringFromDate:date];
//        self.timeLabel.text = dateStr;
//    }
    self.timeLabel.text = model.Date;
    self.yValueLabel.text = [NSString stringWithFormat:@"%.2f",model.yValue];
    
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f",model.Close.floatValue];
    self.aveargePriceLabel.text = [NSString stringWithFormat:@"%.2f",[model.average floatValue]];
    self.riseChangeLabel.text = model.risePer;
    self.riseChangePerLabel.text = model.risePer;
    self.volumeLabel.text = [NSString stringWithFormat:@"%@",model.Volume];
    self.volumeChangeLabel.text = [NSString stringWithFormat:@"%@",model.Volume];
    self.storageNumLabel.text = [NSString stringWithFormat:@"%.2f",model.storage.floatValue];
    self.storageChangeLabel.text = [NSString stringWithFormat:@"%.2f",model.storage.floatValue];
}

@end
