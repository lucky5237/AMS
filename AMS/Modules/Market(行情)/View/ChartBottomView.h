//
//  ChartBottomView.h
//  AMS
//
//  Created by jianlu on 2018/11/22.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChartBottomView : UIView
@property (weak, nonatomic) IBOutlet UILabel *sellPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *storageNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *storageChangeNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentChangeLabel;

@end

NS_ASSUME_NONNULL_END
