//
//  MarketViewController.m
//  AMS
//  行情
//  Created by jianlu on 2018/11/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "MarketViewController.h"
#import "MarketTableViewCell.h"
#import "AMSDBManager.h"
#import "MarketTableViewHeaderView.h"
#import "MarketCellMenuView.h"
#import "SettingMainViewController.h"
#import "PullDownMenuView.h"
#import "MarketDetailViewController.h"
#import "User_Reqqryinstrument.h"
#import "User_Onrspqryinstrument.h"
#import "SocketRequestManager.h"
#import "AMSConstant.h"
#import "QryQuotationResponseModel.h"
#import "CollectQuatationDBModel.h"
#import <JQFMDB.h>

@interface MarketViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,strong) MarketTableViewHeaderView *headerView;
@property(nonatomic,assign) FallRiseBtnType fallRiseBtnType;
@property(nonatomic,assign) VolumeBtnType volumeBtnType;
@property(nonatomic,strong) MarketCellMenuView *menuView;//操作菜单
//当前选择的indexPath
@property(nonatomic,assign) NSIndexPath *currentIndexPath;
@property(nonatomic,strong) AMSLdatum *currentSelectModel;
@property(nonatomic,strong) PullDownMenuView *pullDownMenuView;//下拉选择
@property(nonatomic,strong) UIButton *arrowBtn;
@end

#define identifier @"MarketTableViewCell"

@implementation MarketViewController

-(MarketTableViewHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([MarketTableViewHeaderView class]) owner:nil options:nil]lastObject];
        kWeakSelf(self)
        _headerView.fallRiseBtnBlock = ^(NSInteger tag) {
            kStrongSelf(self)
//            self.fallRiseBtnType = tag;
            [self.tableView reloadData];
        };
        
        _headerView.volumeBtnBlock = ^(NSInteger tag) {
            kStrongSelf(self)
//            self.volumeBtnType = tag;
            [self.tableView reloadData];
        };
    }
    return _headerView;
}

-(UIButton *)arrowBtn{
    if (!_arrowBtn) {
        _arrowBtn = [[UIButton alloc] init];
        [_arrowBtn setTitle:@"主力合约" forState:UIControlStateNormal];
        [_arrowBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _arrowBtn.titleLabel.font = kFontSize(18);
        [_arrowBtn setImage:[UIImage imageNamed:@"向下箭头"] forState:UIControlStateNormal];
        _arrowBtn.semanticContentAttribute = [UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft ? UISemanticContentAttributeForceLeftToRight : UISemanticContentAttributeForceRightToLeft;
        [_arrowBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -12)];
        [_arrowBtn zj_addBtnActionHandler:^{
            if (self.pullDownMenuView.isShow) {
                [self hideMenuView];
            }else{
                [self showMenuView];
            }
        }];
    }
    return _arrowBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[MarketTableViewCell class] forCellReuseIdentifier:identifier];
    self.tableView.tableFooterView = [[UIView alloc] init];
    //禁用下拉刷新上拉加载
    self.tableView.mj_header = nil;
    self.tableView.mj_footer = nil;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewDidTapped:)];
    tap.delegate = self;
    [self.tableView addGestureRecognizer:tap];
    
    //添加长按事件
    UILongPressGestureRecognizer *longPressGecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewDidLongPressed:)];
    [self.tableView addGestureRecognizer:longPressGecognizer];
    //获取数据
    [self fetchData:self.isOption];
}

-(void)tableViewDidTapped:(UITapGestureRecognizer*)tap{
    if (self.pullDownMenuView.isShow) {
        [self hideMenuView];
    }else{
        [self disAppearOpView];
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.pullDownMenuView.isShow || self.menuView.isShow) {
        return YES;
    }
    return NO;
}

/**
 获取数据
 */
-(void)fetchData:(BOOL)isOption{
    //模拟数据
//    for (int i = 0; i < 10; i++){
//        AMSLdatum *model = [[MarketModel alloc] init];
//        model.marketId = @(i);
//        model.name = [NSString stringWithFormat:@"期货名字%d",i];
//        model.price = @(i+1);
//        model.fallRise = @(6.0);
//        model.fallRisePer = @(1.0);
//        model.volume = @(i+2);
//        model.openInterest = @(1000);
//        model.dailyIncrement = @(10);
//        model.hasCollect = i % 2 == 0;
//        [self.dataArray addObject:model];
//    }
    if (!self.isOption) {
//        User_Reqqryinstrument *request = [[User_Reqqryinstrument alloc] init];
//        [[SocketRequestManager shareInstance] qryInstrument:request];
    }else{
        //查找表中所有数据
        NSArray *quotationArray = [[AMSDBManager shareInstance] queryAllQuotations];
        NSLog(@"表中所有数据:%@", quotationArray);
        if (quotationArray.count == 0) {
            NSLog(@"暂未添加到自选");
        }else{
            [quotationArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CollectQuatationDBModel *model = obj;
                
            }];
        }
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:quotationArray];
        [self.tableView reloadData];
    }
}

-(void)didReceiveSocketData:(NSNotification *)noti{
    NSString *repJson = noti.object;
    NSLog(@"合约详情-- %@",repJson);
    User_Onrspqryinstrument *response  = (User_Onrspqryinstrument *)[User_Onrspqryinstrument yy_modelWithJSON:repJson];
    if(response.InstrumentID != nil && response.InstrumentID.length > 0 ){
        [self qryQuotation:response.InstrumentID];
    }else{
        [MBProgressHUD showErrorMessage:@"合约代码为空"];
    }
    
}

-(void)qryQuotation:(NSString *)instrumentID{
    NSDictionary *dict = @{@"stockTradeMins":@[@{@"stockCodeInternal":instrumentID}]};
    [NetWorking requestWithApi:[NSString stringWithFormat:@"%@%@",BaseUrl,QryQuotation_URL] reqeustType:POST_Type param:dict thenSuccess:^(NSDictionary *responseObject) {
        QryQuotationResponseModel *model = [QryQuotationResponseModel yy_modelWithDictionary:responseObject];
        NSArray *dataList = model.ldata;
        if (dataList.count> 0) {
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:dataList];
            [self.tableView reloadData];
        }else{
           [MBProgressHUD showErrorMessage:@"暂无数据"];
        }

    } fail:^(NSString *str) {

    }];
}

/**
 显示下拉菜单
 */
-(void)showMenuView{
    NSDictionary *alwaysInDict = @{@"id":@0,@"name":@"主力合约"};
    NSArray *selectPlateArray = [kUserDefaults objectForKey:PLATE_SETTING_DICT];
    NSMutableArray *selectArray = [NSMutableArray array];
    [selectArray addObject:alwaysInDict];
    [selectArray addObjectsFromArray:selectPlateArray];
    if (self.pullDownMenuView == nil) {
        PullDownMenuView *pullDownMenuView = [[PullDownMenuView alloc] initWithFrame:CGRectMake(1, 0, KScreenWidth, [PullDownMenuView heightOfMenuView:selectArray]) dataArray:selectArray];
        pullDownMenuView.menuCellTapBlock = ^(NSDictionary * _Nonnull dict) {
            [self.arrowBtn setTitle:dict[@"name"] forState:UIControlStateNormal];
            [self.arrowBtn sizeToFit];
            [self hideMenuView];
        };
        self.pullDownMenuView = pullDownMenuView;
        self.pullDownMenuView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1].CGColor;
        self.pullDownMenuView.layer.shadowOffset = CGSizeMake(0,2);
        self.pullDownMenuView.layer.shadowOpacity = 1;
        self.pullDownMenuView.layer.shadowRadius = 5;
        [self.pullDownMenuView ConfigData:selectArray firstShow:YES];
    }else{
        [self.pullDownMenuView ConfigData:selectArray firstShow:NO];
        self.pullDownMenuView.frame = CGRectMake(1, 0, KScreenWidth, [PullDownMenuView heightOfMenuView:selectArray]);
    }
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.1];//时间
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];//效果
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    self.tableView.backgroundColor = kBlackColor;
    self.tableView.alpha = 0.5;
    [self.view addSubview:self.pullDownMenuView];//要做的事情
    self.pullDownMenuView.isShow = YES;
    [UIView commitAnimations];
    [self.arrowBtn setImage:[UIImage imageNamed:@"向上箭头"] forState:UIControlStateNormal];
}

/**
 隐藏下拉菜单
 */
-(void)hideMenuView{
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.1];//时间
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];//效果
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    [self.pullDownMenuView removeFromSuperview];//要做的事情
    self.pullDownMenuView.isShow = NO;
    self.tableView.backgroundColor = kTableViewBackGroundColor;
    self.tableView.alpha = 1;
    [UIView commitAnimations];
    [self.arrowBtn setImage:[UIImage imageNamed:@"向下箭头"] forState:UIControlStateNormal];
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
            [cell configSelection:YES fallRiseType:self.fallRiseBtnType volumeType:self.volumeBtnType];
            
            if (self.menuView == nil) {
                self.menuView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MarketCellMenuView class]) owner:nil options:nil]lastObject];
                [self.menuView.collectBtn zj_addBtnActionHandler:^{
                    AMSLdatum *model = self.dataArray[self.currentIndexPath.row];
                    if([[AMSDBManager shareInstance] isQuotationCollected:model.stockCodeInternal]){
//                        CollectQuatationDBModel *dbModel = [[CollectQuatationDBModel alloc] init];
//                        dbModel.instrumentID = model.stockCodeInternal;
//                        dbModel.instrumentName = model.stockName;
                        if ([[AMSDBManager shareInstance] deleteQuotation:model.stockCodeInternal]) {
                            [MBProgressHUD showSuccessMessage:@"删除自选成功"];
                        }else{
                            NSLog(@"删除数据失败--");
                        }
                        
                    }else{
                        CollectQuatationDBModel *dbModel = [[CollectQuatationDBModel alloc] init];
                        dbModel.instrumentID = model.stockCodeInternal;
                        dbModel.instrumentName = model.stockName;
                        if ([[AMSDBManager shareInstance] addQuotations:dbModel]) {
                            [MBProgressHUD showSuccessMessage:[NSString stringWithFormat:@"%@已加入自选",model.stockName]];
                        }else{
                            NSLog(@"添加数据失败--");
                        }
                    }
                    model.hasCollect = !model.hasCollect;
                    [self.tableView reloadRowsAtIndexPaths:@[self.currentIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                    [self disAppearOpView];
                }];
                
                [self.menuView.goTradeBtn zj_addBtnActionHandler:^{
                    AMSLdatum *model = self.dataArray[self.currentIndexPath.row];
                    [MBProgressHUD showTipMessageInView:[NSString stringWithFormat:@"点击去交易按钮%@",model.stockName]];
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
            AMSLdatum *model = self.dataArray[self.currentIndexPath.row];
            model.hasCollect = [[AMSDBManager shareInstance] isQuotationCollected:model.stockCodeInternal];
            [self.menuView.collectBtn setSelected:model.hasCollect];
            self.menuView.isShow = YES;
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
    [cell configSelection:false fallRiseType:self.fallRiseBtnType volumeType:self.volumeBtnType];
    self.currentIndexPath = nil;
    self.menuView.isShow = false;
}

#pragma mark 滚动代理
-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    [self disAppearOpView];
}

#pragma mark tableView 代理
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MarketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = kBlackColor;
    AMSLdatum *model = self.dataArray[indexPath.row];
//    model.hasCollect =
    [cell configModel:model fallRiseType:self.fallRiseBtnType volumeType:self.volumeBtnType];
    [cell configSelection:indexPath == self.currentIndexPath fallRiseType:self.fallRiseBtnType volumeType:self.volumeBtnType];
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.currentIndexPath) {
        [self disAppearOpView];
    }else{
        MarketDetailViewController *detailVC = [[MarketDetailViewController alloc] init];
        detailVC.model = self.dataArray[indexPath.row];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rdv_tabBarController.tabBarHidden = NO;
    if (!self.isOption) {
        //添加标题
        [self.navigationController.navigationBar addSubview:self.arrowBtn];
        [self.arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.navigationController.navigationBar);
            make.height.mas_equalTo(self.navigationController.navigationBar.mas_height);
        }];
    }else{
        self.title = @"自选";
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.rdv_tabBarController.tabBarHidden = YES;
    if (!_isOption) {
        [self.arrowBtn removeFromSuperview];
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
