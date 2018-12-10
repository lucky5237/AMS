//
//  SettingHeaderView.h
//  AMS
//
//  Created by jianlu on 2018/11/14.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *levelBtn;
@property (weak, nonatomic) IBOutlet UIView *divider;

-(void)configUserInfo:(NSDictionary*) userInfo;

@end

NS_ASSUME_NONNULL_END
