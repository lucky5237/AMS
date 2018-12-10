//
//  Y_VolumeMAView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/5/3.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_VolumeMAView.h"
#import "Masonry.h"
#import "UIColor+Y_StockChart.h"
#import "Y_KLineModel.h"
@interface Y_VolumeMAView ()
//@property (strong, nonatomic) UILabel *VolumeMA7Label;
//
//@property (strong, nonatomic) UILabel *VolumeMA30Label;
//
//@property (strong, nonatomic) UILabel *volumeDescLabel;
@property (strong, nonatomic) UILabel *volumeLabel;
@property (strong, nonatomic) UILabel *cjlLabel;
@property (strong, nonatomic) UILabel *dpidLabel;
@end
@implementation Y_VolumeMAView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _volumeLabel = [self private_createLabel];
        _cjlLabel = [self private_createLabel];
        _dpidLabel = [self private_createLabel];
        
        _volumeLabel.textColor = [UIColor whiteColor];
        _cjlLabel.textColor = [UIColor ma20Color];
        _dpidLabel.textColor = [UIColor whiteColor];
        
        _cjlLabel.text = @"CJL";
        
        [_cjlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(72);
        }];
        
        
        [_volumeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.cjlLabel.mas_right);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo((KScreenWidth - 72)/2);
        }];
        
        [_dpidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.volumeLabel.mas_right);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo((KScreenWidth - 72)/2);
        }];
        
    }
    return self;
}

+(instancetype)view
{
    Y_VolumeMAView *MAView = [[Y_VolumeMAView alloc]init];
    
    return MAView;
}
-(void)maProfileWithModel:(Y_KLineModel *)model
{
    _volumeLabel.text = [NSString stringWithFormat:@"VOL：%.2f（47：53）",model.Volume];
    _dpidLabel.text = @"DPID：135102";
//    _volumeDescLabel.text = [NSString stringWithFormat:@" 成交量(7,30):%.4f ",model.Volume];
//
//    _VolumeMA7Label.text = [NSString stringWithFormat:@"  MA7：%.8f ",model.Volume_MA7.floatValue];
//    _VolumeMA30Label.text = [NSString stringWithFormat:@"  MA30：%.8f",model.Volume_MA30.floatValue];
}
- (UILabel *)private_createLabel
{
    UILabel *label = [UILabel new];
    label.font =kFontSize(11);
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    return label;
}

@end
