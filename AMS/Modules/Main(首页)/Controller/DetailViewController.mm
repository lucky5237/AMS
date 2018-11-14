//
//  DetailViewController.m
//  AMS
//
//  Created by jianlu on 2018/10/30.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "DetailViewController.h"
#import <JDStatusBarNotification.h>
#import <ReactiveObjC.h>
#import "BestMessageUtil.h"
#import "AMSSocketManager.h"

@interface DetailViewController ()
@property(nonatomic,strong) UITextField* nameTf;
@property(nonatomic,strong) UITextField* pwdTf;
@property(nonatomic,strong) UIButton* loginBtn;
@property(nonatomic,assign) BOOL isValid;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor orangeColor];
    self.title = @"详情";
    
//    self.nameTf = [UITextField zj_textFieldWithHolder:@"用户名" superView:self.view constraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.view);
//        make.top.mas_equalTo(kTopHeight + 50);
//        make.size.mas_equalTo(CGSizeMake(100, 35));
//    }];
//
//    self.pwdTf = [UITextField zj_textFieldWithHolder:@"密码" superView:self.view constraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.view);
//        make.top.mas_equalTo(kTopHeight + 100);
//        make.size.mas_equalTo(CGSizeMake(100, 35));
//    }];
//
//    self.loginBtn = [UIButton zj_buttonWithTitle:@"登录" titleColor:kWhiteColor backColor:kBlueColor fontSize:12 isBold:NO cornerRadius:0 supView:self.view constraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.view);
//        make.top.mas_equalTo(kTopHeight + 150);
//        make.size.mas_equalTo(CGSizeMake(100, 35));
//    } touchUp:^(id sender) {
//
//    }];
//    [self.loginBtn setTitle:@"不能点击" forState:UIControlStateDisabled];
//
//    RACSignal *nameSignal = [self.nameTf rac_textSignal];
//    RACSignal *pwdSingal = [self.pwdTf rac_textSignal];
//    [[[[self.nameTf rac_textSignal]  filter:^BOOL(NSString * _Nullable value) {
//        return value.length  >= 11;
//    }]map:^id _Nullable(NSString * _Nullable value) {
//        return @(value.length);
//    }]subscribeNext:^(NSNumber * _Nullable x) {
//        NSLog(@"name legth is %@",x);
//    }];
////    RAC(self.nameTf,text) = [nameSignal map:^id _Nullable(NSString* value) {
////        return value.length >= 11 ? [value substringToIndex:10] : value;
////    }];
//    RAC(self.nameTf,text) = [nameSignal filter:^BOOL(NSString* value) {
//        return value.length <=11;
//    }];
//
//    RAC(self.loginBtn,enabled) = [RACSignal combineLatest:@[nameSignal,pwdSingal] reduce:^id(NSString* name,NSString* pwd){
//        return @(name.length == 11 && pwd.length >=6);
//    }];
//
//    [pwdSingal subscribeNext:^(NSString* x) {
//        NSLog(@"password is %@",x);
//    }];
//
//    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        self.nameTf.text = @"123";
//    }];
//
//    [[kNotificationCenter rac_addObserverForName:@"hello" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
//        NSLog(@"hello is called");
//    }];
//
//    [RACObserve(self.loginBtn, frame) subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
//
//    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@1];
//        return nil;
//    }];
//    [signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
//    RACAble(<#...#>)
    
//    RAC(self,isValid) = [RACSignal combineLatest:@[nameSignal,pwdSingal] reduce:^(NSString *name,NSString*pwd){
//
//    }];
    
//    [kNotificationCenter rac_Add]
//    NSData *data = [BestMessageUtil GenerateBestMsg: @"hello"];
//    [[AMSSocketManager shareInstance] addSocketClient:@"linx" withHost:@"10.131.11.161" withPort:1234];
//    [[AMSSocketManager shareInstance] writeData:data toSocket:@"linx"];
//    NSString *str  = @"12345";
//    NSData* data = [str dataUsingEncoding:kCFStringEncodingUTF8];
//    NSLog(@"data length is %lu",(unsigned long)data.length);
//    Byte *byte = (Byte *)[data bytes];
//    for(int i=0;i<[data length];i++)
//        printf("testByte = %x",byte[i]);
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem *shareButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareBtnTapped:)];
    self.navigationItem.rightBarButtonItems = @[shareButtonItem];
}

-(void)shareBtnTapped:(UIBarButtonItem*)item{
    DLog(@"shareBtnTapped");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.loginBtn.frame = CGRectMake(100, 100, 100, 39);
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
