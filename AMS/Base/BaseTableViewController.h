//
//  BaseTableViewController.h
//  AMS
//
//  Created by jianlu on 2018/11/1.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "BaseViewController.h"
#import <MJRefresh.h>
#import <UITableView+FDTemplateLayoutCell.h>
NS_ASSUME_NONNULL_BEGIN

typedef void(^FetchDataBlock)(NSUInteger pageNum,NSUInteger pageSize,BOOL isRefresh);

@interface BaseTableViewController : BaseViewController
@property(nonatomic,strong) UITableView* tableView;
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,assign) NSUInteger pageSize;//每页加载的数据数量
@property(nonatomic,assign) NSUInteger pageNum;//页码
@property(nonatomic,assign) BOOL needFooter;//是否需要上拉加载更多
@property(nonatomic,copy) FetchDataBlock fetchDataBlock;//获取Data Block
@end

NS_ASSUME_NONNULL_END
