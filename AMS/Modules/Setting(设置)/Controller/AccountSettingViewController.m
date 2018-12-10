//
//  AccountSettingViewController.m
//  AMS
//  账号设置
//  Created by jianlu on 2018/11/15.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "AccountSettingViewController.h"
#import "ModifyPasswordController.h"
@interface AccountSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

#define identifier @"AccountSettingCell"

@implementation AccountSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号设置";
    self.tableView.mj_header = nil;
    self.tableView.mj_footer = nil;
    self.tableView.separatorColor = kTableViewBackGroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
    }];
    
    [self configData];
}

-(void)configData{
    [self.dataArray addObjectsFromArray:@[@"修改密码"]];
    [self.tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.textColor = kNormalTextColor;
        cell.textLabel.font = kFontSize(14);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = kCellBackGroundColor;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击修改密码
    if (indexPath.row == 0) {
//        NSLog(@"点击了修改密码");
        ModifyPasswordController *modifyPwdVC = [[ModifyPasswordController alloc] init];
        modifyPwdVC.hideRightButton = YES;
        [self.navigationController pushViewController:modifyPwdVC animated:YES];
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
