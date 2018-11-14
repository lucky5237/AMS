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
}

-(void)layout{
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kRealWidth(5));
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(kRealWidth(MARKET_CELL_NAME_WIDTH));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_right);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(kRealWidth(MARKET_CELL_PRICE_WIDTH));
    }];
    
    [self.fallRiseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel.mas_right);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(kRealWidth(MARKET_CELL_FALLRISE_WIDTH));
    }];
    
    [self.volumeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.fallRiseLabel.mas_right);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(kRealWidth(MARKET_CELL_VOLUME_WIDTH));
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
        self.backgroundColor = kOrangeColor;
    }else{
        self.nameLabel.textColor = kYellowColor;
        self.priceLabel.textColor = self.model.isRise ? kRedColor : kGreenColor;
        if (self.model.fallRise.integerValue == 0) {
            self.fallRiseLabel.textColor = kWhiteColor;
        }else if (self.model.fallRise.integerValue > 0){
            self.fallRiseLabel.textColor = kRedColor;
        }else{
            self.fallRiseLabel.textColor = kGreenColor;
        }
        self.volumeLabel.textColor = kWhiteColor;
        self.backgroundColor = kBlackColor;
    }
}

#pragma mark 懒加载

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = kYellowColor;
        _nameLabel.font = kFontSize(16);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.backgroundColor = kClearColor;
    }
    return _nameLabel;
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = kRedColor;
        _priceLabel.font = kFontSize(14);
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.backgroundColor = kClearColor;
    }
    return _priceLabel;
}

-(UILabel *)fallRiseLabel{
    if (!_fallRiseLabel) {
        _fallRiseLabel = [[UILabel alloc] init];
        _fallRiseLabel.textColor = kGreenColor;
        _fallRiseLabel.font = kFontSize(14);
        _fallRiseLabel.textAlignment = NSTextAlignmentRight;
        _fallRiseLabel.backgroundColor = kClearColor;
    }
    return _fallRiseLabel;
}

-(UILabel *)volumeLabel{
    if (!_volumeLabel) {
        _volumeLabel = [[UILabel alloc] init];
        _volumeLabel.textColor = kWhiteColor;
        _volumeLabel.font = kFontSize(14);
        _volumeLabel.textAlignment = NSTextAlignmentRight;
        _volumeLabel.backgroundColor = kClearColor;
    }
    return _volumeLabel;
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
