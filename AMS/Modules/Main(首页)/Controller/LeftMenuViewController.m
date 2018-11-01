//
//  LeftMenuViewController.m
//  AMS
//
//  Created by jianlu on 2018/10/31.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "LeftMenuViewController.h"

static NSString* identifier = @"tableViewCell";
@interface LeftMenuViewController ()
    @end

@implementation LeftMenuViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    kWeakSelf(self);
    self.fetchDataBlock = ^(NSUInteger pageNum, NSUInteger pageSize, BOOL isRefresh) {
        kStrongSelf(self);
        [self.dataArray addObject:@"1"];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    };
}
    
    
#pragma mark tableView delegate && datasource

    
    -(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return kTopHeight;
    }
    
    -(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = kPurpleColor;
        return view;
    }
    
    -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
      
        CGFloat height = [tableView fd_heightForCellWithIdentifier:identifier cacheByIndexPath:indexPath configuration:^(UITableViewCell* cell) {
            cell.textLabel.text = @"Hello";
        }];
        return height;
    }
    
    -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.textLabel.text = @"Hello";
        return cell;
    }
    
    
    /*
     #pragma mark - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
#pragma mark 空数据展示
    
    -(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
        NSString *text = @"Please Allow Photo Access";
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                     NSForegroundColorAttributeName: [UIColor darkGrayColor]};
        
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }
    
    -(UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
        return kLightGrayColor;
    }
    
    -(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
        return IMAGE_NAMED(@"MBHUD_Error");
    }
    
    -(BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
        return YES;
    }
    
    -(void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
        DLog(@"tap view");
        [self.tableView.mj_header beginRefreshing];
    }
    @end
