//
//  HandicapCollectionViewCell.m
//  AMS
//
//  Created by jianlu on 2018/11/20.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "HandicapCollectionViewCell.h"

@implementation HandicapCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)configData:(NSDictionary *)dict{
    
    self.nameLabel.text = dict[@"name"];
    self.priceLabel.text = dict[@"price"];
    NSNumber *isRise  = dict[@"isRise"];
    self.priceLabel.textColor =  isRise.boolValue ? kTabBarSelectTextColor: kGreenTextColor;
}

@end
