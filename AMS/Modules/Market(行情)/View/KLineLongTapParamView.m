//
//  KLineLongTapParamView.m
//  AMS
//
//  Created by jianlu on 2018/11/27.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "KLineLongTapParamView.h"
#import "Y_KLineModel.h"

@interface KLineLongTapParamView ()
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *openPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *highPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *closePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *closePriceChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *closePriceChangePerLabel;
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;
@property (weak, nonatomic) IBOutlet UILabel *storageNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *storageChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *settlementPriceLabel;

@end


@implementation KLineLongTapParamView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)kLineLongTapParamView{
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
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.Date.doubleValue];
//                NSDateFormatter *formatter = [NSDateFormatter new];
//                formatter.dateFormat = @"HH:mm";
//    NSString *dateStr = [formatter stringFromDate:date];
    self.currentPriceLabel.text = [NSString stringWithFormat:@"%.2f",model.yValue];
    self.timeLabel.text = model.Date;
    self.openPriceLabel.text = [NSString stringWithFormat:@"%.2f",model.Open.floatValue];
    self.lowPriceLabel.text = [NSString stringWithFormat:@"%.2f",model.Low.floatValue];
    self.highPriceLabel.text = [NSString stringWithFormat:@"%.2f",model.High.floatValue];
    self.closePriceLabel.text = [NSString stringWithFormat:@"%.2f",model.Close.floatValue];
    self.volumeLabel.text = [NSString stringWithFormat:@"%@",model.Volume];
}

@end
