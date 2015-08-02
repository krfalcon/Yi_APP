//
//  RegisterView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/18.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "RegisterView.h"

@implementation RegisterView

- (void)initView {
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 * self.scale, 40 * self.scale + self.titleHeight, 90 * self.scale, 35 * self.scale)];
    phoneLabel.text = @"手机号";
    phoneLabel.textColor = ThemeRed;
    phoneLabel.font = [UIFont boldSystemFontOfSize:25 * self.scale];
    [self addSubview:phoneLabel];
    
    phoneField = [[InputView alloc] initWithFrame:CGRectMake(120 * self.scale, 40 * self.scale + self.titleHeight, 250 * self.scale, 35 * self.scale) andTheme:@"Red" andPlaceholder:@"请输入您的手机号" andScale:self.scale];
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:phoneField];
    
    UILabel *againLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 * self.scale, 140 * self.scale + self.titleHeight, 90 * self.scale, 35 * self.scale)];
    againLabel.text = @"请确认";
    againLabel.textColor = ThemeRed;
    againLabel.font = [UIFont boldSystemFontOfSize:25 * self.scale];
    [self addSubview:againLabel];
    
    againField = [[InputView alloc] initWithFrame:CGRectMake(120 * self.scale, 140 * self.scale + self.titleHeight, 250 * self.scale, 35 * self.scale) andTheme:@"Red" andPlaceholder:@"请确认您输入的密码" andScale:self.scale];
    againField.secureTextEntry = YES;
    againField.keyboardType = UIKeyboardTypeDefault;
    [self addSubview:againField];
    
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 * self.scale, 90 * self.scale + self.titleHeight, 90 * self.scale, 35 * self.scale)];
    passwordLabel.text = @"密码";
    passwordLabel.tag = 22;
    passwordLabel.textColor = ThemeRed;
    passwordLabel.font = [UIFont boldSystemFontOfSize:25 * self.scale];
    [self addSubview:passwordLabel];
    
    passwordField = [[InputView alloc] initWithFrame:CGRectMake(120 * self.scale, 90 * self.scale + self.titleHeight, 250 * self.scale, 35 * self.scale) andTheme:@"Red" andPlaceholder:@"6~12位数字、符号、字母，不分大小写" andScale:self.scale];
    passwordField.secureTextEntry = YES;
    passwordField.keyboardType = UIKeyboardTypeDefault;
    [self addSubview:passwordField];
    
    UILabel *identifyingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 * self.scale, 190 * self.scale + self.titleHeight, 90 * self.scale, 35 * self.scale)];
    identifyingLabel.text = @"验证码";
    identifyingLabel.textColor = ThemeRed;
    identifyingLabel.font = [UIFont boldSystemFontOfSize:25 * self.scale];
    [self addSubview:identifyingLabel];
    
    verificationField = [[InputView alloc] initWithFrame:CGRectMake(120 * self.scale, 190 * self.scale + self.titleHeight, 120 * self.scale, 35 * self.scale) andTheme:@"Red" andPlaceholder:@"" andScale:self.scale];
    verificationField.autocapitalizationType = NO;
    verificationField.keyboardType = UIKeyboardTypeDefault;
    [self addSubview:verificationField];
    
    UIButton *identifyingButton = [[UIButton alloc] initWithFrame:CGRectMake(260 * self.scale, 190 * self.scale + self.titleHeight, 110 * self.scale, 35 * self.scale)];
    [identifyingButton setExclusiveTouch:YES];
    [identifyingButton addTarget:self action:@selector(getIdentifyingCode) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:identifyingButton];
    
    UILabel *buttonLabel = [[UILabel alloc] initWithFrame:identifyingButton.bounds];
    buttonLabel.layer.cornerRadius = buttonLabel.frame.size.height / 2;
    buttonLabel.layer.backgroundColor = ThemeRed.CGColor;
    buttonLabel.tag = 99;
    buttonLabel.text = @"获取";
    buttonLabel.textColor = AbsoluteWhite;
    buttonLabel.textAlignment = NSTextAlignmentCenter;
    buttonLabel.font = [UIFont boldSystemFontOfSize:25 * self.scale];
    [identifyingButton addSubview:buttonLabel];
    
    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 190 * self.scale) / 2, 260 * self.scale + self.titleHeight, 190 * self.scale, 60 * self.scale)];
    [registerButton setExclusiveTouch:YES];
    [registerButton addTarget:self action:@selector(tappedCommitButtton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:registerButton];
    
    UILabel *registerLabel = [[UILabel alloc] initWithFrame:registerButton.bounds];
    registerLabel.layer.cornerRadius = registerLabel.frame.size.height / 2;
    registerLabel.layer.backgroundColor = ThemeRed.CGColor;
    registerLabel.text = @"注册";
    registerLabel.textColor = AbsoluteWhite;
    registerLabel.textAlignment = NSTextAlignmentCenter;
    registerLabel.font = [UIFont boldSystemFontOfSize:40 * self.scale];
    registerLabel.tag = 11;
    [registerButton addSubview:registerLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memberLogin) name:@"memberLogin" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)changeToReserMode {
    [(UILabel *)[self viewWithTag:11] setText:@"完成"];
    [(UILabel *)[self viewWithTag:22] setText:@"新密码"];
}

- (void)tappedCommitButtton {
    NSString *MOBILE = @"^1(3[0-9]|5[0-9]|8[0-9])\\d{8}$";//总况
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:phoneField.text] == NO)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"请输入正确的手机号！"];
        return;
    }
    
    if (![passwordField.text isEqual:againField.text]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"两次输入密码不一致！"];
        return;
    }
    
    NSString *PWD = @"^[0-9a-zA-Z!@#$%^&*_-]{6,12}$";//正则
    NSPredicate *regextestPassword = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PWD];
    if ([regextestPassword evaluateWithObject:passwordField.text] == NO) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"密码格式有误！"];
        return;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"正在请求……"];
    
    if ( [[(UILabel *)[self viewWithTag:11] text] isEqualToString:@"完成"]) {
        if (_delegate && [_delegate respondsToSelector:@selector(registerViewDidTapResetButtonWithPhone:andPWD:andVerification:)]) {
            [_delegate registerViewDidTapResetButtonWithPhone:phoneField.text andPWD:passwordField.text andVerification:verificationField.text];
        }
    } else {
        if (_delegate && [_delegate respondsToSelector:@selector(registerViewDidTapCommitButtonWithPhone:andPWD:andVerification:)]) {
            [_delegate registerViewDidTapCommitButtonWithPhone:phoneField.text andPWD:passwordField.text andVerification:verificationField.text];
        }
    }
}

- (void)getIdentifyingCode {
    NSString * MOBILE = @"^1(3[0-9]|5[0-9]|8[0-9])\\d{8}$";//总况
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:phoneField.text] == NO)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"请输入正确的手机号！"];
        return;
    }
    
    [(UILabel *)[self viewWithTag:99] setText:@"60秒后重新获取"];
    [(UILabel *)[self viewWithTag:99] setFont:[UIFont boldSystemFontOfSize:12 * self.scale]];
    [[(UILabel *)[self viewWithTag:99] layer] setBackgroundColor:Color(161, 161, 161, 1).CGColor];
    [(UIButton *)[[self viewWithTag:99] superview] setEnabled:NO];
    timeLeft = 60;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tiktok) userInfo:nil repeats:YES];
    
    //返回当前的消息循环对象
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    if (_delegate && [_delegate respondsToSelector:@selector(registerViewDidTapVerificationButtonWithPhone:)]) {
        [_delegate registerViewDidTapVerificationButtonWithPhone:phoneField.text];
    }
}

- (void)tiktok {
    timeLeft --;
    if (timeLeft == 0) {
        [(UILabel *)[self viewWithTag:99] setText:@"获取"];
        [(UILabel *)[self viewWithTag:99] setFont:[UIFont boldSystemFontOfSize:25 * self.scale]];
        [[(UILabel *)[self viewWithTag:99] layer] setBackgroundColor:ThemeRed.CGColor];
        [(UIButton *)[[self viewWithTag:99] superview] setEnabled:YES];
        
        [timer invalidate];
        timer = nil;
    } else {
        [(UILabel *)[self viewWithTag:99] setText:[NSString stringWithFormat:@"%d秒后重新获取", timeLeft]];
    }
}

- (void)memberLogin {
    if (_delegate && [_delegate respondsToSelector:@selector(registerViewDidSuccess)]) {
        [_delegate registerViewDidSuccess];
    }
}

@end
