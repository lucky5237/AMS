//
//  BaseTableViewController.m
//  AMS
//
//  Created by jianlu on 2018/11/1.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "BaseTableViewController.h"
#import <UIScrollView+EmptyDataSet.h>
#define ORIGIN_PAGE_SIZE 10
#define ORIGIN_PAGE_NUM 1

@interface BaseTableViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.needFooter = YES;//默认需要上拉加载
    self.pageSize = ORIGIN_PAGE_SIZE;
    self.pageNum = ORIGIN_PAGE_NUM;
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView zj_tableViewWithSuperview:self.view delegate:self style:UITableViewStylePlain constraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.right.bottom.mas_equalTo(self.view);
        }];
        _tableView.backgroundColor = kTableViewBackGroundColor;
//        _tableView.separatorColor = kTableViewBackGroundColor;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        _tableView.tableFooterView = [[UIView alloc] init];
        kWeakSelf(self);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            kStrongSelf(self);
            [self fetchData:YES];
        }];
        
        if(self.needFooter){
            _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                kStrongSelf(self);
                [self fetchData:NO];
            }];
        }
        
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        //开启fd日志
        _tableView.fd_debugLogEnabled = YES;
        _tableView.emptyDataSetDelegate = self;
        _tableView.emptyDataSetSource = self;
        
    }
    return _tableView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


#pragma mark - 实例方法
-(void)fetchData:(BOOL)isRefresh{
    if (isRefresh) {//下拉刷新
        self.pageNum = ORIGIN_PAGE_NUM;
        self.pageSize = ORIGIN_PAGE_SIZE;
        [self.dataArray removeAllObjects];
    }
    if (self.fetchDataBlock) {
        self.fetchDataBlock(self.pageNum, self.pageSize, isRefresh);
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
