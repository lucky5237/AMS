//
//  HandicapViewController.m
//  AMS
//
//  Created by jianlu on 2018/11/20.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "HandicapViewController.h"
#import "HandicapCollectionViewCell.h"
#import "HandicapTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "DealDetailModel.h"
#import <RDVTabBarController.h>
#import "InstumentModel.h"

@interface HandicapViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UISegmentedControl *segmentedControl;
@property(nonatomic,strong)NSMutableArray *collectionDataArray;
@property(nonatomic,strong)NSMutableArray *tableViewDataArray;
@property(nonatomic,assign)BOOL hasLoadTableView;
@property(nonatomic,strong) UIImageView *underLineView;
@end

#define Collection_Identifier  @"Collection_Identifier"
#define TableView_Identifier  @"TableView_Identifier"

@implementation HandicapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.segmentedControl];
    [self.view addSubview:self.collectView];
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
    [self.view addSubview:self.underLineView];
    [self.underLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KScreenWidth/4-14/2);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(2);
        make.bottom.mas_equalTo(self.segmentedControl.mas_bottom);
    }];
    [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segmentedControl.mas_bottom).offset(1);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view);
    }];
    [self configCollectionData];
}

#pragma mark 实例方法

/**
 获取盘口数据
 */
-(void)configCollectionData{
    for (int i = 0; i<20; i++) {
        NSDictionary *dict = @{@"name":kHandicapParamNames[i],@"price":@"3253.0",@"isRise":@(i%2 ==0)};
        [self.collectionDataArray addObject:dict];
    }
    [self.collectView reloadData];
}

/**
 获取成交明细数据
 */
-(void)configTableViewData{
    for (int i = 0; i<20; i++) {
        DealDetailModel *model = [[DealDetailModel alloc] init];
        model.time = [NSString stringWithFormat:@"10:20:%d",i];
        model.price = @(i+1).stringValue;
        model.isPriceRise = i%2;
        model.xianShouNum = @(i+2);
        model.zengCangNum = @(i+3);
        model.isXianShouRise = i%3;
        model.kaiPing = @"开平";
        [self.tableViewDataArray addObject:model];
    }
    [self.tableView reloadData];
}


/**
 切换tab
 
 @param control control description
 */
-(void)changeTabIndex:(UISegmentedControl*) control{
    if (control.selectedSegmentIndex == 0) {
        if (_hasLoadTableView) {
            [self.tableView setHidden:YES];
            [self.collectView setHidden:NO];
        }
    }else if (control.selectedSegmentIndex == 1){
        if (_hasLoadTableView) {
            [self.collectView setHidden:YES];
            [self.tableView setHidden:NO];
        }else{
            _hasLoadTableView = YES;
            [self.view addSubview:self.tableView];
            [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.segmentedControl.mas_bottom).offset(1);
                make.left.right.mas_equalTo(0);
                make.bottom.mas_equalTo(self.view);
            }];
            [self configTableViewData];
            [self.collectView setHidden:YES];
            [self.tableView setHidden:NO];
        }
    }
    [self.underLineView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (control.selectedSegmentIndex == 0) {
            make.left.mas_equalTo(KScreenWidth/4 - 14/2);
        }else if(control.selectedSegmentIndex == 1){
            make.left.mas_equalTo(KScreenWidth/4 * 3 - 14/2);
        }
    }];
}
#pragma mark 懒加载
-(UICollectionView *)collectView{
    if (!_collectView) {
        //初始化layout
        UICollectionViewFlowLayout *layout =  [[UICollectionViewFlowLayout alloc] init];
//        CGFloat height = MAX(51,(KScreenHeight-kTabBarHeight- 45 - 10)/10);
        layout.itemSize = CGSizeMake(KScreenWidth/2, 51);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 1;
        _collectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectView.bounces = false;
        _collectView.showsVerticalScrollIndicator = false;
        _collectView.backgroundColor = kTableViewBackGroundColor;
        [_collectView registerNib:[UINib nibWithNibName:NSStringFromClass([HandicapCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:Collection_Identifier];
        _collectView.delegate = self;
        _collectView.dataSource = self;
    }
    return _collectView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kTableViewBackGroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator= false;
        _tableView.bounces = false;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HandicapTableViewCell class]) bundle:nil] forCellReuseIdentifier:TableView_Identifier];
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

-(UISegmentedControl *)segmentedControl{
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"盘口",@"成交明细"]];
        [_segmentedControl addTarget:self action:@selector(changeTabIndex:) forControlEvents:UIControlEventValueChanged];
        //        _segmentedControl.tintColor = kClearColor;
        //        _segmentedControl.backgroundColor = kLightGrayColor;
        [_segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:kFontSize(14)}forState:UIControlStateSelected];
        [_segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor zj_colorWithHexString:@"#B9B8CA" alpha:1],NSFontAttributeName:kFontSize(14)}forState:UIControlStateNormal];
        [_segmentedControl setDividerImage:[UIImage new] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [_segmentedControl setBackgroundImage:[AMSUtil imageWithColor:kTabBarBackGroundColor] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [_segmentedControl setBackgroundImage:[AMSUtil imageWithColor:kTabBarBackGroundColor] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        _segmentedControl.selectedSegmentIndex = 0;
    }
    return _segmentedControl;
}

-(NSMutableArray *)collectionDataArray{
    if (!_collectionDataArray) {
        _collectionDataArray = [NSMutableArray array];
    }
    return _collectionDataArray;
}

-(NSMutableArray *)tableViewDataArray{
    if (!_tableViewDataArray) {
        _tableViewDataArray = [NSMutableArray array];
    }
    return _tableViewDataArray;
}

-(UIImageView *)underLineView{
    if (!_underLineView) {
        _underLineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab下划线"]];
//        [_underLineView az_setGradientBackgroundWithColors:@[[UIColor zj_colorWithHexString:@"#C80E42" alpha:1],[UIColor zj_colorWithHexString:@"#F83F66" alpha:1]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    }
    return _underLineView;
}
#pragma mark tableView collectionView代理

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionDataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HandicapCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Collection_Identifier forIndexPath:indexPath];
    NSDictionary *dict = self.collectionDataArray[indexPath.row];
    [cell configData:dict];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewDataArray.count + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HandicapTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:TableView_Identifier forIndexPath:indexPath];
    cell.backgroundColor = kCellBackGroundColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        [cell configData:nil isHeader:YES];
    }else{
        DealDetailModel *model = self.tableViewDataArray[indexPath.row - 1];
        [cell configData:model isHeader:NO];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 38;
    }
    return 34;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kYellowTextColor,NSFontAttributeName:kFontSize(18)}];
    self.rdv_tabBarController.navigationItem.rightBarButtonItem = self.menuBtnItem;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kWhiteColor,NSFontAttributeName:kFontSize(18)}];
    self.rdv_tabBarController.navigationItem.rightBarButtonItem = nil;
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
