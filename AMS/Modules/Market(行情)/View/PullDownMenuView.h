//
//  PullDownMenuView.h
//  AMS
//
//  Created by jianlu on 2018/11/15.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^MenuCellTapBlock)(NSDictionary *dict);
@interface PullDownMenuView : UIView
@property(nonatomic,assign) NSInteger *currentSelectId;
@property(nonatomic,assign) BOOL isShow;
@property(nonatomic,copy) MenuCellTapBlock menuCellTapBlock;
-(void) ConfigData:(NSArray *) array firstShow:(BOOL) show;
-(instancetype) initWithFrame:(CGRect)frame dataArray:(NSArray*) array;
+(CGFloat)heightOfMenuView:(NSArray*)array;
@end

NS_ASSUME_NONNULL_END
