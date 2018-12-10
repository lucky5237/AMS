//
//  ModifyPasswordController.h
//  AMS
//
//  Created by jianlu on 2018/11/23.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ModifyPasswordController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *originalPwdTf;
@property (weak, nonatomic) IBOutlet UITextField *theNewPwdTf;
@property (weak, nonatomic) IBOutlet UITextField *theNewConfirmPwdTf;
@property (weak, nonatomic) IBOutlet UILabel *forgetPwdLabel;

@end

NS_ASSUME_NONNULL_END
