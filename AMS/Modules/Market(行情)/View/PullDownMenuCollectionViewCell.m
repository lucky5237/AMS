//
//  PullDownMenuCollectionViewCell.m
//  AMS
//
//  Created by jianlu on 2018/11/15.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "PullDownMenuCollectionViewCell.h"

@implementation PullDownMenuCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.menuBtn.userInteractionEnabled = false;
}

-(void)setSelect:(BOOL)select{
    
    if (select) {
        self.menuBtn.layer.masksToBounds = YES;
        self.menuBtn.layer.borderWidth = 1.f;
        self.menuBtn.layer.borderColor =kMenuRedBackGroundColor.CGColor;
        [self.menuBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    }else{
        self.menuBtn.layer.borderWidth = 0.f;
        [self.menuBtn setTitleColor:kTabBarNormalTextColor forState:UIControlStateNormal];
    }
}
@end
