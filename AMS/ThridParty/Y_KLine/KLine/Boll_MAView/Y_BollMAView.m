//
//  Y_VolumeMAView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/5/3.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_BollMAView.h"
#import "UIColor+Y_StockChart.h"
#import "Y_KLineModel.h"
@interface Y_BollMAView ()
//@property (strong, nonatomic) UILabel *VolumeMA7Label;
//
//@property (strong, nonatomic) UILabel *VolumeMA30Label;
//
//@property (strong, nonatomic) UILabel *volumeDescLabel;
@property (strong, nonatomic) UILabel *descLabel;
@property (strong, nonatomic) UILabel *middleLabel;
@property (strong, nonatomic) UILabel *topLabel;
@property (strong, nonatomic) UILabel *bottomLabel;
@property (strong, nonatomic) UIView *dividerView;
@end
@implementation Y_BollMAView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _descLabel = [self private_createLabel];
        _middleLabel = [self private_createLabel];
        _topLabel = [self private_createLabel];
        _bottomLabel = [self private_createLabel];
        _dividerView = [[UIView alloc] init];
        _dividerView.backgroundColor = [UIColor zj_colorWithHexString:@"#252535" alpha:1];
        
        _descLabel.textColor = [UIColor ma20Color];
        _middleLabel.textColor = [UIColor whiteColor];
        _topLabel.textColor = [UIColor ma20Color];
        _bottomLabel.textColor = [UIColor ma40Color];
        
        _descLabel.text = @"BOLL(26,26,2)";
        
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
        }];
        
        
        [_middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.descLabel.mas_right).offset(5);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
        }];
        
        [_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.middleLabel.mas_right).offset(5);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
//            make.width.mas_equalTo(KScreenWidth/4);
        }];
        
        [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.topLabel.mas_right).offset(5);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
//            make.width.mas_equalTo(KScreenWidth/4);
        }];
        
        [self addSubview:_dividerView];
        
        [_dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.right.mas_equalTo(-5);
            make.height.mas_equalTo(1);
            make.bottom.mas_equalTo(self);
        }];
        
    }
    return self;
}

+(instancetype)view
{
    Y_BollMAView *MAView = [[Y_BollMAView alloc]init];
    
    return MAView;
}
-(void)maProfileWithModel:(Y_KLineModel *)model
{
    _middleLabel.text = [NSString stringWithFormat:@"M：%.2f",model.BOLL_MB.floatValue];
    _topLabel.text = [NSString stringWithFormat:@"T：%.2f",model.BOLL_UP.floatValue];
    _bottomLabel.text = [NSString stringWithFormat:@"B：%.2f",model.BOLL_DN.floatValue];
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
