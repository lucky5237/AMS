//
//  ForbidPasteTextField.m
//  AMS
//
//  Created by jianlu on 2018/11/20.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "ForbidPasteTextField.h"

@implementation ForbidPasteTextField
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:))
    {
        return false;
    }
    
    return [super canPerformAction:action withSender:sender];
}

@end
