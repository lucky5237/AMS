//
//  MarketTableViewHeaderView.h
//  AMS
//
//  Created by jianlu on 2018/11/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^FallRiseBtnBlock)(NSInteger tag);
typedef void(^VolumeBtnBlock)(NSInteger tag);
@interface MarketTableViewHeaderView : UIView
@property (nonatomic,copy) FallRiseBtnBlock fallRiseBtnBlock;//第三个按钮点击block
@property (nonatomic,copy) VolumeBtnBlock volumeBtnBlock;//第四个按钮类型点击block
@property (weak, nonatomic) IBOutlet UIButton *fallRiseBtn;
- (IBAction)fallRiseBtnTapped:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *volumeBtn;
- (IBAction)volumeBtnTapped:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
