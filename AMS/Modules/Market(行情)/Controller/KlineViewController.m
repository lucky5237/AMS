//
//  KlineViewController.m
//  AMS
//
//  Created by jianlu on 2018/11/20.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "KlineViewController.h"
#import "ChartBottomView.h"
#import "Y_KLineView.h"
#import "NetWorking.h"
#import "Y_KLineGroupModel.h"
#import "KLineSelectCycleView.h"
#import <RDVTabBarController.h>
#import "KLineLongTapParamView.h"
#import "UIColor+Y_StockChart.h"
#import "Y_StockChartGlobalVariable.h"
#import "QryKLineResponseModel.h"
#import "InstumentModel.h"
#define kMinimumPanDistance [Y_StockChartGlobalVariable kLineWidth] + [Y_StockChartGlobalVariable kLineGap]
@interface KlineViewController ()<Y_KlineEventDelegete,UIGestureRecognizerDelegate>
@property(nonatomic,strong) ChartBottomView *chartBottomView;
@property(nonatomic,strong) Y_KLineView *kLineView;
@property(nonatomic,strong) Y_KLineGroupModel *groupModel;
@property(nonatomic,strong) KLineSelectCycleView *selectCycleView;
@property(nonatomic,copy) NSArray *selectCycleViewItemsArray;
@property(nonatomic,strong)UIBarButtonItem* timeBarButton;
@property(nonatomic,strong)UIBarButtonItem* leftTimeLabelBarButton;
@property(nonatomic,strong) KLineLongTapParamView* paramView;
@property(nonatomic,strong) UIView *horizontalView;
@property(nonatomic,strong) UIView *verticalView;
@property(nonatomic,assign) Y_StockChartTargetLineStatus status;
@property(nonatomic,assign) BOOL isFirstLoad;
@property(nonatomic,assign) BOOL isAnimation;
@property(nonatomic,assign) CGPoint lastRecognizedInterval;
@property(nonatomic,strong) Y_KLineModel *selectedModel;
@end
#define Bottom_Height 100
//#define Param_View_Y (s)
#define Origin_left_frame CGRectMake(-PARAMVIEW_WIDTH,CGRectGetMinY(self.kLineView.kLineMainView.frame) + 10, PARAMVIEW_WIDTH,KLINE_PARAMVIEW_HEIGHT)
#define Show_left_frame CGRectMake(0, CGRectGetMinY(self.kLineView.kLineMainView.frame) + 10, PARAMVIEW_WIDTH, KLINE_PARAMVIEW_HEIGHT)

#define Origin_right_frame CGRectMake(KScreenWidth, CGRectGetMinY(self.kLineView.kLineMainView.frame) + 10, PARAMVIEW_WIDTH, KLINE_PARAMVIEW_HEIGHT);

#define Show_right_frame CGRectMake(KScreenWidth - PARAMVIEW_WIDTH, CGRectGetMinY(self.kLineView.kLineMainView.frame) + 10, PARAMVIEW_WIDTH, KLINE_PARAMVIEW_HEIGHT);
@implementation KlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加底部view
    [self.view addSubview:self.chartBottomView];
    [self.chartBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(Bottom_Height);
    }];
    [self.view addSubview:self.kLineView];
    [self.kLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.chartBottomView.mas_top);
    }];
    //1-1min 2-5min 3-15min
    self.selectCycleViewItemsArray = @[@{@"name":@"1m",@"id":@1},@{@"name":@"3m",@"id":@2},@{@"name":@"5m",@"id":@2},@{@"name":@"10m",@"id":@4},@{@"name":@"15m",@"id":@3},@{@"name":@"30m",@"id":@6},@{@"name":@"1h",@"id":@7},@{@"name":@"2h",@"id":@8},@{@"name":@"3h",@"id":@9},@{@"name":@"4h",@"id":@10},@{@"name":@"1day",@"id":@11},@{@"name":@"1week",@"id":@12},@{@"name":@"1month",@"id":@13}];
    self.isFirstLoad = YES;
    [self fetchData:@"sc1903" type:1];
    // Do any additional setup after loading the view.
}

#pragma mark 懒加载
-(ChartBottomView *)chartBottomView{
    if(!_chartBottomView){
        _chartBottomView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ChartBottomView class]) owner:nil options:nil]lastObject];
    }
    return _chartBottomView;
}
-(Y_KLineView *)kLineView{
    if (!_kLineView) {
        _kLineView = [[Y_KLineView alloc] init];
        _kLineView.MainViewType = Y_StockChartcenterViewTypeKline;
        _kLineView.delegate = self;
        UIPanGestureRecognizer *panPressGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(event_panMethod:)];
        panPressGesture.delegate = self;
        [_kLineView addGestureRecognizer:panPressGesture];
        
    }
    return _kLineView;
}

- (void)fetchData:(NSString *)symbol type:(NSInteger)type{
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    param[@"type"] =  type;
//    param[@"market"] = @"btc_usdt";
//    param[@"size"] = @"1000";
//    [NetWorking request:@"http://stock2.finance.sina.com.cn/futures/api/json.php/IndexService.getInnerFuturesDailyKLine?symbol=M0" param:nil thenSuccess:^(NSArray *responseObject) {
//
//            Y_KLineGroupModel *groupModel = [Y_KLineGroupModel objectWithArray:responseObject type:Y_StockChartcenterViewTypeKline];
//            self.groupModel = groupModel;
//            [self.kLineView setKLineModels:groupModel.models];
//            if (self.isFirstLoad) {
//                self.kLineView.scrollView.targetLineStatus = Y_StockChartTargetLineStatusMACD;
//                self.kLineView.targetLineStatus = Y_StockChartTargetLineStatusMACD;
//                self.isFirstLoad = false;
//            }
//
//
//    } fail:^{
//        NSLog(@"fail");
//    }];
    NSDictionary *dict = @{@"symbol":symbol,@"type":@(type)};
    [NetWorking requestWithApi:[NSString stringWithFormat:@"%@%@",BaseUrl,QryKLine_URL] reqeustType:POST_Type param:dict thenSuccess:^(NSDictionary *responseObject) {
        QryKLineResponseModel *model = [QryKLineResponseModel yy_modelWithDictionary:responseObject];
        NSArray<AMSList *> *dataList = model.mdata.list;
        if (dataList.count> 0) {

            Y_KLineGroupModel *groupModel = [Y_KLineGroupModel objectWithArray:dataList type:Y_StockChartcenterViewTypeKline];
            [self.kLineView setKLineModels:groupModel.models];
            if (self.isFirstLoad) {
                self.kLineView.scrollView.targetLineStatus = Y_StockChartTargetLineStatusMACD;
                self.kLineView.targetLineStatus = Y_StockChartTargetLineStatusMACD;
                self.isFirstLoad = false;
            }
        }else{
           [MBProgressHUD showErrorMessage:@"暂无数据"];
        }
        
    } fail:^(NSString *str) {
        
    }];
}

-(UIBarButtonItem*)timeBarButton{
    if (!_timeBarButton) {
        _timeBarButton = [[UIBarButtonItem alloc] initWithImage:kImageName(@"time") style:UIBarButtonItemStylePlain target:self action:@selector(timeClockBtnTapped:)];
    }
    return _timeBarButton;
}

-(UIBarButtonItem *)leftTimeLabelBarButton{
    if (!_leftTimeLabelBarButton) {
        _leftTimeLabelBarButton = [[UIBarButtonItem alloc] initWithTitle:@"1min" style:UIBarButtonItemStylePlain target:nil action:nil];
        [_leftTimeLabelBarButton setTitleTextAttributes:@{NSForegroundColorAttributeName:kWhiteColor,NSFontAttributeName:kFontSize(16)} forState:UIControlStateNormal];
    }
    return _leftTimeLabelBarButton;
}

-(void)didNeedUpdataParamInfo:(NSNotification*) noti{
//    if (_paramView && _paramView.type!=NoneType) {
//        Y_KLineModel* model = (Y_KLineModel*)noti.object;
////        NSLog(@"didNeedUpdataParamInfo------ %@",model.Date);
//        [self.paramView maProfileWithModel:model];
//    }
    self.selectedModel = (Y_KLineModel*)noti.object;
}

-(KLineSelectCycleView *)selectCycleView{
    if (!_selectCycleView) {
        _selectCycleView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([KLineSelectCycleView class]) owner:nil options:nil]lastObject];
        [_selectCycleView configData:self.selectCycleViewItemsArray];
        kWeakSelf(self);
        _selectCycleView.didSelectCycleViewItemBlock = ^(NSDictionary * _Nonnull dict) {
            kStrongSelf(self);
            NSLog(@"select -----%@",dict[@"name"]);
            [self.selectCycleView hide];
            [self.leftTimeLabelBarButton setTitle:dict[@"name"]];
            NSNumber *type = dict[@"id"];		
            [self fetchData:self.model.instrument.InstrumentID type:type.integerValue];
        };
    }
    return _selectCycleView;
}

-(KLineLongTapParamView *)paramView{
    if (!_paramView) {
        _paramView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([KLineLongTapParamView class]) owner:nil options:nil]lastObject];
        //        _paramView.frame = CGRectMake(-82, 24, 82, 290);
    }
    return _paramView;
}

-(UIView *)horizontalView{
    //初始化横线
    if(!_horizontalView){
        _horizontalView = [UIView new];
        [self.view addSubview:_horizontalView];
        self.horizontalView.backgroundColor = [UIColor longPressLineColor];
        [self.horizontalView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(-0.5);
            make.width.mas_equalTo(KScreenWidth);
            make.height.mas_equalTo(0.5);
            make.left.mas_equalTo(0);
        }];
    }
    return _horizontalView;
}

-(UIView *)verticalView{
    if(!_verticalView)
    {
        _verticalView = [[UIView alloc] init];
        [self.view addSubview:_verticalView];
        self.verticalView.backgroundColor = [UIColor longPressLineColor];
        [self.verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(MAIN_MAVIEW_HEADER);
            make.width.equalTo(@(Y_StockChartLongPressVerticalViewWidth));
            make.bottom.mas_equalTo(self.chartBottomView.mas_top).offset(-20);
            make.left.mas_equalTo(-10);
        }];
    }
    return _verticalView;
}

-(void)y_KlineViewDidtapEvent:(Y_KlineViewType)type{
    if (_paramView && _paramView.type!= NoneType) {
        [self hideParamView];
    }else{
        if (type == MainView) {
            if (self.kLineView.targetLineStatus == Y_StockChartTargetLineStatusMACD) {
                self.kLineView.scrollView.targetLineStatus = Y_StockChartTargetLineStatusMA;
                self.kLineView.targetLineStatus = Y_StockChartTargetLineStatusMA;
                
            }else if (self.kLineView.targetLineStatus == Y_StockChartTargetLineStatusMA){
                self.kLineView.scrollView.targetLineStatus = Y_StockChartTargetLineStatusBOLL;
                self.kLineView.targetLineStatus = Y_StockChartTargetLineStatusBOLL;
            }else if (self.kLineView.targetLineStatus == Y_StockChartTargetLineStatusBOLL){
                 self.kLineView.scrollView.targetLineStatus = Y_StockChartTargetLineStatusMACD;
                self.kLineView.targetLineStatus = Y_StockChartTargetLineStatusMACD;
            }
        }
    }
    
    //        else if(type == AccessoryView){
    //            if (self.kLineView.targetLineStatus == Y_StockChartTargetLineStatusMACD) {
    //                self.kLineView.targetLineStatus = Y_StockChartTargetLineStatusKDJ;
    //            }else if (self.kLineView.targetLineStatus == Y_StockChartTargetLineStatusKDJ){
    //                self.kLineView.targetLineStatus = Y_StockChartTargetLineStatusMACD;
    //            }
    //        }
}

-(void)event_panMethod:(UIPanGestureRecognizer *)panGesture{
    
    if (self.paramView.type != NoneType) {
        CGPoint thisInterval = [panGesture translationInView:self.view];
        CGPoint location = [panGesture locationInView:self.view];
        //更新竖线位置
        CGFloat rightXPosition = location.x;
        CGFloat yValue = 0.f;
        
        if (location.y >= CGRectGetMinY(self.kLineView.kLineMainView.frame) && location.y <= CGRectGetMaxY(self.kLineView.kLineMainView.frame)) {
            yValue = [self.kLineView.kLineMainView getYValue:location.y];
        }else if (location.y >= CGRectGetMinY(self.kLineView.kLineVolumeView.frame) && location.y <= CGRectGetMaxY(self.kLineView.kLineVolumeView.frame) ){
            yValue = [self.kLineView.kLineVolumeView getYValue:location.y];
        }else if (location.y >= CGRectGetMinY(self.kLineView.kLineAccessoryView.frame) && location.y <= CGRectGetMaxY(self.kLineView.kLineAccessoryView.frame) ){
            yValue = [self.kLineView.kLineAccessoryView getYValue:location.y];
        }
        
        CGFloat realX = [self.kLineView.kLineMainView getExactXPositionWithOriginXPosition:CGPointMake(location.x + self.kLineView.scrollView.contentOffset.x, yValue)];
        
        [self.horizontalView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(location.y);
        }];
        
        self.verticalView.hidden = NO;
        
        self.horizontalView.hidden = NO;
        
        if (fabs(_lastRecognizedInterval.x - thisInterval.x) < kMinimumPanDistance) {
            return;
        }
        //        CGFloat distance = thisInterval.x - self.lastRecognizedInterval.x > 0 ? kMinimumPanDistance : -kMinimumPanDistance;
        
        [self.verticalView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(realX);
            if (self.kLineView.targetLineStatus == Y_StockChartTargetLineStatusMA || self.kLineView.targetLineStatus == Y_StockChartTargetLineStatusBOLL) {
                 make.top.mas_equalTo(36);
            }else{
                make.top.mas_equalTo(11);
            }
        }];
        
        _lastRecognizedInterval = thisInterval;
        //        CGPoint transition = [panGesture translationInView:self.view];
        //
        [self configParamAnimation:self.kLineView.scrollView.contentOffset.x+ rightXPosition data:self.kLineView.kLineModels.lastObject];
    }else{
        self.kLineView.scrollView.scrollEnabled = YES;
    }
}

-(void)y_klineDidReachEdges:(CGPoint)location data:(Y_KLineModel *)model realX:(CGFloat)x{
    //更新竖线位置
//     CGFloat realX = [self.kLineView.kLineMainView getExactXPositionWithOriginXPosition:location];
    [self.verticalView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(x);
        if (self.kLineView.targetLineStatus == Y_StockChartTargetLineStatusMA || self.kLineView.targetLineStatus == Y_StockChartTargetLineStatusBOLL) {
            make.top.mas_equalTo(36);
        }else{
            make.top.mas_equalTo(11);
        }
    }];
    [self.horizontalView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(location.y);
    }];
//            [self.verticalView layoutIfNeeded];
    self.verticalView.hidden = NO;
//            [self.horizontalView layoutIfNeeded];
    self.horizontalView.hidden = NO;
    
    [self configParamAnimation:location.x data:model];
    
}

-(void)configParamAnimation:(CGFloat)rightXPosition data:(Y_KLineModel *)model{
    
    if (!_paramView) {
        _paramView = [KLineLongTapParamView kLineLongTapParamView];
        
        [self.view addSubview:_paramView];
        if ([self touchInsideLeftArea:rightXPosition]) {
            [self showFromRightEdge];
        }else{
            [self showFromLeftEdge];
        }
        //        self.paramView.hidden = false;
    }else{
        if (!_isAnimation){
            if ([self touchInsideLeftArea:rightXPosition]) {
                if (self.paramView.type == LeftType) {
                    [self hideLeftAndShowRight];
                }else if (self.paramView.type == NoneType){
                    [self showFromRightEdge];
                }
            }else if ([self touchInsideRightArea:rightXPosition]) {
                if (self.paramView.type == RightType) {
                    [self hideRightAndShowLeft];
                }else if (self.paramView.type == NoneType){
                    [self showFromLeftEdge];
                }
            }else{
                if (self.paramView.type == NoneType) {
                    [self showFromLeftEdge];
                }
            }
        }
    }
    if (self.selectedModel) {
       [self.paramView maProfileWithModel:self.selectedModel];
    }
    self.paramView.hidden = false;
}

-(BOOL)touchInsideLeftArea:(CGFloat)positionX{
    return self.kLineView.scrollView.contentOffset.x  - positionX +  PARAMVIEW_WIDTH >= 0;
}
-(BOOL)touchInsideRightArea:(CGFloat)positionX{
    return self.kLineView.scrollView.contentOffset.x + KScreenWidth - positionX <= PARAMVIEW_WIDTH;
}



-(void)showFromLeftEdge{
    self.isAnimation = YES;
    self.paramView.hidden = false;
    self.paramView.alpha = 0;
    self.paramView.frame = Origin_left_frame;
    [UIView animateWithDuration:ANIMATION_TIME animations:^{
        self.paramView.frame = Show_left_frame;
        self.paramView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            self.isAnimation = NO;
            self.paramView.type = LeftType;
        }
    }];
}

-(void)showFromRightEdge{
    self.isAnimation = YES;
    self.paramView.hidden = false;
    self.paramView.alpha = 0;
    self.paramView.frame = Origin_right_frame;
    [UIView animateWithDuration:ANIMATION_TIME animations:^{
        self.paramView.frame = Show_right_frame;
        self.paramView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            self.paramView.type = RightType;
            self.isAnimation = NO;
        }
    }];
}

-(void)hideToLeftEdge{
    self.isAnimation = YES;
    [UIView animateWithDuration:ANIMATION_TIME animations:^{
        self.paramView.frame = Origin_left_frame;
        self.paramView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            self.paramView.type = NoneType;
            self.paramView.hidden = YES;
            self.isAnimation = NO;
        }
    }];
}

-(void)hideToRightEdge{
    self.isAnimation = YES;
    [UIView animateWithDuration:ANIMATION_TIME animations:^{
        self.paramView.frame = Origin_right_frame;
        self.paramView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            self.isAnimation = NO;
            self.paramView.type = NoneType;
            self.paramView.hidden = YES;
        }
    }];
}

-(void)hideRightAndShowLeft{
    self.isAnimation = YES;
    [UIView animateWithDuration:ANIMATION_TIME animations:^{
        self.paramView.frame = Origin_right_frame;
        self.paramView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            self.paramView.frame = Origin_left_frame;
            [UIView animateWithDuration:ANIMATION_TIME animations:^{
                self.paramView.frame = Show_left_frame;
                self.paramView.alpha = 1;
            } completion:^(BOOL finished) {
                if (finished) {
                    self.isAnimation = NO;
                    self.paramView.type = LeftType;
                }
            }];
        }
    }];
}

-(void)hideLeftAndShowRight{
    self.isAnimation = YES;
    [UIView animateWithDuration:ANIMATION_TIME animations:^{
        self.paramView.frame = Origin_left_frame;
        self.paramView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            self.paramView.frame = Origin_right_frame;
            [UIView animateWithDuration:ANIMATION_TIME animations:^{
                self.paramView.frame = Show_right_frame;
                self.paramView.alpha = 1;
            } completion:^(BOOL finished) {
                if (finished) {
                    self.paramView.type = RightType;
                    self.isAnimation = NO;
                }
            }];
        }
    }];
}

-(void)hideParamView{
    //取消竖线
    if(self.verticalView)
    {
        self.verticalView.hidden = YES;
    }
    if(self.horizontalView)
    {
        self.horizontalView.hidden = YES;
    }
    if (self.paramView) {
        if (self.paramView.type == LeftType) {
            [self hideToLeftEdge];
        }
        if (self.paramView.type == RightType) {
            [self hideToRightEdge];
        }
    }
    self.kLineView.scrollView.scrollEnabled = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kYellowTextColor,NSFontAttributeName:kFontSize(18)}];
    [self.rdv_tabBarController.navigationItem setRightBarButtonItems:@[self.menuBtnItem,self.timeBarButton,]];
    self.rdv_tabBarController.navigationItem.leftItemsSupplementBackButton = true;
    self.rdv_tabBarController.navigationItem.leftBarButtonItem = self.leftTimeLabelBarButton;
    [kNotificationCenter addObserver:self selector:@selector(didNeedUpdataParamInfo:) name:kNotification_Name_Param_Update object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kWhiteColor,NSFontAttributeName:kFontSize(18)}];
    [self.rdv_tabBarController.navigationItem setRightBarButtonItem:self.menuBtnItem];
    self.rdv_tabBarController.navigationItem.leftBarButtonItem = nil;
    [kNotificationCenter removeObserver:self];
}

-(void)timeClockBtnTapped:(UIBarButtonItem *)clockBtn{
    [self.selectCycleView show];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (!_paramView) {
        return false;
    }else{
        return _paramView.type!=NoneType;
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
