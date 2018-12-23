//
//  LrReportContainerView.h
//  AMS
//
//  Created by jianlu on 2018/12/12.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMReportView.h"
#import "LMRStyle.h"
#import "LMRGrid.h"
#import "NSIndexPath+LMReport.h"
NS_ASSUME_NONNULL_BEGIN
@protocol LrReportContainerViewDelegate <NSObject>

-(void)reportView:(LMReportView *)reportView didTapLabel:(LMRLabel *)label;
-(void)reportView:(LMReportView *)reportView didLongPressLabel:(LMRLabel *)label;
@end
typedef void(^LMReportViewDidScrollBlock)(UIScrollView *scrollView,BOOL isMainScrollView);
@interface LrReportContainerView : UIView
@property(nonatomic,copy)NSArray *titleItemArray;
//@property(nonatomic,copy)NSArray *dataArray;
@property(nonatomic,assign) NSUInteger currentSelectIndex;
@property(nonatomic,copy)LMReportViewDidScrollBlock lMReportViewDidScrollBlock;
@property(nonatomic,weak) id<LrReportContainerViewDelegate> delegate;
@property(nonatomic,strong,readonly) LMReportView *currentReportView;
@property(nonatomic,copy) NSMutableArray *dataArray;
-(void)dataArray:(NSArray*)dataArray forIndex:(NSInteger)index;
-(void)reloadData;
-(void)reloadData:(NSInteger) index;
@end

NS_ASSUME_NONNULL_END
