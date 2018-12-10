//
//  ModifyPasswordController.m
//  AMS
//
//  Created by jianlu on 2018/11/23.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "ModifyPasswordController.h"
#import "ForgetPwdController.h"
#import "CustomPopView.h"

@interface ModifyPasswordController ()
@property(nonatomic,strong) UIBarButtonItem *doneBarButton;
@property(nonatomic,strong) CustomPopView *customPopView;
@end

@implementation ModifyPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"忘记密码?" attributes:attribtDic];
    self.forgetPwdLabel.attributedText = attribtStr;
    [self.forgetPwdLabel zj_addTapGestureWithCallback:^(UITapGestureRecognizer *gesture) {
//        NSLog(@"点击了忘记密码");
        ForgetPwdController *forgetPwdVC = [[ForgetPwdController alloc] init];
        forgetPwdVC.hideRightButton = YES;
        [self.navigationController pushViewController:forgetPwdVC animated:YES];
    }];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem = self.doneBarButton;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationItem.rightBarButtonItem = nil;
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
    [self.originalPwdTf resignFirstResponder];
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
    if (self.originalPwdTf.text.length == 0) {
        [self.customPopView showPopView:@"内容您输入的原始密码错误\n请重新填写"];
        return;
    }
    [self.customPopView showPopView:@"密码修改成功，请重新登录！" completion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

-(void)showErrorPopView:(NSString*)message{
    
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
