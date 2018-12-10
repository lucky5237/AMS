//
//  SearchViewController.m
//  AMS
//
//  Created by jianlu on 2018/11/21.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell.h>

@interface SearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UISearchBar *searchBar;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) UIView *navView;
@end
#define identifier @"SearchTableViewCell"
@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}
#pragma mark 懒加载
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.tintColor = kNormalTextColor;
        _searchBar.barTintColor = kNormalTextColor;
        UITextField *searchField=[_searchBar valueForKey:@"searchField"];
        searchField.backgroundColor = kNavBackGroundColor;
        searchField.textColor = kNormalTextColor;
        searchField.font = kFontSize(12);
        _searchBar.backgroundColor = kNavBackGroundColor;
        _searchBar.layer.masksToBounds = YES;
        _searchBar.layer.borderColor = [UIColor zj_colorWithHexString:@"#61616B" alpha:1].CGColor;
        _searchBar.layer.borderWidth = 1.f;
        _searchBar.layer.cornerRadius = 5.f;
        _searchBar.delegate = self;
    }
    return _searchBar;
}

-(UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc] init];
        _navView.backgroundColor = kTabBarBackGroundColor;
//        _navView.backgroundColor = kOrangeColor;
    }
    return _navView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView zj_tableViewWithSuperview:self.view delegate:self style:UITableViewStylePlain constraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(1);
            make.left.right.bottom.mas_equalTo(self.view);
        }];
        _tableView.separatorColor = kTableViewBackGroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = kTableViewBackGroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SearchTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier];
//        _tableView.backgroundColor = kBackGroundColor;
//        _tableView.separatorColor = kWhiteColor;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [[UIView alloc] init];
//        kWeakSelf(self);
//        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            kStrongSelf(self);
//            [self fetchData:YES];
//        }];
//
//        if(self.needFooter){
//            _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//                kStrongSelf(self);
//                [self fetchData:NO];
//            }];
//        }
        
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        //开启fd日志
        _tableView.fd_debugLogEnabled = YES;
//        _tableView.emptyDataSetDelegate = self;
//        _tableView.emptyDataSetSource = self;
        
    }
    return _tableView;
}
#pragma mark 实例方法
-(void)doSearch:(NSString*)keyWord{
    [self.dataArray removeAllObjects];
    for (int i =0; i<keyWord.length; i++) {
        NSDictionary *dict = @{@"name":[NSString stringWithFormat:@"期货%d",i+1],@"id":@(i+1),@"hasCollect":@(i%2==0)};
        [self.dataArray addObject:dict];
    }
    [self.tableView reloadData];
}

#pragma mark Delegate 方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSMutableDictionary *dict = self.dataArray[indexPath.row];
    cell.nameLabel.text = dict[@"name"];
    cell.backgroundColor = kCellBackGroundColor;
    NSNumber *hasCollect = dict[@"hasCollect"];
    [cell.collectBtn setSelected:hasCollect.boolValue];
    [cell.collectBtn setZj_onTouchUp:^(UIButton* sender) {
        if (sender.selected) {//取消收藏
//            dict[@"hasCollect"] = @0;
            sender.selected = !sender.selected;
//            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [MBProgressHUD showInfoMessage:@"取消收藏成功"];
        }else{
            sender.selected = !sender.selected;
//            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [MBProgressHUD showInfoMessage:@"收藏成功"];
        }
    }];
    return cell;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    NSLog(@"搜索 ---- %@",searchText);
    if (searchText.length == 0) {
        [self.dataArray removeAllObjects];
        [self.tableView reloadData];
    }else{
        [self doSearch:searchText];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     NSDictionary *dict = self.dataArray[indexPath.row];
    if(self.didSelectItemBlock){
        self.didSelectItemBlock(dict);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController.navigationBar addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-45);
        make.left.mas_equalTo(44);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
    }];
    [self.navView addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navView);
    }];
    [self.searchBar becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
    [self.navView removeFromSuperview];
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
