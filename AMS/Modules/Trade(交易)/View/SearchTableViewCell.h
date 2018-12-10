//
//  SearchTableViewCell.h
//  AMS
//
//  Created by jianlu on 2018/11/21.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

@end

NS_ASSUME_NONNULL_END
