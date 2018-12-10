//
//  ForgetPwdController.h
//  AMS
//
//  Created by jianlu on 2018/11/23.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ForgetPwdController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *msgCodeTf;
@property (weak, nonatomic) IBOutlet UIButton *sendCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *theNewPwdTf;
@property (weak, nonatomic) IBOutlet UITextField *theNewConfirmPwdTf;

@end

NS_ASSUME_NONNULL_END
