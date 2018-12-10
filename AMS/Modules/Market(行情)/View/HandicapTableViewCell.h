//
//  HandicapTableViewCell.h
//  AMS
//
//  Created by jianlu on 2018/11/20.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DealDetailModel;
@interface HandicapTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *xianShouLabel;
@property (weak, nonatomic) IBOutlet UILabel *zengCangLabel;
@property (weak, nonatomic) IBOutlet UILabel *kaiPingLabel;

-(void)configData:(DealDetailModel*)model isHeader:(BOOL) isHeader;
@end

NS_ASSUME_NONNULL_END
