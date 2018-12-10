//
//  SettingHeaderView.m
//  AMS
//
//  Created by jianlu on 2018/11/14.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "SettingHeaderView.h"
#import <UIImageView+WebCache.h>

@implementation SettingHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = kCellBackGroundColor;
    self.divider.backgroundColor = kTableViewBackGroundColor;
    [self.avatarImageView zj_cornerRadiusRoundingRect];
}

-(void)configUserInfo:(NSDictionary *)userInfo{
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:userInfo[@"image"]]];
    self.nameLabel.text = userInfo[@"name"];
}

@end
