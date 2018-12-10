//
//  NewsViewController.m
//  AMS
//
//  Created by jianlu on 2018/11/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "NewsViewController.h"
#import <AXWebViewController.h>
#import <RDVTabBarController.h>

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资讯中心";
    self.rt_navigationController.navigationBar.backgroundColor = kDarkGrayColor;
    // Do any additional setup after loading the view.
    AXWebViewController *newsVC = [[AXWebViewController alloc] initWithAddress:NEWS_URL];
    newsVC.showsToolBar = NO;
    newsVC.navigationController.navigationBar.translucent = NO;
  
    newsVC.view.frame = self.view.bounds;
    [self addChildViewController:newsVC];
    [self.view addSubview:newsVC.view];
    [newsVC didMoveToParentViewController:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rdv_tabBarController.tabBarHidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.rdv_tabBarController.tabBarHidden = YES;
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
