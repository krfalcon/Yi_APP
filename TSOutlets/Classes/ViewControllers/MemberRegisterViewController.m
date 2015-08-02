//
//  MemberRegisterViewController.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/12.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "MemberRegisterViewController.h"

@interface MemberRegisterViewController ()

@end

@implementation MemberRegisterViewController

#pragma mark - InitView

- (void)initFirstViewWithParameter:(NSDictionary *)parameter
{
    if (!parameter) return;
    if (!registerView && [[parameter valueForKey:@"type"] isEqualToString:@"register"]) {
        registerView = [[RegisterView alloc] initWithFrame:self.view.bounds];
        [registerView setDelegate:self];
        [self.view addSubview:registerView];
    } else if(!registerView) {
        registerView = [[RegisterView alloc] initWithFrame:self.view.bounds];
        [registerView setDelegate:self];
        [self.view addSubview:registerView];
        
        [registerView changeToReserMode];
    }
}

#pragma mark - Register View Delegate

- (void)registerViewDidTapVerificationButtonWithPhone:(NSString *)phone {
    MemberAPITool *mat = [[MemberAPITool alloc] init];
    [mat getVerificationCodeWithPhone:phone];
}

- (void)registerViewDidTapCommitButtonWithPhone:(NSString *)phone andPWD:(NSString *)pwd andVerification:(NSString *)verification {
    MemberAPITool *mat = [[MemberAPITool alloc] init];
    [mat registerMemberWithPhone:phone andPassword:pwd andVerificationCode:verification];
}

- (void)registerViewDidTapResetButtonWithPhone:(NSString *)phone andPWD:(NSString *)pwd andVerification:(NSString *)verification {
    MemberAPITool *mat = [[MemberAPITool alloc] init];
    [mat resetPasswordWithPhone:phone andPassword:pwd andVerificationCode:verification];
}

- (void)registerViewDidSuccess {
    [self popToIndexViewController];
}

@end
