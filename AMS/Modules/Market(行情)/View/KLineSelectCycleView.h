//
//  KLineSelectCycleView.h
//  AMS
//
//  Created by jianlu on 2018/11/27.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^DidSelectCycleViewItemBlock)(NSDictionary *dict);
@interface KLineSelectCycleView : UIView
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,assign) NSInteger currentSelectIndex;
@property(nonatomic,copy) DidSelectCycleViewItemBlock didSelectCycleViewItemBlock;

//@property (weak, nonatomic) IBOutlet UIView *bgView;
-(void)configData:(NSArray*)datas;
-(void)show;
-(void)hide;
@end

NS_ASSUME_NONNULL_END
