//
//  MarketViewController.m
//  AMS
//  行情
//  Created by jianlu on 2018/11/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "MarketViewController.h"
#import "MarketTableViewCell.h"
#import "MarketModel.h"
#import "MarketTableViewHeaderView.h"
#import "MarketCellMenuView.h"
#import "SettingMainViewController.h"

@interface MarketViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong) MarketTableViewHeaderView *headerView;
@property(nonatomic,assign) FallRiseBtnType fallRiseBtnType;
@property(nonatomic,assign) VolumeBtnType volumeBtnType;
@property(nonatomic,strong) MarketCellMenuView *menuView;//操作菜单
//当前选择的indexPath
@property(nonatomic,assign) NSIndexPath *currentIndexPath;
@property(nonatomic,strong) MarketModel *currentSelectModel;
@end

#define identifier @"MarketTableViewCell"

@implementation MarketViewController

-(MarketTableViewHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([MarketTableViewHeaderView class]) owner:nil options:nil]lastObject];
        kWeakSelf(self)
        _headerView.fallRiseBtnBlock = ^(NSInteger tag) {
            kStrongSelf(self)
            self.fallRiseBtnType = tag;
            [self.tableView reloadData];
        };
        
        _headerView.volumeBtnBlock = ^(NSInteger tag) {
            kStrongSelf(self)
            self.volumeBtnType = tag;
            [self.tableView reloadData];
        };
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主力合约";
    self.rt_navigationController.navigationBar.backgroundColor = [UIColor darkGrayColor];
    self.tableView.backgroundColor = kBlackColor;
    [self.tableView registerClass:[MarketTableViewCell class] forCellReuseIdentifier:identifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = kWhiteColor;
    self.tableView.tableFooterView = [[UIView alloc] init];
    //禁用下拉刷新上拉加载
    self.tableView.mj_header = nil;
    self.tableView.mj_footer = nil;
    
    //添加长按事件
    UILongPressGestureRecognizer *longPressGecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewDidLongPressed:)];
    [self.tableView addGestureRecognizer:longPressGecognizer];
    

    //添加导航栏右侧菜单栏
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithImage:kImageName(@"交易_selected") style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonItemTapped:)];
    self.navigationItem.rightBarButtonItem = barItem;
    //获取数据
    [self fetchData];
}


/**
 获取数据
 */
-(void)fetchData{
    //模拟数据
    for (int i = 0; i < 10; i++){
        MarketModel *model = [[MarketModel alloc] init];
        model.name = [NSString stringWithFormat:@"期货名字%d",i];
        model.price = @(i+1);
        model.fallRise = @(6.0);
        model.fallRisePer = @(1.0);
        model.volume = @(i+2);
        model.openInterest = @(1000);
        model.dailyIncrement = @(10);
        model.hasCollect = i % 2 == 0;
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
}

-(void)rightButtonItemTapped:(UIBarButtonItem*) barItem{
    NSLog(@"点击了菜单栏");
    SettingMainViewController *settingVC = [[SettingMainViewController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.rt_navigationController pushViewController:settingVC animated:YES];
    
}

/**
 tableView 长按处理
 @param recognizer recognizer
 */
-(void)tableViewDidLongPressed:(UILongPressGestureRecognizer*)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [recognizer locationInView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
        if (indexPath == nil) {
            NSLog(@"indexPath is nil");
        }else{
            [self disAppearOpView];
            self.currentIndexPath = indexPath;
            MarketTableViewCell* cell = (MarketTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
            [cell configSelection:YES];
            
            if (self.menuView == nil) {
                self.menuView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MarketCellMenuView class]) owner:nil options:nil]lastObject];
                [self.menuView.collectBtn zj_addBtnActionHandler:^{
                    MarketModel *model = self.dataArray[self.currentIndexPath.row];
                    if(model.hasCollect){
                        [MBProgressHUD showSuccessMessage:@"删除自选成功"];
                    }else{
                        [MBProgressHUD showSuccessMessage:[NSString stringWithFormat:@"%@已加入自选",model.name]];
                    }
                    model.hasCollect = !model.hasCollect;
                    [self.tableView reloadRowsAtIndexPaths:@[self.currentIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                    [self disAppearOpView];
                }];
                
                [self.menuView.goTradeBtn zj_addBtnActionHandler:^{
                    MarketModel *model = self.dataArray[self.currentIndexPath.row];
                    [MBProgressHUD showTipMessageInView:[NSString stringWithFormat:@"点击去交易按钮%@",model.name]];
                    [self disAppearOpView];
                }];
                
            }
            [self.tableView addSubview:self.menuView];
            [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(KScreenWidth);
                make.height.mas_equalTo(cell.frame.size.height);
                make.left.mas_equalTo(0);
                make.top.mas_equalTo(cell.mas_bottom);
            }];
             MarketModel *model = self.dataArray[self.currentIndexPath.row];
            [self.menuView.collectBtn setSelected:model.hasCollect];
        }
    }
}
/**
 操作菜单消失调用
 */
-(void)disAppearOpView{
    if (self.menuView !=nil) {
        [self.menuView removeFromSuperview];
    }
    MarketTableViewCell* cell = (MarketTableViewCell*)[self.tableView cellForRowAtIndexPath:self.currentIndexPath];
    [cell configSelection:false];
    self.currentIndexPath = nil;
}

#pragma mark 滚动代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self disAppearOpView];
}

#pragma mark tableView 代理
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = [tableView fd_heightForCellWithIdentifier:identifier cacheByIndexPath:indexPath configuration:^(MarketTableViewCell* cell) {
        MarketModel *model = self.dataArray[indexPath.row];
        [cell configModel:model fallRiseType:self.fallRiseBtnType volumeType:self.volumeBtnType];
    }];
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MarketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = kBlackColor;
    MarketModel *model = self.dataArray[indexPath.row];
    [cell configModel:model fallRiseType:self.fallRiseBtnType volumeType:self.volumeBtnType];
    [cell configSelection:indexPath == self.currentIndexPath];
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.currentIndexPath) {
        [self disAppearOpView];
    }else{
        NSLog(@"点击了tableViewCell");
    }
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
