//
//  MessageCenterController.m
//  AMS
//
//  Created by jianlu on 2018/11/23.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "MessageCenterController.h"

@interface MessageCenterController ()<UITableViewDelegate,UITableViewDataSource>

@end
#define identifier @"MessageCenterCell"

@implementation MessageCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息中心";
    self.tableView.mj_header = nil;
    self.tableView.mj_footer = nil;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = kTableViewBackGroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
    }];
    [self fetchData];
    // Do any additional setup after loading the view.
}

-(void)fetchData{
    for (int i = 0 ; i< 12; i++) {
        NSDictionary *dict = @{@"id":@(i+1),@"title":[NSString stringWithFormat:@"（2018-11-29） 随身行下单%d月份开始收费",i+1],@"hasRead":@(i%2)};
        [self.dataArray addObject:dict];
    }
    [self.tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = kCellBackGroundColor;
    }
    NSDictionary *dict = self.dataArray[indexPath.row];
    NSNumber *hasRead = dict[@"hasRead"];
    if (!hasRead.boolValue) {
        cell.imageView.image = kImageName(@"未读消息圆点");
        cell.textLabel.textColor = kWhiteColor;
    }else{
        cell.textLabel.textColor = kNormalTextColor;
        cell.imageView.image = [AMSUtil imageWithColor:kClearColor];
    }
    
    cell.textLabel.font = kFontSize(14);
    cell.textLabel.text = dict[@"title"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了消息%ld",(long)indexPath.row);
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
