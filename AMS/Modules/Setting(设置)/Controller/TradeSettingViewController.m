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
@property(nonatomic,strong) UISwitch *mSwitch;
@end
#define identifier_1 @"identifier_1"
#define identifier_2 @"identifier_2"
@implementation TradeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易设置";
    self.tableView.mj_header = nil;
    self.tableView.mj_footer = nil;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = kTableViewBackGroundColor;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
    }];
    [self.dataArray  addObjectsFromArray:@[@[@"交易声音提示"],@[@"平仓下单价格",@"反手下单价格",@"锁单下单价格"]]];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self configData];
}

/**
 初始化数据
 */
-(void)configData{
    
    [self.tableView reloadData];
}

-(void)swicthTapped:(UISwitch *)_switch{
    [kUserDefaults setObject:@(_switch.isOn) forKey:TRADE_SOUND_OPEN];
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
            cell1.textLabel.textColor = kNormalTextColor;
            cell1.textLabel.font = kFontSize(14);
            //添加开关按钮
            UISwitch * _switch = [[UISwitch alloc] init];
//            _switch.backgroundColor = kDarkGrayColor;
//            _switch.layer.cornerRadius = 15.5f;
//            _switch.layer.masksToBounds = YES;
            [_switch addTarget:self action:@selector(swicthTapped:) forControlEvents:UIControlEventValueChanged];
            [cell1 addSubview:_switch];
            [_switch mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell1.contentView);
                make.right.mas_equalTo(-10);
                make.size.mas_equalTo(CGSizeMake(50, 33));
            }];
            self.mSwitch = _switch;
        }
        cell1.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
        NSNumber *isOn = [kUserDefaults objectForKey:TRADE_SOUND_OPEN];
        [self.mSwitch setOn:(isOn != nil && isOn.integerValue != 0)];
        return cell1;
    }else{
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:identifier_2];
        if (cell2 == nil) {
            cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier_2];
            cell2.backgroundColor = kCellBackGroundColor;
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        NSString *key = kOrderPriceKeys[indexPath.row];
        NSNumber *index = [kUserDefaults objectForKey:key];
        cell2.textLabel.font = kFontSize(14);
        cell2.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
        cell2.textLabel.textColor = kNormalTextColor;
        cell2.detailTextLabel.text = kOrderPriceItems[index == nil ? 0 : index.integerValue];
        cell2.detailTextLabel.textColor = kWhiteColor;
        cell2.detailTextLabel.font = kFontSize(14);
        return cell2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 0) {
        OrderPriceSettingViewController *orderPriceSettingVC = [[OrderPriceSettingViewController alloc] init];
        orderPriceSettingVC.type = indexPath.row;
        orderPriceSettingVC.navTitle = self.dataArray[indexPath.section][indexPath.row];
        [self.navigationController pushViewController:orderPriceSettingVC animated:YES];
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
