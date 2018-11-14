//
//  MainViewController.m
//  AMS
//
//  Created by jianlu on 2018/10/26.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "MainViewController.h"
#import <ECSlidingViewController.h>
#import "AppDelegate+AppSevice.h"
#import "DetailViewController.h"
#import <AXWebViewController.h>
#import "Y_StockChartViewController.h"

@interface MainViewController ()
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"右边菜单" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemTapped:)];
    self.navigationItem.rightBarButtonItems = @[rightBarButtonItem];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"左边菜单" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarItemTapped:)];
    self.navigationItem.leftBarButtonItems = @[leftBarButtonItem];
    self.title = @"ams资管";
    [UIButton zj_buttonWithTitle:@"测试网页" titleColor:kRedColor backColor:kBlueColor fontSize:18 isBold:YES cornerRadius:0 supView:self.view constraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    } touchUp:^(id sender) {
        Y_StockChartViewController *stockVc = [[Y_StockChartViewController alloc] init];
        [self.rt_navigationController pushViewController:stockVc animated:YES];
//        DetailViewController *detailVc = [[DetailViewController alloc] init];
//        [self.rt_navigationController pushViewController:detailVc animated:YES];
    }];
    UISwipeGestureRecognizer *upSwipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [upSwipeGR setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:upSwipeGR];
    
    UISwipeGestureRecognizer *downSwipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [downSwipeGR setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:downSwipeGR];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    AppDelegate *delegate = [AppDelegate shareAppDelegate];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

-(void)rightBarItemTapped:(UIBarButtonItem*)item{
    AppDelegate *delegate = [AppDelegate shareAppDelegate];
    [delegate.managerVc anchorTopViewToLeftAnimated:YES];
}

-(void)leftBarItemTapped:(UIBarButtonItem*)item{
    AppDelegate *delegate = [AppDelegate shareAppDelegate];
    [delegate.managerVc anchorTopViewToRightAnimated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    AppDelegate *delegate = [AppDelegate shareAppDelegate];
    [delegate.managerVc resetTopViewAnimated:YES];
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)swipeGr{
    if (swipeGr.direction == UISwipeGestureRecognizerDirectionUp) {
        DLog(@"向上滑动了");
    }
    if (swipeGr.direction == UISwipeGestureRecognizerDirectionDown) {
        DLog(@"向下滑动了");
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
