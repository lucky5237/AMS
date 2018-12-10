//
//  Y_AccessoryMAView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/5/4.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_AccessoryMAView.h"
#import "Masonry.h"
#import "UIColor+Y_StockChart.h"
#import "Y_KLineModel.h"

@interface Y_AccessoryMAView()

@property (strong, nonatomic) UILabel *accessoryDescLabel;

@property (strong, nonatomic) UILabel *DIFLabel;

@property (strong, nonatomic) UILabel *DEALabel;

//@property (strong, nonatomic) UILabel *MACDLabel;
@property (strong, nonatomic) UILabel *STICKLabel;
@end
@implementation Y_AccessoryMAView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _DIFLabel = [self private_createLabel];
        _DEALabel = [self private_createLabel];
//        _MACDLabel = [self private_createLabel];
        _STICKLabel = [self private_createLabel];
        _accessoryDescLabel = [self private_createLabel];
    
         _accessoryDescLabel.textColor = [UIColor ma20Color];
        _DIFLabel.textColor = [UIColor whiteColor];
        _DEALabel.textColor = [UIColor ma20Color];
        _STICKLabel.textColor = [UIColor ma40Color];
        
        _DIFLabel.textAlignment = NSTextAlignmentCenter;
        _DEALabel.textAlignment = NSTextAlignmentCenter;
        _STICKLabel.textAlignment = NSTextAlignmentCenter;
    
        CGFloat labelWidth =(KScreenWidth - 90)/3;
        [_accessoryDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(5);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        
        [_DIFLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.accessoryDescLabel.mas_right);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.width.mas_equalTo(labelWidth);
            
        }];
        
        [_DEALabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.DIFLabel.mas_right);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
             make.width.mas_equalTo(labelWidth);
        }];
        
        [_STICKLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.DEALabel.mas_right);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.width.mas_equalTo(labelWidth);
        }];
    }
    return self;
}

+(instancetype)view
{
    Y_AccessoryMAView *MAView = [[Y_AccessoryMAView alloc]init];
    
    return MAView;
}
-(void)maProfileWithModel:(Y_KLineModel *)model
{
    if(self.targetLineStatus != Y_StockChartTargetLineStatusAccessoryClose)
    {
        _accessoryDescLabel.text = @"MACD(12,26,9)";
        _DIFLabel.text = [NSString stringWithFormat:@"DIFF：%.2f ",model.DIF.floatValue];
        _DEALabel.text = [NSString stringWithFormat:@"DEA：%.2f",model.DEA.floatValue];
        _STICKLabel.text = [NSString stringWithFormat:@"STICK：%.2f",model.DEA.floatValue];
        
    } else {
        _accessoryDescLabel.text = @" KDJ(9,3,3)";
        _DIFLabel.text = [NSString stringWithFormat:@"  K：%.8f ",model.KDJ_K.floatValue];
        _DEALabel.text = [NSString stringWithFormat:@"  D：%.8f",model.KDJ_D.floatValue];
//        _MACDLabel.text = [NSString stringWithFormat:@"  J：%.8f",model.KDJ_J.floatValue];
    }


}
- (UILabel *)private_createLabel
{
    UILabel *label = [UILabel new];
    label.font = kFontSize(11);
    label.textColor = [UIColor assistTextColor];
    [self addSubview:label];
    return label;
}

@end
