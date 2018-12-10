//
//  OptionalViewController.m
//  AMS
//  自选controller
//  Created by jianlu on 2018/11/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "OptionalViewController.h"

@interface OptionalViewController ()

@end

@implementation OptionalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRedColor;
    // Do any additional setup after loading the view.
    UILabel *label = [UILabel zj_labelWithFontSize:12 textColor:kWhiteColor superView:self.view constraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
    label.text = @"自选";
    [self.view addSubview:label];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
