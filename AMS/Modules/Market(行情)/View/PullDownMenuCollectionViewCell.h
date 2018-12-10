//
//  PullDownMenuCollectionViewCell.h
//  AMS
//
//  Created by jianlu on 2018/11/15.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PullDownMenuCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
//@property (copy, nonatomic) MenuBtnTapBlock menuBtnTapBlock;
- (void)setSelect:(BOOL)select;

@end

NS_ASSUME_NONNULL_END
