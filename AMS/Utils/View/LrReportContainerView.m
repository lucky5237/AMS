//
//  LrReportContainerView.m
//  AMS
//
//  Created by jianlu on 2018/12/12.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "LrReportContainerView.h"
#import "User_Onrspqryinvestorposition.h"
#import "User_Onrspqrytrade.h"
#import "User_Onrtnorder.h"

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
    reportView.style.trimWidthSpace = false;
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
         grid.textColor = kWhiteColor;
         grid.backgroundColor = kCellBackGroundColor;
        //持仓表
        if(reportView.tag - 1 == ChiChangType){
              User_Onrspqryinvestorposition *item = (User_Onrspqryinvestorposition *)self.dataArray[reportView.tag - 1][indexPath.row-1];
            //合约名称
            if (indexPath.col == 0) {
                grid.text = item.InstrumentID;
            }
            if (indexPath.col == 1) {
                if (item.PosiDirection!= nil) {
                    if (item.PosiDirection.intValue == 1) {
                        grid.text = @"净";
                    }else if (item.PosiDirection.intValue == 2){
                         grid.text = @"多";
                        grid.textColor = kRedTextColor;
                    }else if (item.PosiDirection.intValue == 3){
                        grid.text = @"空";
                        grid.textColor = kGreenTextColor;
                    }
                }
            }
            //总仓
            if (indexPath.col == 2) {
                grid.text = [NSString stringWithFormat:@"%@",item.Position ? : @0];
            }
            //可用
            if (indexPath.col == 3) {
              grid.text = [NSString stringWithFormat:@"%d",item.Position.intValue - item.LongFrozen.intValue - item.ShortFrozen.intValue > 0 ?: 0];
            }
            //开仓均价
            if (indexPath.col == 4) {
//                grid.text = [NSString stringWithFormat:@"%ld",item.Position.intValue - item.LongFrozen.intValue - item.ShortFrozen.intValue > 0 ?: 0];
                grid.text = @"开仓均价";
            }
            //逐笔浮盈
            if (indexPath.col == 5) {
                grid.text = @"逐笔浮盈";
                //                grid.text = [NSString stringWithFormat:@"%ld",item.Position.intValue - item.LongFrozen.intValue - item.ShortFrozen.intValue > 0 ?: 0];
            }
            
        }else if (reportView.tag - 1 == GuaDanType){
            User_Onrtnorder *item = (User_Onrtnorder *)self.dataArray[reportView.tag - 1][indexPath.row-1];
            //合约名称
            if (indexPath.col == 0) {
                grid.text = item.InstrumentID;
            }
            //开平
            if (indexPath.col == 1) {
                if([item.CombOffsetFlag isEqualToString:@"0"]){
                    grid.text = @"开";
                }else if([item.CombOffsetFlag isEqualToString:@"1"]){
                    grid.text = @"平";
                }
                
            }
            //委托价
            if (indexPath.col == 2) {
                grid.text = [NSString stringWithFormat:@"%@",item.LimitPrice];
            }
            //委托量
            if (indexPath.col == 3) {
                grid.text = [NSString stringWithFormat:@"%@",item.VolumeTotalOriginal];
            }
            //挂单量
            if (indexPath.col == 4) {
                grid.text = [NSString stringWithFormat:@"%@",item.VolumeTotal];
            }
        }else if (reportView.tag - 1 == WeiTuoType){
            User_Onrtnorder *item = (User_Onrtnorder *)self.dataArray[reportView.tag - 1][indexPath.row-1];
            //合约名称
            if (indexPath.col == 0) {
                grid.text = item.InstrumentID;
            }
            
            //状态
            if (indexPath.col == 2) {
                if([item.CombOffsetFlag isEqualToString:@"0"]){
                    grid.text = @"开";
                }else if([item.CombOffsetFlag isEqualToString:@"1"]){
                    grid.text = @"平";
                }
                
            }
            //委托价
            if (indexPath.col == 3) {
                grid.text = [NSString stringWithFormat:@"%@",item.LimitPrice];
            }
            //委托量
            if (indexPath.col == 4) {
                grid.text = [NSString stringWithFormat:@"%@",item.VolumeTotalOriginal];
            }
            //已成交
            if (indexPath.col == 5) {
                grid.text = [NSString stringWithFormat:@"%@",item.VolumeTotal];
            }
            //已撤单
            if (indexPath.col == 6) {
                grid.text = [NSString stringWithFormat:@"%@",item.VolumeTotal];
            }
            //委托时间
            if (indexPath.col == 7) {
                grid.text = [NSString stringWithFormat:@"%@",item.InsertTime];
            }
        }
        
        else if (reportView.tag - 1 == ChengjiaoType){
             User_Onrspqrytrade *item = (User_Onrspqrytrade *)self.dataArray[reportView.tag - 1][indexPath.row-1];
            //合约名称
            if (indexPath.col == 0) {
                grid.text = item.InstrumentID;
            }
            //开平
            if (indexPath.col == 1) {
                if([item.OffsetFlag isEqualToString:@"0"]){
                    grid.text = @"开";
                }else if([item.OffsetFlag isEqualToString:@"1"]){
                     grid.text = @"平";
                }
              
            }
            //成交价
            if (indexPath.col == 2) {
                grid.text = [NSString stringWithFormat:@"%@",item.Price];
            }
            //成交量
            if (indexPath.col == 3) {
                grid.text = [NSString stringWithFormat:@"%@",item.Volume];
            }
            //成交时间
            if (indexPath.col == 4) {
                grid.text = [NSString stringWithFormat:@"%@",item.TradeDate];
            }
        }
        
        else{
            grid.text = [NSString stringWithFormat:@"%@",self.dataArray[reportView.tag - 1][indexPath.row-1] [indexPath.col]];
            grid.font = kFontSize(15);
        }
      
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
    self.currentReportView.frame = CGRectMake(KScreenWidth * self.currentSelectIndex, 0, self.scrollView.zj_width, self.scrollView.zj_height);
}

-(void)reloadData:(NSInteger) index{
    LMReportView *reportView =  (LMReportView *)[self.scrollView viewWithTag:index + 1];
    [reportView reloadData];
    reportView.frame = CGRectMake(KScreenWidth * index, 0, self.scrollView.zj_width, self.scrollView.zj_height);
}

@end
