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
#import "QryQuotationRequestModel.h"
#import "best_sdk_define.h"
#import <AFNetworking.h>
#import "InstrumentDBModel.h"
#import "InstumentModel.h"
@interface MarketViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,strong) MarketTableViewHeaderView *headerView;
@property(nonatomic,assign) FallRiseBtnType fallRiseBtnType;
@property(nonatomic,assign) VolumeBtnType volumeBtnType;
@property(nonatomic,strong) MarketCellMenuView *menuView;//操作菜单
//当前选择的indexPath
@property(nonatomic,assign) NSIndexPath *currentIndexPath;
//@property(nonatomic,strong) AMSLdatum *currentSelectModel;
@property(nonatomic,strong) PullDownMenuView *pullDownMenuView;//下拉选择
@property(nonatomic,strong) UIButton *arrowBtn;
@property(nonatomic,copy) NSMutableArray *queryArray;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,assign)BOOL hasAccessSocket;
@property(nonatomic,copy) NSArray *responseArray;
@property(nonatomic,copy) NSString *currentExchangeId;
@property(nonatomic,assign) BOOL haveLoadData;
@end

#define identifier @"MarketTableViewCell"

@implementation MarketViewController

#pragma mark 懒加载

-(MarketTableViewHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([MarketTableViewHeaderView class]) owner:nil options:nil]lastObject];
        kWeakSelf(self)
        _headerView.fallRiseBtnBlock = ^(NSInteger tag) {
            kStrongSelf(self)
            self.fallRiseBtnType = tag == 0 ? FallRise : FallRisePer;
            [self.tableView reloadData];
        };
        
        _headerView.volumeBtnBlock = ^(NSInteger tag) {
            kStrongSelf(self)
            self.volumeBtnType = tag == 0 ? Volume : (tag == 1 ?  OpenInterest : DailyIncrement);
            [self.tableView reloadData];
        };
    }
    return _headerView;
}

-(UIButton *)arrowBtn{
    if (!_arrowBtn) {
        _arrowBtn = [[UIButton alloc] init];
        [_arrowBtn setTitle:@"全部合约" forState:UIControlStateNormal];
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

-(NSMutableArray *)queryArray{
    if (!_queryArray) {
        _queryArray = [NSMutableArray array];
    }
    return _queryArray;
}

//-(NSTimer *)timer{
//    if (_timer) {
//       _timer = [NSTimer scheduledTimerWithTimeInterval:HTTP_REQUEST_TIME target:self selector:@selector(httpRepeatRuquest) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
//    }
//    return _timer;
//}


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
    
    if([[AMSDBManager shareInstance] hasSaveData]){
        [self fetchData:self.isOption exchangeID:@""];
    }
   
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

#pragma mark 实例方法

//http轮询查询最新行情
-(void)httpRepeatRuquest{
    
    QryQuotationRequestModel *requestModel = [[QryQuotationRequestModel alloc] init];
    requestModel.stockTradeMins = self.queryArray;
    [self qryQuotation:requestModel];
}

//socket连接成功
-(void)didConnectSocket:(NSNotification *)noti{
    if (![[AMSDBManager shareInstance] hasSaveData]) {
        [self fetchData:self.isOption exchangeID:@""];
    }
        
}

//查询合约
-(void)fetchData:(BOOL)isOption exchangeID:(NSString *)exchangeID{
    self.currentExchangeId = exchangeID;
    [self.dataArray removeAllObjects];
    if (!self.isOption) {
        BOOL hasSaveData = [[AMSDBManager shareInstance] hasSaveData];
        if (hasSaveData) {
            //查找表中所有数据
            NSArray *instrumentDBArray = [[AMSDBManager shareInstance] queryAllInstuments:exchangeID];
            if (instrumentDBArray.count == 0) {
                [MBProgressHUD hideHUD];
//                NSLog(@"暂未收藏合约");
                [self.tableView reloadData];
                
            }else{
                 [MBProgressHUD hideHUD];
                //查询行情
                NSMutableArray *queryArray = @[].mutableCopy;
                [instrumentDBArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    InstrumentDBModel *dbModel = (InstrumentDBModel *)obj;
                    InstumentModel *model = [[InstumentModel alloc] initWithInstumentDBModel:dbModel];
                    [self.dataArray addObject:model];
                    QryQuotationRequestSubModel *subModel =  [[QryQuotationRequestSubModel alloc] init];
                    subModel.stockCodeInternal = dbModel.instrumentID;
                    [queryArray addObject:subModel];
                }];
                [self.tableView reloadData];
//                if (!_haveLoadData) {
                    QryQuotationRequestModel *requestModel = [[QryQuotationRequestModel alloc] init];
                    self.queryArray = queryArray;
                    requestModel.stockTradeMins = queryArray;
                    [self qryQuotation:requestModel];
//                }
                
            }
        }else{
            User_Reqqryinstrument *request = [[User_Reqqryinstrument alloc] init];
            [MBProgressHUD showActivityMessageInView:@""];
            request.ExchangeID = exchangeID;
            [[SocketRequestManager shareInstance] qryInstrument:request];
        }
      
    }else{
        //查找表中所有数据
        NSArray *instrumentDBArray = [[AMSDBManager shareInstance] queryAllCollectInstuments];
        if (instrumentDBArray.count == 0) {
            NSLog(@"暂未收藏合约");
            [self.tableView reloadData];
            
        }else{
            NSLog(@"已收藏合约数目 %ld", instrumentDBArray.count);
            //查询行情
            NSMutableArray *queryArray = @[].mutableCopy;
            [instrumentDBArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                InstrumentDBModel *dbModel = (InstrumentDBModel *)obj;
                InstumentModel *model = [[InstumentModel alloc] initWithInstumentDBModel:dbModel];
                [self.dataArray addObject:model];
                QryQuotationRequestSubModel *subModel =  [[QryQuotationRequestSubModel alloc] init];
                subModel.stockCodeInternal = dbModel.instrumentID;
                [queryArray addObject:subModel];
            }];
            [self.tableView reloadData];
            QryQuotationRequestModel *requestModel = [[QryQuotationRequestModel alloc] init];
            self.queryArray = queryArray;
            requestModel.stockTradeMins = queryArray;
            [self qryQuotation:requestModel];
        }
    }
}

//
-(void)didReceiveSocketData:(NSNotification *)noti{
    [super didReceiveSocketData:noti];
    [MBProgressHUD hideHUD];
    if((int32)self.funtionNo.integerValue == AS_SDK_USER_ONRSPQRYINSTRUMENT){
        NSArray *repArray = self.response;
        self.responseArray = repArray;
        [self.queryArray removeAllObjects];
        [self.dataArray removeAllObjects];
        NSMutableArray *dbArray = @[].mutableCopy;
        NSMutableArray *queryArray = @[].mutableCopy;
        if(repArray.count > 0){
            [repArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                User_Onrspqryinstrument *responseObject = (User_Onrspqryinstrument *)obj;
//                NSLog(@"responseObject is %@",responseObject.yy_modelToJSONString);
                InstumentModel *model = [[InstumentModel alloc] init];
                model.instrument = responseObject;
                [self.dataArray addObject:model];
                //数据库
                InstrumentDBModel *dbModel = [[InstrumentDBModel alloc] init];
                dbModel.instrumentID = responseObject.InstrumentID;
                dbModel.instrumentName = responseObject.InstrumentName;
                dbModel.exchangeID = responseObject.ExchangeID;
                dbModel.priceTick = responseObject.PriceTick;
                dbModel.volumeMultiple = responseObject.VolumeMultiple;
                dbModel.hasCollect = @0;
//                dbModel.hasCollect = @"0";
                [dbArray addObject:dbModel];
                //查询model
                QryQuotationRequestSubModel *subModel = [[QryQuotationRequestSubModel alloc] init];
                subModel.stockCodeInternal = responseObject.InstrumentID;
                [queryArray addObject:subModel];
            }];
             [self.tableView reloadData];
            //查找表中所有数据
            if (![[AMSDBManager shareInstance] hasSaveData]) {
                [[AMSDBManager shareInstance] saveAllInstuments:dbArray];
            }
            
            QryQuotationRequestModel *requestModel = [[QryQuotationRequestModel alloc] init];
            requestModel.stockTradeMins = queryArray;
            [self qryQuotation:requestModel];
        }else{
            [self.tableView reloadData];
//            [MBProgressHUD showErrorMessage:@"暂无数据"];
        }
    }
}


//http查询行情
-(void)qryQuotation:(QryQuotationRequestModel *)model{
    dispatch_async(dispatch_queue_create(0, 0), ^{
        if (model == nil) {
            return;
        }
        
        if (self.dataArray.count == 0) {
            return ;
        }
        
        NSString *str =  [model.stockTradeMins.mutableCopy yy_modelToJSONString];
        NSDictionary *dict = @{@"stockTradeMins":str};
        //    NSMutableArray *tempQuotationArray = @[].mutableCopy;
        //    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //        AMSLdatum *data = [[AMSLdatum alloc] init];
        //        [tempQuotationArray addObject:data];
        //    }];
        
        [NetWorking requestWithApi:[NSString stringWithFormat:@"%@%@",BaseUrl,QryQuotation_URL] reqeustType:POST_Type param:dict thenSuccess:^(NSDictionary *responseObject) {
            QryQuotationResponseModel *item = [QryQuotationResponseModel yy_modelWithDictionary:responseObject];
            
            NSArray *quotationArray = item.ldata;
            if (quotationArray.count != self.dataArray.count) {
                NSLog(@"行情数目与合约数目不相等");
                NSLog(@"quotationArray is %ld and requestArray is %ld ",quotationArray.count,model.stockTradeMins.count);
            }
            if (quotationArray.count> 0) {
                [quotationArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    AMSLdatum *quotation =(AMSLdatum *)obj;
                    if (idx > self.dataArray.count - 1) {
                        *stop = YES;
                    }else
                    {
                        InstumentModel *model = self.dataArray[idx];
                        model.quotation = quotation;
                    }
                    
                }];
                [self.tableView reloadData];
                if(!self.haveLoadData){
                    [self startTimer];
                    self.hasAccessSocket = YES;
                    self.haveLoadData = YES;
                }
                
            }else{
                [self.tableView reloadData];
                //            [MBProgressHUD showErrorMessage:@"暂无数据"];
            }
            
        } fail:^(NSString *str) {
            
        }];
    });
    
}

//开启定时器轮询
-(void)startTimer{
    if(self.timer == nil){
        self.timer = [NSTimer scheduledTimerWithTimeInterval:HTTP_REQUEST_TIME target:self selector:@selector(httpRepeatRuquest) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

//关闭定时器
-(void)closeTimer{
    if (self.timer !=nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

/**
 显示下拉菜单
 */
-(void)showMenuView{
    NSDictionary *alwaysInDict = @{@"code":@"",@"name":@"全部合约"};
    NSArray *selectPlateArray = [kUserDefaults objectForKey:PLATE_SETTING_DICT];
    NSMutableArray *selectArray = [NSMutableArray array];
    [selectArray addObject:alwaysInDict];
    [selectArray addObjectsFromArray:selectPlateArray];
    if (self.pullDownMenuView == nil) {
        PullDownMenuView *pullDownMenuView = [[PullDownMenuView alloc] initWithFrame:CGRectMake(1, 0, KScreenWidth, [PullDownMenuView heightOfMenuView:selectArray]) dataArray:selectArray];
        pullDownMenuView.menuCellTapBlock = ^(NSDictionary * _Nonnull dict) {
            [self closeTimer];
            [self.arrowBtn setTitle:dict[@"name"] forState:UIControlStateNormal];
            [self.arrowBtn sizeToFit];
            [self hideMenuView];
            [MBProgressHUD showActivityMessageInView:@""];
            [self fetchData:self.isOption exchangeID:dict[@"code"]];
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
                    InstumentModel *model = self.dataArray[self.currentIndexPath.row];
                    if([[AMSDBManager shareInstance] hasInstrumentCollected:model.instrument.InstrumentID]){
                        if ([[AMSDBManager shareInstance] canCelCollectInstumentById:model.instrument.InstrumentID]) {
                            [MBProgressHUD showSuccessMessage:@"删除自选成功"];
                            if (self.isOption) {
                                [self.tableView deleteRowsAtIndexPaths:@[self.currentIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                            }else{
                                model.hasCollect = !model.hasCollect;
                                [self.tableView reloadRowsAtIndexPaths:@[self.currentIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                            }
                        }else{
                            NSLog(@"删除数据失败--");
                        }
                        
                    }else{
                        if ([[AMSDBManager shareInstance] collectInstumentById:model.instrument.InstrumentID]) {
                            [MBProgressHUD showSuccessMessage:[NSString stringWithFormat:@"%@已加入自选",model.instrument.InstrumentName]];
                            model.hasCollect = !model.hasCollect;
                            [self.tableView reloadRowsAtIndexPaths:@[self.currentIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                            
                        }else{
                            NSLog(@"添加数据失败--");
                        }
                    }
                    [self disAppearOpView];
                }];
                
                [self.menuView.goTradeBtn zj_addBtnActionHandler:^{
                    InstumentModel *model = self.dataArray[self.currentIndexPath.row];
                    MarketDetailViewController *detailViewVC = [[MarketDetailViewController alloc] init];
                    detailViewVC.model = model;
                    detailViewVC.selectIndex = 2;
                    [self.navigationController pushViewController:detailViewVC animated:YES];
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
            if (self.isOption == YES) {
                [self.menuView.collectBtn setSelected:YES];
            }else{
                InstumentModel *model = self.dataArray[self.currentIndexPath.row];
                model.hasCollect = [[AMSDBManager shareInstance] hasInstrumentCollected:model.instrument.InstrumentID];
                [self.menuView.collectBtn setSelected:model.hasCollect];
            }
          
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
    InstumentModel *model = self.dataArray[indexPath.row];
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
        [self fetchData:self.isOption exchangeID:@""];
    }
    
    if(self.timer == nil && self.hasAccessSocket){
        [self startTimer];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.rdv_tabBarController.tabBarHidden = YES;
    if (!_isOption) {
        [self.arrowBtn removeFromSuperview];
    }
    [self closeTimer];
}

-(void)dealloc{
    [self closeTimer];
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
