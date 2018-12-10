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
@property(nonatomic,copy) NSString* key;
@end
#define identifier @"OrderPriceSettingCell"

@implementation OrderPriceSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.navTitle;
    self.tableView.mj_header = nil;
    self.tableView.mj_footer = nil;
    self.tableView.separatorColor = kTableViewBackGroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
    }];
    [self configData];
    if (self.type == Close) {
        self.key = CLOSE_ORDER_PRICE;
    }else if (self.type == Reverse){
        self.key = REVERSE_ORDER_PRICE;
    }else if (self.type == Lock){
        self.key = LOCK_ORDER_PRICE;
    }
    NSNumber *index = [kUserDefaults objectForKey:self.key];
    self.currentSelectedIndex = index == nil ? 0 : index.integerValue;
    // Do any additional setup after loading the view.
}

-(void)configData{
    [self.dataArray addObjectsFromArray:@[@"对价",@"市价",@"排队价",@"最新价"]];
    [self.tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton* checkMarkBtn = [[UIButton alloc]init];
        [checkMarkBtn setImage:kImageName(@"未选中对勾") forState:UIControlStateNormal];
        [checkMarkBtn setImage:kImageName(@"选中对勾") forState:UIControlStateSelected];
        [checkMarkBtn setUserInteractionEnabled:false];
        checkMarkBtn.tag = CheckMark_Button_Tag;
        [cell.contentView addSubview:checkMarkBtn];
        [checkMarkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(cell.contentView);
        }];
        [cell bringSubviewToFront:checkMarkBtn];
    }
    cell.backgroundColor = kCellBackGroundColor;
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.textColor = kWhiteColor;
    cell.textLabel.font = kFontSize(14);
    UIButton *checkMarkBtn = (UIButton *)[cell viewWithTag:CheckMark_Button_Tag];
    [checkMarkBtn setSelected:self.currentSelectedIndex == indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != self.currentSelectedIndex) {
        self.currentSelectedIndex = indexPath.row;
        [kUserDefaults setObject:@(self.currentSelectedIndex) forKey:self.key];
        [self.tableView reloadData];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
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
