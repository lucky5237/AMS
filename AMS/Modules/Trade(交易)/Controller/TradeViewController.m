//
//  TradeViewController.m
//  AMS
//
//  Created by jianlu on 2018/11/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "TradeViewController.h"

@interface TradeViewController ()

@end

@implementation TradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kYellowColor;
    // Do any additional setup after loading the view.
    UILabel *label = [UILabel zj_labelWithFontSize:12 textColor:kWhiteColor superView:self.view constraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
    label.text = @"交易";
    [self.view addSubview:label];
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
