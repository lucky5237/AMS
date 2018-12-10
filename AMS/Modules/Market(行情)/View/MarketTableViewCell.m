//
//  MarketTableViewCell.m
//  AMS
//
//  Created by jianlu on 2018/11/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "MarketTableViewCell.h"

@interface MarketTableViewCell()
@property(nonatomic,strong) UILabel *nameLabel;//名字
@property(nonatomic,strong) UILabel *priceLabel;//价格
@property(nonatomic,strong) UILabel *fallRiseLabel;//跌涨
@property(nonatomic,strong) UILabel *volumeLabel;//成交量
@property(nonatomic,strong) UIView *separator;//分割线
@property(nonatomic,strong) MarketModel* model;
@end

//static const float width = (KScreenWidth - 10) / 4;

@implementation MarketTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        [self initView];
        [self layout];
    }
    return self;
}

-(void)initView{
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.fallRiseLabel];
    [self.contentView addSubview:self.volumeLabel];
    [self.contentView addSubview:self.separator];
}

-(void)layout{
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(MARKET_CELL_NAME_WIDTH);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_right);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(MARKET_CELL_PRICE_WIDTH);
    }];
    
    [self.fallRiseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel.mas_right);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(MARKET_CELL_FALLRISE_WIDTH);
    }];
    
    [self.volumeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.fallRiseLabel.mas_right);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(MARKET_CELL_VOLUME_WIDTH);
    }];
    
    [self.separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KScreenWidth);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView);
    }];
}

-(void)configModel:(MarketModel *)model fallRiseType:(FallRiseBtnType)fallRiseType volumeType:(VolumeBtnType)volumeType{
    self.model = model;
    self.nameLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"%@",model.price];
//    self.priceLabel.textColor = model.isRise ? kRedColor : kGreenColor;
    
    if (fallRiseType == FallRise) {
        self.fallRiseLabel.text = [NSString stringWithFormat:@"%@",model.fallRise];
    }else if (fallRiseType == FallRisePer){
         self.fallRiseLabel.text = [NSString stringWithFormat:@"%@",model.fallRisePer];
    }
//    if (model.fallRise.integerValue == 0) {
//        self.fallRiseLabel.textColor = kWhiteColor;
//    }else if (model.fallRise.integerValue > 0){
//        self.fallRiseLabel.textColor = kRedColor;
//    }else{
//        self.fallRiseLabel.textColor = kGreenColor;
//    }
    if (volumeType == Volume) {
        self.volumeLabel.text = [NSString stringWithFormat:@"%@",model.volume];
    }else if (volumeType == OpenInterest){
        self.volumeLabel.text = [NSString stringWithFormat:@"%@",model.openInterest];
    }else if (volumeType == DailyIncrement){
        self.volumeLabel.text = [NSString stringWithFormat:@"%@",model.dailyIncrement];
    }
}

-(void)configSelection:(BOOL)isSelect{
    if (isSelect) {
        self.nameLabel.textColor = kWhiteColor;
        self.priceLabel.textColor = kWhiteColor;
        self.fallRiseLabel.textColor = kWhiteColor;
        self.volumeLabel.textColor = kWhiteColor;
        self.separator.backgroundColor = kMenuRedBackGroundColor;
        self.backgroundColor = kTableViewBackGroundColor;
    }else{
        self.separator.backgroundColor = kTableViewBackGroundColor;
        self.nameLabel.textColor = kYellowTextColor;
        self.priceLabel.textColor = self.model.isRise ? kRedTextColor : kGreenTextColor;
        if (self.model.fallRise.integerValue == 0) {
            self.fallRiseLabel.textColor = kNormalTextColor;
        }else if (self.model.fallRise.integerValue > 0){
            self.fallRiseLabel.textColor = kRedTextColor;
        }else{
            self.fallRiseLabel.textColor = kGreenTextColor;
        }
        self.volumeLabel.textColor = kNormalTextColor;
        self.backgroundColor = kCellBackGroundColor;
    }
}

#pragma mark 懒加载

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = kYellowTextColor;
        _nameLabel.font = kFontSize(15);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.backgroundColor = kClearColor;
    }
    return _nameLabel;
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = kRedTextColor;
        _priceLabel.font = kFontSize(15);
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.backgroundColor = kClearColor;
    }
    return _priceLabel;
}

-(UILabel *)fallRiseLabel{
    if (!_fallRiseLabel) {
        _fallRiseLabel = [[UILabel alloc] init];
        _fallRiseLabel.textColor = kGreenTextColor;
        _fallRiseLabel.font = kFontSize(15);
        _fallRiseLabel.textAlignment = NSTextAlignmentCenter;
        _fallRiseLabel.backgroundColor = kClearColor;
    }
    return _fallRiseLabel;
}

-(UILabel *)volumeLabel{
    if (!_volumeLabel) {
        _volumeLabel = [[UILabel alloc] init];
        _volumeLabel.textColor = kNormalTextColor;
        _volumeLabel.font = kFontSize(15);
        _volumeLabel.textAlignment = NSTextAlignmentCenter;
        _volumeLabel.backgroundColor = kClearColor;
    }
    return _volumeLabel;
}

-(UIView *)separator{
    if(!_separator){
        _separator = [[UIView alloc] init];
        _separator.backgroundColor = kTableViewBackGroundColor;
    }
    return _separator;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
