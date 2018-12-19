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
#import "QryQuotationRequestModel.h"
#import "best_sdk_define.h"
#import <MJExtension.h>
#import <AFNetworking.h>
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
@property(nonatomic,copy) NSMutableArray *queryArray;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,assign)BOOL hasAccessSocket;
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

//-(NSTimer *)timer{
//    if (_timer) {
//       _timer = [NSTimer scheduledTimerWithTimeInterval:HTTP_REQUEST_TIME target:self selector:@selector(httpRepeatRuquest) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
//    }
//    return _timer;
//}

-(void)httpRepeatRuquest{
//    NSLog(@"模拟http请求");
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
    
    if(!self.isOption){
         [self fetchData:self.isOption];
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

-(void)didConnectSocket:(NSNotification *)noti{
        [self fetchData:self.isOption];

}

/**
 获取数据
 */
-(void)fetchData:(BOOL)isOption{
   
    if (!self.isOption) {
        [self qryQuotation:[QryQuotationRequestModel new]];
//        User_Reqqryinstrument *request = [[User_Reqqryinstrument alloc] init];
//        [[SocketRequestManager shareInstance] qryInstrument:request];
    }else{
        //查找表中所有数据
        NSArray *quotationArray = [[AMSDBManager shareInstance] queryAllQuotations];
        NSLog(@"表中所有数据:%@", quotationArray);
        if (quotationArray.count == 0) {
            NSLog(@"暂未添加自选");
        }else{
            QryQuotationRequestModel *requestModel = [[QryQuotationRequestModel alloc] init];
            
            NSMutableArray *queryArray = @[].mutableCopy;
            [quotationArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CollectQuatationDBModel *model = obj;
                QryQuotationRequestSubModel *subModel =  [[QryQuotationRequestSubModel alloc] init];
                subModel.stockCodeInternal = model.instrumentID;
                [queryArray addObject:subModel];
            }];
            requestModel.stockTradeMins = queryArray;
            [self qryQuotation:requestModel];
        }
    }
}

-(void)didReceiveSocketData:(NSNotification *)noti{
    [super didReceiveSocketData:noti];
    if((int32)self.funtionNo.integerValue == AS_SDK_USER_ONRSPQRYINSTRUMENT){
        NSArray *repArray = self.response;
        //    NSLog(@"合约详情-- %@",repJson);
        //    User_Onrspqryinstrument *response  = (User_Onrspqryinstrument *)[User_Onrspqryinstrument yy_modelWithJSON:repJson];
        //    NSLog(@"%@",response.InstrumentID);
        if(repArray.count > 0){
            [repArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                User_Onrspqryinstrument *responseObject = (User_Onrspqryinstrument *)obj;
                QryQuotationRequestSubModel *subModel = [[QryQuotationRequestSubModel alloc] init];
                subModel.stockCodeInternal = responseObject.InstrumentID;
                [self.queryArray addObject:subModel];
            }];
            
            QryQuotationRequestModel *requestModel = [[QryQuotationRequestModel alloc] init];
            requestModel.stockTradeMins = self.queryArray;
            [self qryQuotation:requestModel];
        }else{
            [MBProgressHUD showErrorMessage:@"暂无数据"];
        }
    }
}

-(NSMutableArray *)queryArray{
    if (!_queryArray) {
        _queryArray = [NSMutableArray array];
    }
    return _queryArray;
}

-(void)qryQuotation:(QryQuotationRequestModel *)model{
    if (model == nil) {
        return;
    }
    if (!self.isOption) {
        QryQuotationRequestSubModel *subModel=  [[QryQuotationRequestSubModel alloc] init];
        subModel.stockCodeInternal  = @"a1903";
        QryQuotationRequestSubModel *subModel1=  [[QryQuotationRequestSubModel alloc] init];
        subModel1.stockCodeInternal  = @"zn1912";
        QryQuotationRequestSubModel *subModel2=  [[QryQuotationRequestSubModel alloc] init];
        subModel2.stockCodeInternal  = @"a1901";
        model.stockTradeMins = @[subModel,subModel1,subModel2];
    }
   
    NSString *str =  [model.stockTradeMins.mutableCopy yy_modelToJSONString];
    NSLog(@"json string is %@",str);
    NSDictionary *dict = @{@"stockTradeMins":str};
   
    NSLog(@"%@",dict);
        [NetWorking requestWithApi:[NSString stringWithFormat:@"%@%@",BaseUrl,QryQuotation_URL] reqeustType:POST_Type param:dict thenSuccess:^(NSDictionary *responseObject) {
            QryQuotationResponseModel *model = [QryQuotationResponseModel yy_modelWithDictionary:responseObject];
            NSArray *dataList = model.ldata;
            if (dataList.count> 0) {
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:dataList];
                [self.queryArray removeAllObjects];
                [self.tableView reloadData];
                [self startTimer];
                self.hasAccessSocket = YES;
            }else{
               [MBProgressHUD showErrorMessage:@"暂无数据"];
            }
    
        } fail:^(NSString *str) {
    
        }];
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//             };
//    NSURLSessionDataTask *task = [manager POST:[NSString stringWithFormat:@"%@%@",BaseUrl,QryQuotation_URL] parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
//        //        NSLog(@"进度更新");
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        QryQuotationResponseModel *model = [QryQuotationResponseModel yy_modelWithDictionary:responseObject];
//        NSArray *dataList = model.ldata;
//        if (dataList.count> 0) {
//            [self.dataArray removeAllObjects];
//            [self.dataArray addObjectsFromArray:dataList];
//            [self.queryArray removeAllObjects];
//            [self.tableView reloadData];
//            [self startTimer];
//            self.hasAccessSocket = YES;
//        }else{
//            [MBProgressHUD showErrorMessage:@"暂无数据"];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"返回错误：%@",error);
//    }];
//    [task resume];
    
    
    
    
}
//开启定时器轮询
-(void)startTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:HTTP_REQUEST_TIME target:self selector:@selector(httpRepeatRuquest) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
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
    NSDictionary *alwaysInDict = @{@"code":@"main",@"name":@"主力合约"};
    NSArray *selectPlateArray = [kUserDefaults objectForKey:PLATE_SETTING_DICT];
    NSMutableArray *selectArray = [NSMutableArray array];
    [selectArray addObject:alwaysInDict];
    [selectArray addObjectsFromArray:selectPlateArray];
    if (self.pullDownMenuView == nil) {
        PullDownMenuView *pullDownMenuView = [[PullDownMenuView alloc] initWithFrame:CGRectMake(1, 0, KScreenWidth, [PullDownMenuView heightOfMenuView:selectArray]) dataArray:selectArray];
        pullDownMenuView.menuCellTapBlock = ^(NSDictionary * _Nonnull dict) {
            NSLog(@"%@",dict[@"code"]);
            [self.arrowBtn setTitle:dict[@"name"] forState:UIControlStateNormal];
            [self.arrowBtn sizeToFit];
            [self hideMenuView];
            User_Reqqryinstrument *request = [[User_Reqqryinstrument alloc] init];
            [request setExchangeID:dict[@"code"]];
            [[SocketRequestManager shareInstance] qryInstrument:request];
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
                            if (self.isOption) {
                                [self.tableView deleteRowsAtIndexPaths:@[self.currentIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                            }else{
                                model.hasCollect = !model.hasCollect;
                                [self.tableView reloadRowsAtIndexPaths:@[self.currentIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//                                [self disAppearOpView];
                            }
                        }else{
                            NSLog(@"删除数据失败--");
                        }
                        
                    }else{
                        CollectQuatationDBModel *dbModel = [[CollectQuatationDBModel alloc] init];
                        dbModel.instrumentID = model.stockCodeInternal;
                        dbModel.instrumentName = model.stockName;
                        if ([[AMSDBManager shareInstance] addQuotations:dbModel]) {
                            [MBProgressHUD showSuccessMessage:[NSString stringWithFormat:@"%@已加入自选",model.stockName]];
                            model.hasCollect = !model.hasCollect;
                            [self.tableView reloadRowsAtIndexPaths:@[self.currentIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                            
                        }else{
                            NSLog(@"添加数据失败--");
                        }
                    }
                
                    [self disAppearOpView];
                   
                }];
                
                [self.menuView.goTradeBtn zj_addBtnActionHandler:^{
                    AMSLdatum *model = self.dataArray[self.currentIndexPath.row];
//                    [MBProgressHUD showTipMessageInView:[NSString stringWithFormat:@"点击去交易按钮%@",model.stockName]];
                    MarketDetailViewController *detailViewVC = [[MarketDetailViewController alloc] init];
                    detailViewVC.model = self.dataArray[indexPath.row];
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
                AMSLdatum *model = self.dataArray[self.currentIndexPath.row];
                model.hasCollect = [[AMSDBManager shareInstance] isQuotationCollected:model.stockCodeInternal];
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
        [self fetchData:self.isOption];
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
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
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
