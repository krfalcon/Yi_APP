//
//  RegisterView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/18.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"
#import "InputView.h"

@protocol RegisterViewDelegate;

@interface RegisterView : TempletView
{
    NSTimer*                                                timer;
    int                                                     timeLeft;
    
    InputView*                                              phoneField;
    InputView*                                              passwordField;
    InputView*                                              againField;
    InputView*                                              verificationField;
}

@property (weak, nonatomic) id<RegisterViewDelegate>              delegate;
- (void)changeToReserMode;

@end

@protocol RegisterViewDelegate <NSObject>

- (void)registerViewDidTapVerificationButtonWithPhone:(NSString *)phone;
- (void)registerViewDidTapCommitButtonWithPhone:(NSString *)phone andPWD:(NSString *)pwd andVerification:(NSString *)verification;
- (void)registerViewDidTapResetButtonWithPhone:(NSString *)phone andPWD:(NSString *)pwd andVerification:(NSString *)verification;

- (void)registerViewDidSuccess;

@end
