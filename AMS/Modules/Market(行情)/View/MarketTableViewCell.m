//
//  MarketTableViewCell.m
//  AMS
//
//  Created by jianlu on 2018/11/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "MarketTableViewCell.h"
#import "InstumentModel.h"

@interface MarketTableViewCell()
@property(nonatomic,strong) UILabel *nameLabel;//名字
@property(nonatomic,strong) UILabel *priceLabel;//价格
@property(nonatomic,strong) UILabel *fallRiseLabel;//跌涨
@property(nonatomic,strong) UILabel *volumeLabel;//成交量
@property(nonatomic,strong) UIView *separator;//分割线
@property(nonatomic,strong) InstumentModel* model;
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

-(void)configModel:(InstumentModel *)model fallRiseType:(FallRiseBtnType)fallRiseType volumeType:(VolumeBtnType)volumeType{
    self.model = model;
    self.nameLabel.text = model.instrument.InstrumentName;
    self.priceLabel.text =  model.quotation == nil ? @"-" :[NSString stringWithFormat:@"%.2f",model.quotation.latestPrice.floatValue];
    if (fallRiseType == FallRise) {
        self.fallRiseLabel.text = model.quotation == nil ? @"-": [NSString stringWithFormat:@"%.2f",model.quotation.priceChange.floatValue];
        if ([model.quotation.priceChange hasPrefix:@"-"]) {
            self.fallRiseLabel.textColor = kGreenTextColor;
        }else if ([model.quotation.priceChange floatValue] == 0.00f){
            self.fallRiseLabel.textColor = kWhiteColor;
        }else{
            self.fallRiseLabel.textColor = kRedTextColor;
        }
    }else if (fallRiseType == FallRisePer){
         self.fallRiseLabel.text = model.quotation == nil ? @"-":[NSString stringWithFormat:@"%.2f",model.quotation.priceChangeRate.floatValue];
        if ([model.quotation.priceChangeRate hasPrefix:@"-"]) {
            self.fallRiseLabel.textColor = kGreenTextColor;
        }else if ([model.quotation.priceChangeRate floatValue] == 0.00f){
            self.fallRiseLabel.textColor = kWhiteColor;
        }else{
            self.fallRiseLabel.textColor = kRedTextColor;
        }
    }
    self.priceLabel.textColor = self.fallRiseLabel.textColor;
    if (volumeType == Volume) {
        self.volumeLabel.text = model.quotation == nil ? @"-": [NSString stringWithFormat:@"%ld",model.quotation.dealAmount];
    }else if (volumeType == OpenInterest){
        self.volumeLabel.text = model.quotation == nil ? @"-": [NSString stringWithFormat:@"%@",model.quotation.openInterest];
    }else if (volumeType == DailyIncrement){
        self.volumeLabel.text = model.quotation == nil ? @"-": [NSString stringWithFormat:@"%ld",model.quotation.dealAmount];
    }
}

-(void)configSelection:(BOOL)isSelect fallRiseType:(FallRiseBtnType)fallRiseType volumeType:(VolumeBtnType)volumeType{
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
        if (fallRiseType == FallRise) {
//            self.fallRiseLabel.text = [NSString stringWithFormat:@"%@",self.model.priceChange];
            if ([self.model.quotation.priceChange hasPrefix:@"-"]) {
                self.fallRiseLabel.textColor = kGreenTextColor;
            }else if ([self.model.quotation.priceChange floatValue] == 0.00f){
                self.fallRiseLabel.textColor = kWhiteColor;
            }else{
                self.fallRiseLabel.textColor = kRedTextColor;
            }
        }else if (fallRiseType == FallRisePer){
//            self.fallRiseLabel.text = [NSString stringWithFormat:@"%@",self.model.priceChangeRate];
            if ([self.model.quotation.priceChangeRate hasPrefix:@"-"]) {
                self.fallRiseLabel.textColor = kGreenTextColor;
            }else if ([self.model.quotation.priceChangeRate floatValue] == 0.00f){
                self.fallRiseLabel.textColor = kWhiteColor;
            }else{
                self.fallRiseLabel.textColor = kRedTextColor;
            }
        }
        self.priceLabel.textColor = self.fallRiseLabel.textColor;
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
