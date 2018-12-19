//
//  PlateViewController.m
//  AMS
//  板块设置
//  Created by jianlu on 2018/11/15.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "PlateViewController.h"

@interface PlateViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *plateDictArray;
@end

#define identifier @"PlateCell"

@implementation PlateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"板块设置";
    self.tableView.mj_header = nil;
    self.tableView.mj_footer = nil;
    self.tableView.separatorColor = kTableViewBackGroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
    }];
    [self fetchData];
    
}

-(NSMutableArray *)plateDictArray{
    if (!_plateDictArray) {
        _plateDictArray = [NSMutableArray array];
    }
    return _plateDictArray;
}

/**
 获取数据
 */
-(void)fetchData{
    [self.plateDictArray addObjectsFromArray: [kUserDefaults objectForKey:PLATE_SETTING_DICT]];
    [self.dataArray addObjectsFromArray:@[@{@"code":@"SHFE",@"name":@"上海期货交易所"},@{@"code":@"DCE",@"name":@"大连商品交易所"},@{@"code":@"CZCE",@"name":@"郑州商品交易所"},@{@"code":@"CFFEX",@"name":@"中国金融交易所"}]];
    [self.tableView reloadData];
}


#pragma mark tableview delegate & datasource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.backgroundColor = kCellBackGroundColor;
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
    NSDictionary *dict = self.dataArray[indexPath.row];
    cell.textLabel.text = dict[@"name"];
    cell.textLabel.textColor = kWhiteColor;
    cell.textLabel.font = kFontSize(14);
    UIButton *checkMarkBtn = (UIButton *)[cell viewWithTag:CheckMark_Button_Tag];
    [checkMarkBtn setSelected:[self.plateDictArray containsObject: dict]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.dataArray[indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIButton *checkMarkBtn = (UIButton *)[cell viewWithTag:CheckMark_Button_Tag];
    if (checkMarkBtn.selected) {
        [self.plateDictArray removeObject:dict];
    }else {
        [self.plateDictArray addObject:dict];
    }
    checkMarkBtn.selected = !checkMarkBtn.selected;
    [kUserDefaults setObject:self.plateDictArray forKey:PLATE_SETTING_DICT];
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
