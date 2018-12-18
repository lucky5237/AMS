//
//  Y_StockChartRightYView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/5/3.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_StockChartRightYView.h"
#import "UIColor+Y_StockChart.h"
#import "Masonry.h"


@interface Y_StockChartRightYView ()

@property(nonatomic,strong) UILabel *maxValueLabel; //1
@property(nonatomic,strong) UILabel *secondmaxValueLabel;//2
@property(nonatomic,strong) UILabel *thirdmaxValueLabel; //3

@property(nonatomic,strong) UILabel *middleValueLabel;//4

@property(nonatomic,strong) UILabel *sencondMinLabel;//6
@property(nonatomic,strong) UILabel *thirdMinLabel;//5
@property(nonatomic,strong) UILabel *minValueLabel;//7


@end


@implementation Y_StockChartRightYView

-(void)setMaxValue:(CGFloat)maxValue

{
    _maxValue = maxValue;
    if (self.chartType == VolumeType) {

        self.maxValueLabel.text = [NSString stringWithFormat:@"%ld",(long)maxValue];
    }else{
        if (self.type == Y_StockChartcenterViewTypeTimeLine) {
            self.maxValueLabel.text = [NSString stringWithFormat:@"%.2f%@",maxValue,self.isRisePer ?  @"%":@""];
            
        }else{
            self.maxValueLabel.text = [NSString stringWithFormat:@"%.2f",maxValue];
        }
    }
}

-(void)setMiddleValue:(CGFloat)middleValue
{
    _middleValue = middleValue;
    
    if (self.type == Y_StockChartcenterViewTypeTimeLine) {
        self.middleValueLabel.text = [NSString stringWithFormat:@"%.2f%@",middleValue,self.isRisePer ? @"%":@""];
        CGFloat unit  = (_maxValue - _minValue) / 6;
        self.secondmaxValueLabel.text = [NSString stringWithFormat:@"%.2f%@",self.maxValue - unit,self.isRisePer ?  @"%":@""];
        self.thirdmaxValueLabel.text = [NSString stringWithFormat:@"%.2f%@",self.maxValue - unit*2,self.isRisePer ? @"%":@""];
        self.thirdMinLabel.text = [NSString stringWithFormat:@"%.2f%@",self.maxValue - unit*4,self.isRisePer ?  @"%":@""];
        self.sencondMinLabel.text = [NSString stringWithFormat:@"%.2f%@",self.maxValue - unit*5,self.isRisePer ?  @"%":@""];
    }else{
        self.middleValueLabel.text = [NSString stringWithFormat:@"%.2f",middleValue];
    }
    self.middleValueLabel.hidden = (self.chartType == VolumeType || self.chartType == MACDType);
}

-(void)setMinValue:(CGFloat)minValue
{
    _minValue = minValue;
    if (self.type == Y_StockChartcenterViewTypeTimeLine) {
        self.minValueLabel.text = [NSString stringWithFormat:@"%.2f%@",minValue,self.isRisePer ?  @"%":@""];
    }else{
          self.minValueLabel.text = [NSString stringWithFormat:@"%.2f",minValue];
    }
    self.minValueLabel.hidden = self.chartType == VolumeType;
}

-(void)setMinLabelText:(NSString *)minLabelText
{
    _minLabelText = minLabelText;
    self.minValueLabel.text = minLabelText;
}

#pragma mark - get方法
#pragma mark maxPriceLabel的get方法
-(UILabel *)maxValueLabel
{
    if (!_maxValueLabel) {
        _maxValueLabel = [self private_createLabel];
        [self addSubview:_maxValueLabel];
        [_maxValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.width.equalTo(self);
            make.height.equalTo(@10);
        }];
    }
    return _maxValueLabel;
}

#pragma mark middlePriceLabel的get方法
-(UILabel *)middleValueLabel
{
    if (!_middleValueLabel) {
        _middleValueLabel = [self private_createLabel];
        [self addSubview:_middleValueLabel];
        [_middleValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).offset(0);
            make.right.equalTo(self);
            make.height.width.equalTo(self.maxValueLabel);
        }];
    }
    if (self.type == Y_StockChartcenterViewTypeTimeLine) {
        _middleValueLabel.textColor = kWhiteColor;
    }
    return _middleValueLabel;
}

#pragma mark minPriceLabel的get方法
-(UILabel *)minValueLabel
{
    if (!_minValueLabel) {
        _minValueLabel = [self private_createLabel];
        [self addSubview:_minValueLabel];
        [_minValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(0);
            make.right.equalTo(self);
            make.height.width.equalTo(self.maxValueLabel);
        }];
        if (self.type == Y_StockChartcenterViewTypeTimeLine) {
            _minValueLabel.textColor = kGreenTextColor;
        }
    }
    return _minValueLabel;
}

#pragma mark minPriceLabel的get方法
-(UILabel *)secondmaxValueLabel
{
    if (!_secondmaxValueLabel && self.type == Y_StockChartcenterViewTypeTimeLine) {
        _secondmaxValueLabel = [self private_createLabel];
        [self addSubview:_secondmaxValueLabel];
        [_secondmaxValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.maxValueLabel.mas_bottom).offset((Y_StockChartKLineMainViewMaxY - Y_StockChartKLineMainViewMinY)/6);
            make.right.equalTo(self);
            make.height.width.equalTo(self.maxValueLabel);
        }];
    }
    return _secondmaxValueLabel;
}

#pragma mark minPriceLabel的get方法
-(UILabel *)thirdmaxValueLabel
{
    if (!_thirdmaxValueLabel && self.type == Y_StockChartcenterViewTypeTimeLine) {
        _thirdmaxValueLabel = [self private_createLabel];
        [self addSubview:_thirdmaxValueLabel];
        [_thirdmaxValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.maxValueLabel.mas_bottom).offset((Y_StockChartKLineMainViewMaxY - Y_StockChartKLineMainViewMinY)/3);
            make.right.equalTo(self);
            make.height.width.equalTo(self.maxValueLabel);
        }];
    }
    return _thirdmaxValueLabel;
}

#pragma mark minPriceLabel的get方法
-(UILabel *)thirdMinLabel
{
    if (!_thirdMinLabel && self.type == Y_StockChartcenterViewTypeTimeLine) {
        _thirdMinLabel = [self private_createLabel];
        [self addSubview:_thirdMinLabel];
        [_thirdMinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.maxValueLabel.mas_bottom).offset((Y_StockChartKLineMainViewMaxY - Y_StockChartKLineMainViewMinY) * 2 /3);
            make.right.equalTo(self);
            make.height.width.equalTo(self.maxValueLabel);
        }];
        _thirdMinLabel.textColor = kGreenTextColor;
    }
    return _thirdMinLabel;
}

#pragma mark minPriceLabel的get方法
-(UILabel *)sencondMinLabel
{
    if (!_sencondMinLabel && self.type == Y_StockChartcenterViewTypeTimeLine) {
        _sencondMinLabel = [self private_createLabel];
        [self addSubview:_sencondMinLabel];
        [_sencondMinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.maxValueLabel.mas_bottom).offset((Y_StockChartKLineMainViewMaxY - Y_StockChartKLineMainViewMinY) * 5 /6);
            make.right.equalTo(self);
            make.height.width.equalTo(self.maxValueLabel);
        }];
        _sencondMinLabel.textColor = kGreenTextColor;
    }
    return _sencondMinLabel;
}

#pragma mark - 私有方法
#pragma mark 创建Label
- (UILabel *)private_createLabel
{
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:11];
    label.textColor = [UIColor zj_colorWithHexString:@"#C80E42" alpha:1];
    label.textAlignment = NSTextAlignmentLeft;
    label.adjustsFontSizeToFitWidth = YES;
    //    label.backgroundColor = kOrangeColor;
    [self addSubview:label];
    return label;
}
@end
