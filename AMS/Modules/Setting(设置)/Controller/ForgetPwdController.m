//
//  ForgetPwdController.m
//  AMS
//
//  Created by jianlu on 2018/11/23.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "ForgetPwdController.h"
#import "CustomPopView.h"
@interface ForgetPwdController ()
@property(nonatomic,strong) UIBarButtonItem *doneBarButton;
@property(nonatomic,strong) CustomPopView *customPopView;
@property(nonatomic,assign) NSInteger time;//倒计时
@property(nonatomic,strong) RACDisposable *dispoable;
@end

@implementation ForgetPwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    [self.phoneTf setValue:@11 forKey:@"limit"];
    [self.msgCodeTf setValue:@6 forKey:@"limit"];
    kWeakSelf(self);
    [[self.sendCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        kStrongSelf(self);
        self.time = TIME_OUT;
        x.enabled = false;
        x.backgroundColor = kLightGrayColor;
        [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"%ld秒后重试",(long)self.time]  forState:UIControlStateNormal | UIControlStateDisabled];
        
        //这个就是RAC中的GCD
        self.dispoable = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
            self.time --;
            NSString * title = self.time > 0 ? [NSString stringWithFormat:@"%ld秒后重试",(long)self.time] : @"发送验证码";
            [self.sendCodeBtn setTitle:title forState:UIControlStateNormal | UIControlStateDisabled];
            self.sendCodeBtn.enabled = (self->_time==0)? YES : NO;
            self.sendCodeBtn.backgroundColor = self.sendCodeBtn.enabled ? [UIColor zj_colorWithRed:187 green:0 blue:50] : kLightGrayColor;
            if (self.time == 0) {
                [self.dispoable dispose];
            }
        }];
    }];
}

-(UIBarButtonItem *)doneBarButton{
    if (!_doneBarButton) {
        _doneBarButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(doneBtnTapped:)];
        _doneBarButton.tintColor = kBlueTextColor;
        [_doneBarButton setTitleTextAttributes:@{NSFontAttributeName:kFontSize(14)} forState:UIControlStateNormal];
    }
    return _doneBarButton;
}

-(CustomPopView *)customPopView{
    if (!_customPopView) {
        _customPopView = [CustomPopView customPopView];
    }
    return _customPopView;
}

-(void)doneBtnTapped:(UIBarButtonItem *)doneBtn{
    [self.phoneTf resignFirstResponder];
    [self.msgCodeTf resignFirstResponder];
    [self.theNewPwdTf resignFirstResponder];
    [self.theNewConfirmPwdTf resignFirstResponder];
    if ([self checkValid]) {
        [self doSubmit];
    }
}

//验证输入是否合法
-(BOOL)checkValid{
    NSString *errorHint = @"";
    if (self.theNewPwdTf.text != self.theNewConfirmPwdTf.text) {
        errorHint = @"两次填写的密码不一致\n请重新填写";
        [self.customPopView showPopView:errorHint];
        return NO;
    }
    return YES;
}

-(void)doSubmit{
    if (self.phoneTf.text.length == 0) {
        [self.customPopView showPopView:@"手机号不能为空"];
        return;
    }
    if(self.phoneTf.text.length != 11){
        [self.customPopView showPopView:@"请输入正确的手机号"];
        return;
    }
    if(self.phoneTf.text.length != 11){
        [self.customPopView showPopView:@"请输入正确的手机号"];
        return;
    }
    [self.customPopView showPopView:@"密码修改成功，请重新登录！" completion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem = self.doneBarButton;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationItem.rightBarButtonItem = nil;
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
