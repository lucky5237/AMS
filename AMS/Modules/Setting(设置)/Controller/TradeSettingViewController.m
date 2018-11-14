//
//  TradeSettingViewController.m
//  AMS
//  交易设置
//  Created by jianlu on 2018/11/14.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "TradeSettingViewController.h"
#import "OrderPriceSettingViewController.h"

@interface TradeSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@end
#define identifier_1 @"identifier_1"
#define identifier_2 @"identifier_2"
@implementation TradeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易设置";
    self.tableView.mj_header = nil;
    self.tableView.mj_footer = nil;
    self.tableView.backgroundColor = kBackGroundColor;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kTopHeight + 20);
    }];
    [self configData];
    // Do any additional setup after loading the view.
}

/**
 初始化数据
 */
-(void)configData{
    [self.dataArray  addObjectsFromArray:@[@[@"交易声音提示"],@[@"平仓下单价格",@"反手下单价格",@"锁单下单价格"]]];
}

-(void)swicthTapped:(UISwitch *)_switch{
    if (_switch.on) {
        NSLog(@"打开开关");
    }else{
        NSLog(@"关闭开关");
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *rowArray = (NSArray *)self.dataArray[section];
    return rowArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //上方样式
    if (indexPath.section == 0) {
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier_1];
        if (cell1 == nil) {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_1];
            cell1.backgroundColor = kCellBackGroundColor;
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            UISwitch * _switch = [[UISwitch alloc] init];
            _switch.backgroundColor = kDarkGrayColor;
            _switch.layer.cornerRadius = 15.5f;
            _switch.layer.masksToBounds = YES;
            [_switch addTarget:self action:@selector(swicthTapped:) forControlEvents:UIControlEventValueChanged];
            [cell1 addSubview:_switch];
            [_switch mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell1.contentView);
                make.right.mas_equalTo(-kRealWidth(20));
            }];
            [cell1.contentView bringSubviewToFront:_switch];
        }
        cell1.textLabel.textColor = kWhiteColor;
        cell1.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
        return cell1;
    }else{
       UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:identifier_2];
        if (cell2 == nil) {
            cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier_2];
            cell2.backgroundColor = kCellBackGroundColor;
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell2.detailTextLabel.text = @"对价";
        cell2.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
        cell2.detailTextLabel.textColor = kWhiteColor;
        cell2.textLabel.textColor = kWhiteColor;
        return cell2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 0) {
        OrderPriceSettingViewController *orderPriceSettingVC = [[OrderPriceSettingViewController alloc] init];
        orderPriceSettingVC.type = indexPath.row;
        orderPriceSettingVC.navTitle = self.dataArray[indexPath.section][indexPath.row];
        [self.rt_navigationController pushViewController:orderPriceSettingVC animated:YES];
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
