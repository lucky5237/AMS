//
//  OrderPriceSettingViewController.m
//  AMS
//  下单价格（平仓下单，反手下单，锁单下单）
//  Created by jianlu on 2018/11/14.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "OrderPriceSettingViewController.h"

@interface OrderPriceSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,assign) NSInteger currentSelectedIndex;
@end
#define identifier @"OrderPriceSettingCell"

@implementation OrderPriceSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.navTitle;
    self.currentSelectedIndex = 0;
    self.tableView.mj_header = nil;
    self.tableView.mj_footer = nil;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kTopHeight+20);
    }];
    [self configData];
    // Do any additional setup after loading the view.
}

-(void)configData{
    [self.dataArray addObjectsFromArray:@[@"对价",@"市价",@"排队价",@"最新价"]];
    [self.tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = kCellBackGroundColor;
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.textColor = kWhiteColor;
    cell.tintColor = [UIColor purpleColor];
    if (self.currentSelectedIndex == indexPath.row) {
       cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != self.currentSelectedIndex) {
        self.currentSelectedIndex = indexPath.row;
        [self.tableView reloadData];
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
