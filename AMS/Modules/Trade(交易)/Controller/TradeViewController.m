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
@interface TradeViewController ()<LMReportViewDatasource,LMReportViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong) TradeHeaderView *headerView;
@property(nonatomic,strong) UISegmentedControl *segmentedControl;
@property(nonatomic,strong) NSArray *itemArray;
@property(nonatomic,strong) NSArray *headerTitleArray;
@property(nonatomic,strong) LMReportView *reportView;
@property(nonatomic,strong) TradeCellMenuView *menuView;
@property(nonatomic,strong) NSIndexPath *currentSelectIndexPath;
@property(nonatomic,strong) PriceCustomKeyboardView *keyboardView;
@property(nonatomic,strong) NSDecimalNumber *minChangePrice;
@property(nonatomic,strong) NSMutableArray *tableArray;//表格列表
@property(nonatomic,assign) BOOL isLock;//是否锁定价格
@property(nonatomic,strong) UIImageView *underLineView;
@property(nonatomic,strong) CustomStatusBarView *statusBar;
@end

#define Header_Height  210
#define SegmentedControl_Height 44

@implementation TradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.itemArray = @[@"持仓",@"持仓明细",@"委托",@"成交",@"资金"];
    self.headerTitleArray = @[@[@"合约号",@"品种",@"多空",@"属性",@"持仓",@"可用"],@[@"持仓明细1",@"持仓明细2",@"持仓明细3",@"持仓明细4",@"持仓明细5",@"持仓明细6",@"持仓明细7"],@[@"委托1",@"委托2",@"委托3",@"委托4",@"委托5",@"委托6"],@[@"成交1",@"成交2",@"成交3",@"成交4",@"成交5"],@[@"资金1",@"资金2",@"资金3",@"资金3",@"资金4",@"资金5",@"资金6"]];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.segmentedControl];
    [self.view addSubview:self.underLineView];
    [self.underLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KScreenWidth/(self.itemArray.count * 2) -14/2);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(2);
        make.bottom.mas_equalTo(self.segmentedControl.mas_bottom);
    }];
    [self.view addSubview:self.reportView];
    
//    [self.reportView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.segmentedControl.mas_bottom);
//        make.left.mas_offset(0);
//        make.right.mas_equalTo(0);
//        make.bottom.mas_equalTo(self.view);
//    }];
    [self.reportView reloadData];
    [self.tableArray addObject:self.reportView];
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

-(LMReportView *)reportView{
    if (!_reportView) {
        _reportView = [[LMReportView alloc] initWithFrame:CGRectMake(0,  Header_Height+SegmentedControl_Height+1, KScreenWidth, KScreenHeight - (Header_Height+SegmentedControl_Height+1))];
        _reportView.datasource = self;
        _reportView.delegate = self;
        _reportView.style.spacing = 0;
        _reportView.backgroundColor = kCellBackGroundColor;
        _reportView.style.borderInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        kWeakSelf(self);
        _reportView.lMReportViewDidScrollBlock = ^(UIScrollView *scrollView, BOOL isMainScrollView) {
            kStrongSelf(self);
            if (isMainScrollView) {
                self.reportView.contentOffSet = scrollView.contentOffset.y;
            }
            [self.headerView.priceTf resignFirstResponder];
            [self.headerView.numTf resignFirstResponder];
            [self disAppearOpView];
        };
//       _reportView.style.stripeBackgroundColor = kLightGrayColor;
    }
    return _reportView;
}

-(TradeHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TradeHeaderView class]) owner:nil options:nil]lastObject];
        _headerView.frame = CGRectMake(0, 1, KScreenWidth,500);
        //点击买多
        kWeakSelf(self);
        [_headerView.buyMoreView zj_addTapGestureWithCallback:^(UITapGestureRecognizer *gesture) {
//            [MBProgressHUD showSuccessMessage:@"点击买多"];
            [self.statusBar showMessage:@"点击买多了！！！" limitTime:3];
        }];
        //点击卖空
        [_headerView.saleEmptyView zj_addTapGestureWithCallback:^(UITapGestureRecognizer *gesture) {
            [MBProgressHUD showSuccessMessage:@"点击卖空"];
        }];
        //点击平仓
        [_headerView.eveningUpView zj_addTapGestureWithCallback:^(UITapGestureRecognizer *gesture) {
            [MBProgressHUD showSuccessMessage:@"点击平仓"];
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
        _segmentedControl.frame = CGRectMake(0, Header_Height+1, KScreenWidth, SegmentedControl_Height);
       
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
        [self.reportView reloadData];
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
        [textField resignFirstResponder];
    }else if (type == DuiShou_Price){
        self.keyboardView.isUsingSystemPrice = YES;
        [textField setText:@"对手价"];
        [textField resignFirstResponder];
    }else if (type == Shi_Price){
        self.keyboardView.isUsingSystemPrice = YES;
        [textField setText:@"市价"];
        [textField resignFirstResponder];
    }else if (type == New_Price){
        self.keyboardView.isUsingSystemPrice = YES;
        [textField setText:@"最新价"];
        [textField resignFirstResponder];
    }else if (type == Super_Price){
        self.keyboardView.isUsingSystemPrice = YES;
        [textField setText:@"超价"];
        [textField resignFirstResponder];
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
}

//改变UISegmentedControl index
-(void)changeTabIndex:(UISegmentedControl *)control{
    [self disAppearOpView];
    [self.underLineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((KScreenWidth/(self.itemArray.count * 2)) * (2*control.selectedSegmentIndex +1) - 14/2);
    }];
    self.reportView.frame = CGRectMake(0,  Header_Height+SegmentedControl_Height, KScreenWidth, KScreenHeight - ( +Header_Height+SegmentedControl_Height));
    [self.reportView reloadData];
    
    
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
        searchVC.didSelectItemBlock = ^(NSDictionary * _Nonnull dict) {
            self.title = dict[@"name"];
            [MBProgressHUD showInfoMessage:[NSString stringWithFormat:@"选择了%@",dict[@"name"]]];
        };
        [self.navigationController pushViewController:searchVC animated:YES];
        return NO;
    }else{
        if (self.isLock) {
            return NO;
        }
        //获取最小变动价之类
        self.minChangePrice = [[NSDecimalNumber alloc] initWithDouble:0.2];
        if (textField == self.headerView.priceTf) {
            [self.keyboardView configTopHintMsg:0.2 riseStopPrice:3492.4 fallStopPrice:2857.6];
        }
        return YES;
    }
}


#pragma mark - <LMReportViewDatasource>

- (NSInteger)numberOfRowsInReportView:(LMReportView *)reportView {
    return 5*(self.segmentedControl.selectedSegmentIndex + 1);
}

- (NSInteger)numberOfColsInReportView:(LMReportView *)reportView {
    NSArray *currentHeaderArray = self.headerTitleArray[self.segmentedControl.selectedSegmentIndex];
    return currentHeaderArray.count;
}

- (LMRGrid *)reportView:(LMReportView *)reportView gridAtIndexPath:(NSIndexPath *)indexPath {
    LMRGrid *grid = [[LMRGrid alloc] init];
    if (indexPath.row == 0) {
        grid.backgroundColor = kTableViewBackGroundColor;
        grid.textColor = kNormalTextColor;
        grid.text = self.headerTitleArray[self.segmentedControl.selectedSegmentIndex][indexPath.col];
        grid.font = kFontSize(13);
    }else{
        
//        if (indexPath.row == self.currentSelectIndexPath.row) {
//             grid.backgroundColor = kOrangeColor;
//        }else{
//            grid.backgroundColor = kCellBackGroundColor;
//        }
        grid.backgroundColor = kCellBackGroundColor;
        grid.textColor = kWhiteColor;
        grid.text = [NSString stringWithFormat:@"%@-%ld-%ld",self.itemArray[self.segmentedControl.selectedSegmentIndex], indexPath.row, indexPath.col];
        grid.font = kFontSize(15);
    }
    
    return grid;
}

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
        [self.reportView addSubview:self.menuView];
        self.menuView.frame = CGRectMake(0, label.frame.origin.y + 88 -self.reportView.contentOffSet, KScreenWidth, 44);
        self.menuView.isShowing = YES;
        [self.reportView reloadData];
    }
    
}

-(void)reportView:(LMReportView *)reportView didTapLabel:(LMRLabel *)label{
    NSLog(@"单击了----");
    [self.headerView.priceTf resignFirstResponder];
    [self.headerView.numTf resignFirstResponder];
    if (self.menuView.isShowing) {
        [self disAppearOpView];
    }else{
        NSLog(@"点击了%@",label.text);
    }
}

-(CGFloat)reportView:(LMReportView *)reportView heightOfRow:(NSInteger)row{
    if (row == 0) {
        return 38;
    }
    return 44;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.model == nil) {
        self.rdv_tabBarController.tabBarHidden = NO;
    }else{
        self.rdv_tabBarController.navigationItem.rightBarButtonItem = self.menuBtnItem;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.model == nil) {
        self.rdv_tabBarController.tabBarHidden = YES;
    }else{
        self.rdv_tabBarController.navigationItem.rightBarButtonItem = nil;
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
