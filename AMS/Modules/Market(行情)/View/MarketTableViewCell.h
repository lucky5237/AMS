//
//  MarketTableViewCell.h
//  AMS
//
//  Created by jianlu on 2018/11/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarketModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MarketTableViewCell : UITableViewCell
-(void)configModel:(MarketModel*) model fallRiseType:(FallRiseBtnType) fallRiseType volumeType:(VolumeBtnType) volumeType;
-(void)configSelection:(BOOL)isSelect;
@end

NS_ASSUME_NONNULL_END
