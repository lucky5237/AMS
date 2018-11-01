//
//  DetailViewController.m
//  AMS
//
//  Created by jianlu on 2018/10/30.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "DetailViewController.h"
#import <JDStatusBarNotification.h>

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.title = @"详情";
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem *shareButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareBtnTapped:)];
    self.navigationItem.rightBarButtonItems = @[shareButtonItem];
}

-(void)shareBtnTapped:(UIBarButtonItem*)item{
    DLog(@"shareBtnTapped");
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
