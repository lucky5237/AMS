//
//  SettingMainViewController.m
//  AMS
//  设置首页
//  Created by jianlu on 2018/11/14.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "SettingMainViewController.h"
#import "SettingHeaderView.h"
#import "TradeSettingViewController.h"
#import "PlateViewController.h"
#import "AccountSettingViewController.h"
#import "MessageCenterController.h"
#import "LoginViewController.h"

@interface SettingMainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) SettingHeaderView *headerView;
@property(nonatomic,strong) UIButton *logOutBtn;
@end
#define identifier @"SettingMainTableViewCell"
@implementation SettingMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = kTableViewBackGroundColor;
    //tableView相关设置
    self.tableView.mj_header = nil;
    self.tableView.mj_footer = nil;
    self.tableView.scrollEnabled = false;
    self.tableView.showsVerticalScrollIndicator = false;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = kTableViewBackGroundColor;
    
    //添加退出登录按钮
    self.logOutBtn = [UIButton zj_buttonWithTitle:@"退出登录" titleColor:kBlueTextColor backColor:kCellBackGroundColor fontSize:15 isBold:false cornerRadius:0 supView:self.view constraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(49);
        make.bottom.mas_equalTo(-15);
    } touchUp:^(id sender) {
        [self logOut];
    }];
    //配置相关数据
    [self configData];
    // Do any additional setup after loading the view.
}

/**
 //配置相关数据
 */
-(void)configData{
    [self.dataArray addObjectsFromArray:@[@"交易设置",@"板块设置",@"账号设置",@"消息中心",@"帮助"]];
    [self.tableView reloadData];
    
}

/**
 退出登录
 */
-(void)logOut{
//    NSLog(@"点击了退出登录按钮");
    LoginViewController *loginVc = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVc animated:YES];
}

/**
 懒加载headerView
 @return headerView
 */
-(SettingHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SettingHeaderView class]) owner:nil options:nil]lastObject];
//        _headerView.backgroundColor = kCellBackGroundColor;
    }
    return _headerView;
}

#pragma mark tableView 代理相关
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    cell.backgroundColor = kCellBackGroundColor;
    cell.imageView.image = kImageName(self.dataArray[indexPath.row]);
    cell.textLabel.font = kFontSize(14);
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.textColor = kNormalTextColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString *item = self.dataArray[indexPath.row];
    if (indexPath.row == 0) {
        //点击了交易设置
        TradeSettingViewController *tradeSettingVC = [[TradeSettingViewController alloc] init];
        tradeSettingVC.hideRightButton = YES;
        [self.navigationController pushViewController:tradeSettingVC animated:YES];
    }else if (indexPath.row == 1){
        //点击了板块设置
        PlateViewController *plateVC = [[PlateViewController alloc] init];
        plateVC.hideRightButton = YES;
        [self.navigationController pushViewController:plateVC animated:YES];
    }else if (indexPath.row == 2){
        //点击了账号设置
        AccountSettingViewController *accountSettingVC = [[AccountSettingViewController alloc] init];
        accountSettingVC.hideRightButton = YES;
        [self.navigationController pushViewController:accountSettingVC animated:YES];
    }else if (indexPath.row == 3){
        //点击了消息中心
       MessageCenterController* msgCenterVC = [[MessageCenterController alloc] init];
        msgCenterVC.hideRightButton = YES;
        [self.navigationController pushViewController:msgCenterVC animated:YES];
    }else if (indexPath.row == 4){
        [MBProgressHUD showInfoMessage:@"点击了帮助"];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSDictionary *info = @{@"image":@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2836349987,4105482659&fm=26&gp=0.jpg",@"name":@"lujian",@"level":@"普通会员"};
    [self.headerView configUserInfo:info];
    return self.headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 120;
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
