//
//  LrReportContainerView.m
//  AMS
//
//  Created by jianlu on 2018/12/12.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "LrReportContainerView.h"

@interface LrReportContainerView ()<UIScrollViewDelegate,LMReportViewDelegate,LMReportViewDatasource>
@property(nonatomic,strong) UIScrollView *scrollView;


@end
@implementation LrReportContainerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = self.bounds;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = false;
        _scrollView.showsVerticalScrollIndicator = false;
        _scrollView.scrollEnabled = NO;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:self.titleItemArray.count];
        for (int i =0; i<self.titleItemArray.count; i++) {
            [_dataArray addObject:@[].mutableCopy];
        }
    }
    return _dataArray;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.titleItemArray.count == 0) {
        NSLog(@"titleItemArray 不能为空");
        return;
    }
    
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width * self.titleItemArray.count, self.bounds.size.height);
    self.scrollView.contentOffset = CGPointMake(0,0);
    //循环创建ReportView
//    [self.titleItemArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        LMReportView *reportView = [self private_creatreportView:idx];
//        reportView.frame = CGRectMake(idx * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
//        [self.scrollView addSubview:reportView];
//    }];
//    LMReportView *reportView = [self private_creatreportView:ChiChangType];
//    reportView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
//    [self.scrollView addSubview:reportView];
//    self.currentSelectIndex = 0;
}

-(LMReportView *)private_creatreportView:(NSUInteger)index{
   
    LMReportView * reportView = [[LMReportView alloc] initWithFrame: CGRectMake(index * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
    reportView.datasource = self;
    reportView.delegate = self;
    reportView.style.spacing = REPORT_VIEW_BOARDER_WIDTH;
    reportView.style.borderColor = [UIColor grayColor];
    reportView.backgroundColor = kCellBackGroundColor;
    reportView.style.borderInsets = UIEdgeInsetsMake(REPORT_VIEW_BOARDER_WIDTH, 0, REPORT_VIEW_BOARDER_WIDTH, 0);
    reportView.tag = index + 1;
    reportView.lMReportViewDidScrollBlock = ^(UIScrollView *scrollView, BOOL isMainScrollView) {
        if (isMainScrollView) {
            LMReportView *reportView = [self currentReportView];
            reportView.contentOffSet = scrollView.contentOffset.y;
        }
        if (self.lMReportViewDidScrollBlock) {
            self.lMReportViewDidScrollBlock(scrollView, isMainScrollView);
        }
    };
    return reportView;
}

-(void)setCurrentSelectIndex:(NSUInteger)currentSelectIndex{
    if (currentSelectIndex > self.titleItemArray.count - 1) {
        NSLog(@"选中的index超出范围-- %lu",(unsigned long)currentSelectIndex);
        return;
    }
    self.scrollView.contentOffset = CGPointMake(currentSelectIndex * self.bounds.size.width, 0);
    _currentSelectIndex = currentSelectIndex;
    LMReportView *reportView = (LMReportView *)[self.scrollView viewWithTag:currentSelectIndex+1];
    if (reportView == nil) {
        reportView = [self private_creatreportView:currentSelectIndex];
//        reportView.frame = ;
        [self.scrollView addSubview:reportView];
//        [reportView reloadData];
    }
}
-(LMReportView *)currentReportView{
    return (LMReportView *)[self.scrollView viewWithTag:self.currentSelectIndex + 1];
}

-(CGFloat)reportView:(LMReportView *)reportView widthOfCol:(NSInteger)col{
    NSArray *subArray = self.titleItemArray[reportView.tag - 1];
    CGFloat unitWidth = self.bounds.size.width - (subArray.count - 1) * REPORT_VIEW_BOARDER_WIDTH;
    if (reportView.tag - 1 == ChiChangType) {
        if (col == 0 || col == 4 || col == 5) {
            return 2*unitWidth / 9;
        }else{
            return unitWidth / 9;
        }
    }
    
    if (reportView.tag - 1 == GuaDanType) {
        if (col == 0) {
            return 3*unitWidth/ 11;
        }else{
            return 2*unitWidth / 11;
        }
    }
    
    if (reportView.tag - 1 == WeiTuoType) {
        NSArray *widths = @[@70,@50,@50,@60,@60,@60,@60,@100];
        NSNumber *width = widths[col];
        return width.floatValue;
    }
    if (reportView.tag - 1 == ChengjiaoType) {
        if (col == 0) {
            return 4*unitWidth/ 13;
        }else if(col == 4){
            return 3*unitWidth / 13;
        }else{
            return 2*unitWidth / 13;
        }
    }
    return 75;
}

- (NSInteger)numberOfRowsInReportView:(LMReportView *)reportView {
//    NSAssert(reportView.tag > self.dataArray.count + 1, @"超出最大数据范围");
	    NSArray *array = self.dataArray[reportView.tag - 1];
//    NSLog(@"一共有%ld行",array.count + 1);
    return array.count + 1;
}

- (NSInteger)numberOfColsInReportView:(LMReportView *)reportView {
//    NSAssert(reportView.tag > self.titleItemArray.count + 1, @"超出最大数据范围");
    NSArray *currentHeaderArray = self.titleItemArray[reportView.tag - 1];
    return currentHeaderArray.count;
}

-(void)dataArray:(NSArray *)dataArray forIndex:(NSInteger)index{
    if (index < 0 || index > self.titleItemArray.count - 1) {
        return ;
    }
    self.dataArray[index] = dataArray;
//    [self reloadData];
}

- (LMRGrid *)reportView:(LMReportView *)reportView gridAtIndexPath:(NSIndexPath *)indexPath {
    LMRGrid *grid = [[LMRGrid alloc] init];
    if (indexPath.row == 0) {
        grid.backgroundColor = kTableViewBackGroundColor;
        grid.textColor = kNormalTextColor;
        grid.text = self.titleItemArray[reportView.tag - 1][indexPath.col];
        grid.font = kFontSize(13);
    }else{
        grid.backgroundColor = kCellBackGroundColor;
        grid.textColor = kWhiteColor;
        grid.text = [NSString stringWithFormat:@"%@",self.dataArray[reportView.tag - 1][indexPath.row-1] [indexPath.col]];
        grid.font = kFontSize(15);
    }
    return grid;
}

-(CGFloat)reportView:(LMReportView *)reportView heightOfRow:(NSInteger)row{
    if (row == 0) {
        return 38;
    }
    return 44;
}

-(void)reportView:(LMReportView *)reportView didTapLabel:(LMRLabel *)label{
    if ([self.delegate respondsToSelector:@selector(reportView:didTapLabel:)]) {
        [self.delegate reportView:reportView didTapLabel:label];
    }
}

-(void)reportView:(LMReportView *)reportView didLongPressLabel:(LMRLabel *)label{
    if ([self.delegate respondsToSelector:@selector(reportView:didLongPressLabel:)]) {
        [self.delegate reportView:reportView didLongPressLabel:label];
    }
}

-(void)reloadData{
//    LMReportView *reportView = (LMReportView *)[self.scrollView viewWithTag:self.currentSelectIndex];
    [self.currentReportView reloadData];
}

@end
