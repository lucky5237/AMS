//
//  TradeViewController.m
//  AMS
//
//  Created by jianlu on 2018/11/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "TradeViewController.h"
#import "TradeHeaderView.h"
#import "LMReport.h"
#import "TradeCellMenuView.h"
#import "PriceCustomKeyboardView.h"
#import <RDVTabBarController.h>
#import "SearchViewController.h"
#import "UIView+AZGradient.h"
#import <JDStatusBarNotification.h>
#import "CustomStatusBarView.h"
#import "LrReportContainerView.h"
#import "QryQuotationResponseModel.h"
#import "User_Reqorderinsert.h"
#import "User_Onrspquoteinsert.h"
#import "SocketRequestManager.h"
#import "QryQuotationRequestModel.h"
#import "best_sdk_define.h"
#import "User_Reqqrytradingaccount.h"
#import "User_Onrspqrytradingaccount.h"
#import "User_Reqqryinvestorposition.h"
#import "User_Onrspqryinvestorposition.h"
#import "User_Reqqrytrade.h"
#import "User_Onrspqrytrade.h"
#import "User_Reqqrytradingaccount.h"
#import "User_Onrspqrytradingaccount.h"
#import "InstumentModel.h"
#import "User_Reqqryinstrument.h"
#import "MainViewController.h"
#import "User_Onrtnorder.h"

@interface TradeViewController ()<LrReportContainerViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong) TradeHeaderView *headerView;
@property(nonatomic,strong) UISegmentedControl *segmentedControl;
@property(nonatomic,strong) NSArray *itemArray;
@property(nonatomic,strong) NSArray *headerTitleArray;
//@property(nonatomic,strong) LMReportView *reportView;
@property(nonatomic,strong) TradeCellMenuView *menuView;
@property(nonatomic,strong) NSIndexPath *currentSelectIndexPath;
@property(nonatomic,strong) PriceCustomKeyboardView *keyboardView;
@property(nonatomic,strong) NSDecimalNumber *minChangePrice;
@property(nonatomic,strong) NSMutableArray *tableArray;//表格列表
@property(nonatomic,assign) BOOL isLock;//是否锁定价格
@property(nonatomic,strong) UIImageView *underLineView;
@property(nonatomic,strong) CustomStatusBarView *statusBar;
@property(nonatomic,strong) LrReportContainerView *containerView;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,strong) AMSLdatum *currentData;
@property(nonatomic,strong) User_Onrspqrytradingaccount *currentAccountInfo;
@property(nonatomic,copy) NSArray *chicangArray;
@property(nonatomic,copy) NSArray *guaDanArray;
@property(nonatomic,copy) NSArray *weituoArray;
@property(nonatomic,copy) NSArray *chengjiaoArray;
@end

#define Header_Height  210
#define SegmentedControl_Height 44

@implementation TradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [kUserDefaults objectForKey:UserDefaults_User_ID_key];
    self.itemArray = @[@"持仓",@"挂单",@"委托",@"成交"];
    self.headerTitleArray = @[@[@"合约名称",@"多空",@"总仓",@"可用",@"开仓均价",@"逐笔浮盈"],@[@"合约名称",@"开平",@"委托价",@"委托量",@"挂单量"],@[@"合约名称",@"状态",@"开平",@"委托价",@"委托量",@"已成交",@"已撤单",@"委托时间"],@[@"合约名称",@"开平",@"成交价",@"成交量",@"成交时间"]];
    [self.view addSubview:self.headerView];
    _headerView.frame = CGRectMake(0, 1, KScreenWidth,500);
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(1);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth, Header_Height));
    }];
    [self.view addSubview:self.segmentedControl];
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(1);
        make.top.mas_equalTo(self.headerView.mas_bottom).offset(1);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth, SegmentedControl_Height));
    }];
    [self.view addSubview:self.underLineView];
    [self.underLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KScreenWidth/(self.itemArray.count * 2) -14/2);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(2);
        make.bottom.mas_equalTo(self.segmentedControl.mas_bottom);
    }];
//    [self.view addSubview:self.reportView];
//
////    [self.reportView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.top.mas_equalTo(self.segmentedControl.mas_bottom);
////        make.left.mas_offset(0);
////        make.right.mas_equalTo(0);
////        make.bottom.mas_equalTo(self.view);
////    }];
    //    [self.reportView reloadData];
    [self.view addSubview:self.containerView];
    [self.view setNeedsLayout];
//    MainViewController *rootVC = (MainViewController *)kAppWindow.rootViewController;
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segmentedControl.mas_bottom).offset(1);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(KScreenWidth);
        make.bottom.mas_equalTo(-120);
    }];
    [self.view layoutIfNeeded];
    if(self.model != nil){
       [self requestNewestPriceInfo:self.keyboardView.isUsingSystemPrice];
    }
//    [self startTimer];
    [self queryAccountInfo];
//    [self queryChicang];
    self.containerView.currentSelectIndex = ChiChangType;
  
    
    if(self.model != nil){
        self.headerView.nameTf.text = self.model.instrument.InstrumentName;
    }
    
    [self.headerView.priceTf.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        if (!self.keyboardView.isUsingSystemPrice) {
            self.headerView.buyMoreLabel.text = x;
            self.headerView.saleEmptyLabel.text = x;
            self.headerView.eveningUpLabel.text = x;
        }
    }];
  
    
   
}
//查资金
-(void)queryAccountInfo{
    User_Reqqrytradingaccount *request = [[User_Reqqrytradingaccount alloc] init];
    request.BrokerID = @"9999";
    request.InvestorID = [kUserDefaults objectForKey:UserDefaults_User_ID_key];
    [[SocketRequestManager shareInstance] reqqrytradingaccount:request];
}

-(void)startTimer{
    if (self.timer == nil && self.model != nil) {
        kWeakSelf(self);
        self.timer = [NSTimer timerWithTimeInterval:HTTP_REQUEST_TIME repeats:YES block:^(NSTimer * _Nonnull timer) {
            //                NSLog(@"http 轮询");
            kStrongSelf(self);
            [self requestNewestPriceInfo:self.keyboardView.isUsingSystemPrice];
        }];
        NSRunLoop *runloop=[NSRunLoop currentRunLoop];
        [runloop addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
}

-(void)initButtonConfig{
    NSArray* chicangArray = kAppDelegate.chicangOrderArray;
    if (chicangArray.count == 0) {
        self.headerView.buyMoreDesLabel.text = @"买多";
        self.headerView.saleEmptyDesLabel.text  = @"卖空";
        self.headerView.eveningUpDescLabel.text = @"平仓";
    }else{
        [self.chicangArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            User_Onrspqryinvestorposition *model = obj;
            if ([model.InstrumentID isEqualToString:self.model.instrument.InstrumentID]) {
//                if()
            }
        }];
    }
}

-(void)fetchReportViewData:(NSInteger)index{

    //查询持仓
    if (index == 0) {
//        User_Reqqryinvestorposition *request = [[User_Reqqryinvestorposition alloc] init];
//        request.BrokerID = @"9999";
//        request.InvestorID = [kUserDefaults objectForKey:UserDefaults_User_ID_key];
//        [[SocketRequestManager shareInstance]  reqqryinvestorposition:request];
//        User_Onrspqryinvestorposition *response = [[User_Onrspqryinvestorposition alloc] init];
//        response.InstrumentID = self.model.stockCodeInternal;
//        response.PosiDirection = @"1";
//        response.Position = @1;
//        response.ShortFrozen = @0;
//        response.LongFrozen = @0;
//
//        User_Onrspqryinvestorposition *response1 = [[User_Onrspqryinvestorposition alloc] init];
//        response1.InstrumentID = self.model.stockCodeInternal;
//        response1.PosiDirection = @"2";
//        response1.Position = @3;
//        response1.ShortFrozen = @1;
//        response1.LongFrozen = @0;
//
//        User_Onrspqryinvestorposition *response2 = [[User_Onrspqryinvestorposition alloc] init];
//        response2.InstrumentID = self.model.stockCodeInternal;
//        response2.PosiDirection = @"1";
//        response2.Position = @4;
//        response2.ShortFrozen = @0;
//        response2.LongFrozen = @1;
        
//        self.chicangArray = @[response,response1,response2];
        [self.containerView dataArray:kAppDelegate.chicangOrderArray forIndex:ChiChangType];
        
    }else if (index == 3){
        //查询成交表
//        User_Reqqrytrade *request = [[User_Reqqrytrade alloc] init];
//        request.BrokerID = @"9999";
//        request.InvestorID = [kUserDefaults objectForKey:UserDefaults_User_ID_key];
//        request.InstrumentID = self.model.stockCodeInternal;
//        [[SocketRequestManager shareInstance]  reqqrytrade:request];
        [self.containerView dataArray:kAppDelegate.chengjiaoOrderArray forIndex:ChengjiaoType];
//        [self.containerView reloadData];
    }else if (index == 1){
        //查询挂单表
        [self.containerView dataArray:kAppDelegate.guadanOrderArray forIndex:GuaDanType];
//        [self.containerView reloadData];
    }else if (index == 2){
        //查询委托表
        [self.containerView dataArray:kAppDelegate.weituoOrderArray forIndex:WeiTuoType];
//        [self.containerView reloadData];
    }
    [self.containerView reloadData:index];
}

-(void)queryChicang{
    User_Reqqryinvestorposition *request = [[User_Reqqryinvestorposition alloc] init];
    request.BrokerID = @"9999";
    request.InstrumentID = self.model.instrument.InstrumentID;
    request.InvestorID = [kUserDefaults objectForKey:UserDefaults_User_ID_key];
    [[SocketRequestManager shareInstance] reqqryinvestorposition:request];
}
#pragma mark 懒加载

-(NSMutableArray *)tableArray{
    if (!_tableArray) {
        _tableArray = [NSMutableArray array];
    }
    return _tableArray;
}

-(UIImageView *)underLineView{
    if (!_underLineView) {
        _underLineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab下划线"]];
    }
    return _underLineView;
}


-(LrReportContainerView *)containerView{
    if (!_containerView) {
        _containerView = [[LrReportContainerView alloc] init];
        _containerView.titleItemArray = self.headerTitleArray;
//        _containerView.frame =CGRectMake(0,  Header_Height+SegmentedControl_Height+1, KScreenWidth, KScreenHeight - (Header_Height+SegmentedControl_Height+1+kTabBarHeight));
        kWeakSelf(self);
        _containerView.delegate = self;
        _containerView.lMReportViewDidScrollBlock = ^(UIScrollView *scrollView, BOOL isMainScrollView) {
            kStrongSelf(self);
            [self.headerView.priceTf resignFirstResponder];
            [self.headerView.numTf resignFirstResponder];
            [self disAppearOpView];
        };
    }
    return _containerView;
}

-(TradeHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TradeHeaderView class]) owner:nil options:nil]lastObject];
//        _headerView.frame = CGRectMake(0, 1, KScreenWidth,500);
        //点击买多
        kWeakSelf(self);
        [_headerView.buyMoreView zj_addTapGestureWithCallback:^(UITapGestureRecognizer *gesture) {
//            [MBProgressHUD showSuccessMessage:@"点击买多"];
//            [self.statusBar showMessage:@"点击买多了！！！" limitTime:3];
            User_Reqorderinsert *request = [[User_Reqorderinsert alloc] init];
            request.Direction = @"0";
            request.LimitPrice = self.headerView.buyMoreLabel.text;
            [self orderInsert:request];
        }];
        //点击卖空
        [_headerView.saleEmptyView zj_addTapGestureWithCallback:^(UITapGestureRecognizer *gesture) {
//            [MBProgressHUD showSuccessMessage:@"点击卖空"];
            User_Reqorderinsert *request = [[User_Reqorderinsert alloc] init];
            request.Direction = @"1";
            request.LimitPrice = self.headerView.saleEmptyLabel.text;
            [self orderInsert:request];
        }];
        //点击平仓
        [_headerView.eveningUpView zj_addTapGestureWithCallback:^(UITapGestureRecognizer *gesture) {
            User_Reqorderinsert *request = [[User_Reqorderinsert alloc] init];
//            request.Direction = @"1";
             [self orderInsert:request];
        }];
        
        [_headerView.lockBtn setZj_btnOnTouchUp:^(UIButton* sender) {
            kStrongSelf(self);
            [self disAppearOpView];
            [self.headerView.priceTf resignFirstResponder];
            [self.headerView.numTf resignFirstResponder];
            self.isLock = !self.isLock;
            sender.selected = self.isLock;
        }];
        _headerView.nameTf.delegate = self;
        _headerView.numTf.delegate = self;
        _headerView.priceTf.delegate = self;
        _headerView.numTf.keyboardType = UIKeyboardTypeNumberPad;
        _headerView.priceTf.inputView = self.keyboardView;
        _headerView.priceTf.inputAccessoryView = [[UIView alloc] initWithFrame:CGRectZero];
        [_headerView.priceTf reloadInputViews];
    }
    return _headerView;
}

#pragma mark 报单录入，下单
-(void)orderInsert:(User_Reqorderinsert *)model{
    if (self.model == nil || self.headerView.nameTf.text.length == 0) {
        [MBProgressHUD showErrorMessage:@"请先选择合约"];
        return ;
    }
    if (self.headerView.priceTf.text.length == 0) {
        [MBProgressHUD showErrorMessage:@"请先输入价格"];
        return ;
    }
    if (self.headerView.numTf.text.length == 0 || [self.headerView.numTf.text hasPrefix:@"0"] ) {
        [MBProgressHUD showErrorMessage:@"请输入合法手数"];
        return ;
    }
    
    UIAlertController *alertVC = [UIAlertController zj_alertControllerWithTitle:@"确认下单吗？" message:[NSString stringWithFormat:@"%@,%.2f,%@,%@手",self.model.instrument.InstrumentName,self.headerView.buyMoreLabel.text.doubleValue,[model.Direction isEqualToString:@"0"] ?@"买开":@"卖开",self.headerView.numTf.text]  optionStyle:OptionStyleStyleOK_Cancel OkTitle:@"下单" cancelTitle:@"取消" okBlock:^{
//        model.LimitPrice = self.headerView.priceTf.text;
        model.BrokerID = @"9999";
        model.TimeCondition = @"3";
        model.InvestorID = [kUserDefaults valueForKey:UserDefaults_User_ID_key];
        model.OrderPriceType = @"2";
        model.InstrumentID = self.model.instrument.InstrumentID;
        model.ExchangeID = self.model.instrument.ExchangeID;
        model.CombHedgeFlag = @"1";
        model.MinVolume = @1;
        model.CombOffsetFlag = model.Direction.length == 0 ? @"1" : @"0";
        model.VolumeTotalOriginal = @(self.headerView.numTf.text.integerValue);
        [[SocketRequestManager shareInstance] reqorderinsert:model];
    } cancelBlock:^{
        
    }];
    [self presentViewController:alertVC animated:YES completion:^{
    
    }];
    
  
}

-(PriceCustomKeyboardView *)keyboardView{
    if (!_keyboardView) {
        _keyboardView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([PriceCustomKeyboardView class]) owner:nil options:nil]lastObject];
        _keyboardView.frame = CGRectMake(0, 0, KScreenWidth,KEYBOARD_HEIGHT);
        kWeakSelf(self);
        _keyboardView.priceCustomKeyboardBtnTappedBlock = ^(CustomKeyBoardBtnType type) {
            kStrongSelf(self);
            [self handleKeyBoard:type textField:self.headerView.priceTf];
        };
    }
    return _keyboardView;
}

-(UISegmentedControl *)segmentedControl{
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:self.itemArray];
        [_segmentedControl addTarget:self action:@selector(changeTabIndex:) forControlEvents:UIControlEventValueChanged];
        [_segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:kFontSize(14)}forState:UIControlStateSelected];
        [_segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor zj_colorWithHexString:@"#B9B8CA" alpha:1],NSFontAttributeName:kFontSize(14)}forState:UIControlStateNormal];
        [_segmentedControl setDividerImage:[UIImage new] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [_segmentedControl setBackgroundImage:[AMSUtil imageWithColor:kCellBackGroundColor] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [_segmentedControl setBackgroundImage:[AMSUtil imageWithColor:kCellBackGroundColor] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        _segmentedControl.selectedSegmentIndex = 0;
       
       
    }
    return _segmentedControl;
}

-(TradeCellMenuView *)menuView{
    if (!_menuView) {
        _menuView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TradeCellMenuView class]) owner:nil options:nil]lastObject];
        kWeakSelf(self);
        _menuView.frame = CGRectMake(0, 0, KScreenWidth, 44);
        _menuView.tradeCellMenuClickBlock = ^(TradeCellMenuBtnType type) {
            kStrongSelf(self);
            [self TradeCellMenuBtnTapped:type];
        };
    }
    return _menuView;
}

-(CustomStatusBarView *)statusBar{
    if (!_statusBar) {
        _statusBar = [CustomStatusBarView sharedInstance];
    }
    return  _statusBar;
}
#pragma mark - 实例方法
-(void)TradeCellMenuBtnTapped:(TradeCellMenuBtnType)type{
    if (type == CloseBtn) {//平仓
        NSLog(@"点击了平仓");
        
    }else if(type == ReverseBtn){//反仓
       NSLog(@"点击了反仓");
    }else if (type == LockBtn){//锁单
        NSLog(@"点击了锁单");
    }
    [self disAppearOpView];
}

/**
 操作菜单消失调用
 */
-(void)disAppearOpView{
        if (self.menuView.isShowing) {
        if (self.menuView !=nil) {
            [self.menuView removeFromSuperview];
        }
        self.currentSelectIndexPath = nil;
        self.menuView.isShowing = false;
        [self.containerView reloadData];
    }
}


/**
 处理键盘点击事件

 @param type 键盘type
 */
-(void)handleKeyBoard:(CustomKeyBoardBtnType) type textField:(UITextField*)textField {
    if(type == Hide){
        [textField resignFirstResponder];
    }else if (type == PaiDui_Price){
        self.keyboardView.isUsingSystemPrice = YES;
        [textField setText:@"排队价"];
//        [textField resignFirstResponder];
        
    }else if (type == DuiShou_Price){
        self.keyboardView.isUsingSystemPrice = YES;
        [textField setText:@"对手价"];
//        [textField resignFirstResponder];
    }else if (type == Shi_Price){
        self.keyboardView.isUsingSystemPrice = YES;
        [textField setText:@"市价"];
//        [textField resignFirstResponder];
    }else if (type == New_Price){
        self.keyboardView.isUsingSystemPrice = YES;
        [textField setText:@"最新价"];
//        [textField resignFirstResponder];
    }else if (type == Super_Price){
        self.keyboardView.isUsingSystemPrice = YES;
        [textField setText:@"超价"];
//        [textField resignFirstResponder];
    }else if (type == Cancel){
        [textField setText:@""];
    }else if (type >= 0 && type <= 9){
        if (self.keyboardView.isUsingSystemPrice) {
            [textField setText:[NSString stringWithFormat:@"%ld",(long)type]];
            self.keyboardView.isUsingSystemPrice = false;
        }else{
            NSMutableString *str = [[NSMutableString alloc] initWithString:textField.text];
            [str appendFormat:@"%ld",(long)type];
            if ([AMSUtil isVaildMoney:str]) {
                [textField setText:str];
            }
        }
       
    }else if (type == Decimal){//小数点
        if (self.keyboardView.isUsingSystemPrice) {
            return;
        }
        NSMutableString *str = [[NSMutableString alloc] initWithString:textField.text];
        [str appendString:@"."];
        if ([AMSUtil isVaildMoney:str]) {
            [textField setText:str];
        }
    }else if (type == Add){
        if (textField.text.length == 0 || self.keyboardView.isUsingSystemPrice) {
            return;
        }
        //加法运算
       NSDecimalNumber *value  = [[NSDecimalNumber alloc] initWithString:textField.text];
        if (value != nil) {
            NSDecimalNumber *afterValue = [value decimalNumberByAdding:self.minChangePrice];
            if ([AMSUtil isVaildMoney:afterValue.stringValue]) {
                [textField setText:afterValue.stringValue];
            }
        }
       
    }else if (type == Minus){
        if (textField.text.length == 0 || self.keyboardView.isUsingSystemPrice) {
            return;
        }
        //减法运算
        NSDecimalNumber *value  = [[NSDecimalNumber alloc] initWithString:textField.text];
        if (value != nil) {
            NSDecimalNumber *afterValue = [value decimalNumberBySubtracting:self.minChangePrice];
            if ([AMSUtil isVaildMoney:afterValue.stringValue]) {
                [textField setText:afterValue.stringValue];
            }
        }
    }
    //点击上方价格
    if (self.keyboardView.isUsingSystemPrice) {
        if (type == PaiDui_Price) {
            self.headerView.buyMoreLabel.text = self.currentData.buyPrice1;
            self.headerView.saleEmptyLabel.text = self.currentData.salePrice1;
        }else if (type == DuiShou_Price){
            self.headerView.buyMoreLabel.text = self.currentData.salePrice1;
            self.headerView.saleEmptyLabel.text = self.currentData.buyPrice1;
        }else if (type == Shi_Price){
            self.headerView.buyMoreLabel.text = self.currentData.highPrice;
            self.headerView.saleEmptyLabel.text = self.currentData.downPrice;
        }else if (type == New_Price){
            self.headerView.buyMoreLabel.text = self.currentData.latestPrice;
            self.headerView.saleEmptyLabel.text = self.currentData.latestPrice;
        }else if (type == Super_Price){
            NSDecimalNumber *highPrice = [[NSDecimalNumber alloc] initWithString:self.currentData.highPrice];
            NSDecimalNumber *dowmPrice = [[NSDecimalNumber alloc] initWithString:self.currentData.downPrice];
            self.headerView.buyMoreLabel.text = [highPrice decimalNumberByAdding:self.minChangePrice].stringValue;
            self.headerView.saleEmptyLabel.text = [dowmPrice decimalNumberBySubtracting:self.minChangePrice].stringValue;
        }
    }
}

//改变UISegmentedControl index
-(void)changeTabIndex:(UISegmentedControl *)control{
    [self disAppearOpView];
    [self.underLineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((KScreenWidth/(self.itemArray.count * 2)) * (2*control.selectedSegmentIndex +1) - 14/2);
    }];
//    self.reportView.frame = CGRectMake(0,Header_Height+SegmentedControl_Height, KScreenWidth, KScreenHeight - ( +Header_Height+SegmentedControl_Height));
//    [self.reportView reloadData];
    self.containerView.currentSelectIndex = control.selectedSegmentIndex;
    [self fetchReportViewData:control.selectedSegmentIndex];
}
    

#pragma mark 代理回调事件

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self disAppearOpView];
    [self.headerView.priceTf resignFirstResponder];
    [self.headerView.numTf resignFirstResponder];
    [super touchesBegan:touches withEvent:event];
}


#pragma mark textfield 代理
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self disAppearOpView];
    if (textField == self.headerView.nameTf) {
//        NSLog(@"跳转搜索页");
        SearchViewController *searchVC = [[SearchViewController alloc] init];
        searchVC.hideRightButton = YES;
        searchVC.didSelectItemBlock = ^(InstrumentDBModel  *model) {
            if(model!=nil){
                self.headerView.nameTf.text = model.instrumentName;
                self.model = [[InstumentModel alloc] initWithInstumentDBModel:model];
//                if(self.model != nil){
                [self requestNewestPriceInfo:self.keyboardView.isUsingSystemPrice];
//                }
//                [self startTimer];
//                [self queryAccountInfo];
            }
            
//            self.title = dict[@"name"];
//            AMSLdatum *data  = [AMSLdatum yy_modelWithDictionary:dict];
//            [MBProgressHUD showInfoMessage:[NSString stringWithFormat:@"选择了%@",data.stockName]];
        };
        [self.navigationController pushViewController:searchVC animated:YES];
        return NO;
    }else{
        if (self.isLock || self.model == nil) {
            return NO;
        }
//        //获取最小变动价之类
//        self.minChangePrice = [[NSDecimalNumber alloc] initWithDouble:0.2];
//        if (textField == self.headerView.priceTf) {
//            [self.keyboardView configTopHintMsg:0.2 riseStopPrice:3492.4 fallStopPrice:2857.6];
//        }
        return YES;
    }
}


#pragma mark - <LMReportViewDatasource>


-(void)reportView:(LMReportView *)reportView didLongPressLabel:(LMRLabel *)label{
//    NSLog(@"长按了---");
    [self.headerView.priceTf resignFirstResponder];
    [self.headerView.numTf resignFirstResponder];
    NSIndexPath *indexPath = label.indexPath;
    //表头不处理
    if (indexPath == nil || indexPath.row == 0) {
        return;
    }else{
        self.currentSelectIndexPath = indexPath;
        NSLog(@"frame is %@",NSStringFromCGRect(label.frame));
        [self.containerView.currentReportView addSubview:self.menuView];
         self.menuView.frame = CGRectMake(0, CGRectGetMaxY(label.frame)  - self.containerView.currentReportView.contentOffSet, KScreenWidth, 45);
        self.menuView.alpha = 0.f;
        	[UIView animateWithDuration:0.2 animations:^{
              
                if (CGRectGetMaxY(label.frame) + 41  - self.containerView.currentReportView.contentOffSet >=self.containerView.bounds.size.height) {
                    NSLog(@"超出屏幕");
                    self.menuView.frame = CGRectMake(0, CGRectGetMaxY(label.frame) - self.containerView.currentReportView.contentOffSet - 4, KScreenWidth, 45);
                }else{
                      self.menuView.frame = CGRectMake(0, CGRectGetMaxY(label.frame) + 41  - self.containerView.currentReportView.contentOffSet, KScreenWidth, 45);
                }
//            self.menuView.frame = CGRectMake(0, CGRectGetMaxY(label.frame) + 41  - self.containerView.currentReportView.contentOffSet, KScreenWidth, 45);
            [self.containerView.currentReportView addSubview:self.menuView];
            self.menuView.isShowing = YES;
            self.menuView.alpha = 1;
        }];
       
        [self.containerView reloadData];
        [self.containerView bringSubviewToFront:self.menuView];
    }
    
}

-(void)reportView:(LMReportView *)reportView didTapLabel:(LMRLabel *)label{
    [self.headerView.priceTf resignFirstResponder];
    [self.headerView.numTf resignFirstResponder];
    if (self.menuView.isShowing) {
        [self disAppearOpView];
    }else{
        NSLog(@"点击了%@",label.text);
    }
}

//http轮询最新的价格
-(void)requestNewestPriceInfo:(BOOL)needChangePrice{
    QryQuotationRequestModel *requestModel = [[QryQuotationRequestModel alloc] init];
    QryQuotationRequestSubModel *subModel = [[QryQuotationRequestSubModel alloc] init];
    subModel.stockCodeInternal = self.model.instrument.InstrumentID;
    requestModel.stockTradeMins = @[subModel];
        NSString *str =  [requestModel.stockTradeMins.mutableCopy yy_modelToJSONString];
        NSDictionary *dict = @{@"stockTradeMins":str};

        [NetWorking requestWithApi:[NSString stringWithFormat:@"%@%@",BaseUrl,QryQuotation_URL] reqeustType:POST_Type param:dict thenSuccess:^(NSDictionary *responseObject) {
            QryQuotationResponseModel *model = [QryQuotationResponseModel yy_modelWithDictionary:responseObject];
            NSArray *dataList = model.ldata;
            if (dataList.count> 0) {
                self.currentData = (AMSLdatum*)dataList.firstObject;
                [self.headerView configPriceData:self.currentData keyBoardType:self.keyboardView.type];
                [self.keyboardView configTopHintMsg:self.currentData.priceChangeRate.doubleValue riseStopPrice:self.currentData.highPrice.doubleValue fallStopPrice:self.currentData.downPrice.doubleValue];
                self.minChangePrice = [[NSDecimalNumber alloc] initWithString:self.currentData.priceChangeRate];
            }else{
                [MBProgressHUD showErrorMessage:@"暂无数据"];
            }
            
        } fail:^(NSString *str) {
            
        }];
}

-(void)queryInstrumentById:(NSString *)instrumentId{
    User_Reqqryinstrument *query = [[User_Reqqryinstrument alloc] init];
    query.InstrumentID = instrumentId;
    [[SocketRequestManager shareInstance] qryInstrument:query];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //报单通知
    [kNotificationCenter addObserver:self selector:@selector(updateOrderInsert:) name:UPDTAE_INSERT_ORDER_NOTIFICATION_NAME object:nil];
    
    //成交通知
    [kNotificationCenter addObserver:self selector:@selector(updateOrderTrade:) name:UPDTAE_TRADE_ORDER_NOTIFICATION_NAME object:nil];
    
    //查询持仓
    [kNotificationCenter addObserver:self selector:@selector(updateOrderChicang:) name:UPDTAE_CHICANG_ORDER_NOTIFICATION_NAME object:nil];
    if (self.model == nil) {
        self.rdv_tabBarController.tabBarHidden = NO;
    }else{
           self.rdv_tabBarController.tabBarHidden = NO;
        self.rdv_tabBarController.navigationItem.rightBarButtonItem = self.menuBtnItem;
    }
    [self fetchReportViewData:self.containerView.currentSelectIndex];
    
    [self initButtonConfig];
    
}

 //报单通知
-(void)updateOrderInsert:(NSNotification*) noti{
    
    User_Onrtnorder *insert = (User_Onrtnorder *)noti.object ;
    if (insert.StatusMsg.length > 0) {
        [self.statusBar showMessage:insert.StatusMsg limitTime:3];
    }
    //更新资金
    [self queryAccountInfo];
    //更新挂单和委托表
    [self.containerView dataArray:kAppDelegate.weituoOrderArray forIndex:WeiTuoType];
    [self.containerView dataArray:kAppDelegate.guadanOrderArray forIndex:GuaDanType];
    [self.containerView reloadData:WeiTuoType];
    [self.containerView reloadData:GuaDanType];
   
   
}

 //成交通知
-(void)updateOrderTrade:(NSNotification*) noti{
    [self.containerView dataArray:kAppDelegate.chengjiaoOrderArray forIndex:ChengjiaoType];
    [self.containerView reloadData:ChengjiaoType];
    //更新资金
    [self queryAccountInfo];
    //查询持仓
    User_Reqqryinvestorposition *request = [[User_Reqqryinvestorposition alloc] init];
    request.BrokerID = @"9999";
    request.InvestorID = [kUserDefaults objectForKey:UserDefaults_User_ID_key];
    [[SocketRequestManager shareInstance]  reqqryinvestorposition:request];
}

-(void)updateOrderChicang:(NSNotification*) noti{
  
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [kNotificationCenter removeObserver:UPDTAE_INSERT_ORDER_NOTIFICATION_NAME];
    [kNotificationCenter removeObserver:UPDTAE_TRADE_ORDER_NOTIFICATION_NAME];
    [kNotificationCenter removeObserver:UPDTAE_CHICANG_ORDER_NOTIFICATION_NAME];
    if (self.model == nil) {
        self.rdv_tabBarController.tabBarHidden = YES;
    }else{
        self.rdv_tabBarController.navigationItem.rightBarButtonItem = nil;
    }
    if (self.timer !=nil) {
        [self.timer invalidate];
        self.timer= nil;
    }
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)dealloc{
    if (self.timer !=nil) {
        [self.timer invalidate];
        self.timer= nil;
    }
}

-(void)didReceiveSocketData:(NSNotification *)noti{
    [super didReceiveSocketData:noti];
    //查询资金账户
     if ((int32)self.funtionNo.integerValue == AS_SDK_USER_ONRSPQRYTRADINGACCOUNT){
         self.currentAccountInfo = self.response.firstObject;
         [self.headerView configAccountData:self.currentAccountInfo];
     }else if ((int32)self.funtionNo.integerValue == AS_SDK_USER_ONRSPQRYINVESTORPOSITION){
         //持仓表响应
         self.chicangArray = self.response;
         [self.containerView dataArray:self.chicangArray forIndex:ChiChangType];
         [self.containerView reloadData:ChiChangType];
//     }else if ((int32)self.funtionNo.integerValue == AS_SDK_USER_REQQRYTRADE){
////         //成交表响应
//////         self.chengjiaoArray = self.response;
//////         [self.containerView dataArray:self.chengjiaoArray forIndex:ChengjiaoType];
//////         [self.containerView reloadData];
//     }
//     else if((int32)self.funtionNo.integerValue == AS_SDK_USER_ONRSPORDERINSERT){
//         //报单错误响应
//         NSLog(@"收到报单错误响应");
     }
}

-(void)didResponseErrorOccurs:(NSNotification *)noti{
    NSDictionary *dict = noti.object;
    NSNumber *functionNo = dict[@"functionNo"];
    //报单通知有错误信息
    if ((int32)functionNo.integerValue == AS_SDK_USER_ONRSPORDERINSERT) {
       [self.statusBar showMessage:dict[@"errorMsg"] limitTime:3];
    }
    //查询资金账户有错误
    else if ((int32)functionNo.integerValue == AS_SDK_USER_ONRSPQRYSECAGENTTRADINGACCOUNT) {
        [MBProgressHUD showErrorMessage:dict[@"errorMsg"]];
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
