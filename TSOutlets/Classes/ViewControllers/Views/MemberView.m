//
//  MenberView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/17.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "MemberView.h"

@implementation MemberView

- (id)initWithFrame:(CGRect)frame andColor:(NSString *)themeColor andMemberEntity:(MemberEntity *)member
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = AbsoluteClear;
        
        color = ThemeBlue;
        if ([themeColor isEqualToString:@"Red"]) {
            color = ThemeRed;
        } else if ([themeColor isEqualToString:@"Yellow"]) {
            color = ThemeYellow;
        }
        
        float s = 1.f;
        if (self.frame.size.height == 480) s = 480.f / 568.f;
        
        _memberEntity = member;
        
        UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * (1 - s), 0, 800 * self.scale * s, 800 * self.scale * s)];
        [backImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"MemberView_%@", themeColor]]];
        [backImage setUserInteractionEnabled:YES];
        [self addSubview:backImage];
        
        UIButton *memberButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120 * self.scale * s, 120 * self.scale * s)];
        [memberButton setCenter:CGPointMake(270 * self.scale * s, 85 * self.scale * s)];
        [memberButton setExclusiveTouch:YES];
        [memberButton setTag:0];
        [memberButton addTarget:self action:@selector(tappedMemberButton:) forControlEvents:UIControlEventTouchUpInside];
        //[memberButton setBackgroundColor:ThemeRed];
        [backImage addSubview:memberButton];
        
        UIButton *collectionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90 * self.scale * s, 90 * self.scale * s)];
        [collectionButton setCenter:CGPointMake(160 * self.scale * s, 160 * self.scale * s)];
        [collectionButton setExclusiveTouch:YES];
        [collectionButton setTag:1];
        [collectionButton addTarget:self action:@selector(tappedMemberButton:) forControlEvents:UIControlEventTouchUpInside];
        //[collectionButton setBackgroundColor:ThemeRed];
        [backImage addSubview:collectionButton];
        
        UIButton *messageButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90 * self.scale * s, 90 * self.scale * s)];
        [messageButton setCenter:CGPointMake(80 * self.scale * s, 270 * self.scale * s)];
        [messageButton setExclusiveTouch:YES];
        [messageButton setTag:2];
        [messageButton addTarget:self action:@selector(tappedMemberButton:) forControlEvents:UIControlEventTouchUpInside];
        //[messageButton setBackgroundColor:ThemeRed];
        [backImage addSubview:messageButton];
        
        UIButton *parkButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90 * self.scale * s, 90 * self.scale * s)];
        [parkButton setCenter:CGPointMake(50 * self.scale * s, 400 * self.scale * s)];
        [parkButton setExclusiveTouch:YES];
        [parkButton setTag:3];
        [parkButton addTarget:self action:@selector(tappedMemberButton:) forControlEvents:UIControlEventTouchUpInside];
        //[parkButton setBackgroundColor:ThemeRed];
        [backImage addSubview:parkButton];
        
        UIButton *foodButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90 * self.scale * s, 90 * self.scale * s)];
        [foodButton setCenter:CGPointMake(80 * self.scale * s, 520 * self.scale * s)];
        [foodButton setExclusiveTouch:YES];
        [foodButton setTag:4];
        [foodButton addTarget:self action:@selector(tappedMemberButton:) forControlEvents:UIControlEventTouchUpInside];
        //[foodButton setBackgroundColor:ThemeRed];
        [backImage addSubview:foodButton];
        
        UIButton *logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90 * self.scale * s, 90 * self.scale * s)];
        [logoutButton setCenter:CGPointMake(160 * self.scale * s, 630 * self.scale * s)];
        [logoutButton setExclusiveTouch:YES];
        [logoutButton setTag:7];
        [logoutButton addTarget:self action:@selector(tappedLogoutButton:) forControlEvents:UIControlEventTouchUpInside];
        //[logoutButton setBackgroundColor:ThemeRed];
        [backImage addSubview:logoutButton];
        
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 95 * self.scale * s, 50 * self.scale * s)];
        messageLabel.text = @"0";
        messageLabel.textColor = AbsoluteWhite;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont boldSystemFontOfSize:24 * self.scale];
        messageLabel.tag = 10;
        [messageButton addSubview:messageLabel];
        
        if (_memberEntity.login) {
            [self initInfoView];
            
            UIImageView *memberPortrait = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 104 * self.scale * s, 104 * self.scale * s)];
            [memberPortrait setCenter:CGPointMake(270 * self.scale * s, 83.5 * self.scale * s)];
            memberPortrait.layer.cornerRadius = memberPortrait.frame.size.height / 2;
            memberPortrait.contentMode = UIViewContentModeScaleAspectFill;
            memberPortrait.image = [UIImage imageNamed:@"MemberDefaultPortrait"];//默认头像
            memberPortrait.tag = 11;
            memberPortrait.clipsToBounds = YES;
            [backImage addSubview:memberPortrait];
            
            if (_memberEntity.portrait) {
                memberPortrait.image = [UIImage imageWithData:_memberEntity.portrait];
            } else if (_memberEntity.image) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    _memberEntity.portrait = [NSData dataWithContentsOfURL:[NSURL URLWithString:_memberEntity.image]];
                    [MemberCoreDataHelper updateMemberInfo:_memberEntity];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        memberPortrait.image = [UIImage imageWithData:_memberEntity.portrait];
                    });
                });
            } else {
                
            }
        } else {
            [self initLoginView];
            
            UIImageView *memberPortrait = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 104 * self.scale * s, 104 * self.scale * s)];
            [memberPortrait setCenter:CGPointMake(270 * self.scale * s, 83.5 * self.scale * s)];
            memberPortrait.layer.cornerRadius = memberPortrait.frame.size.height / 2;
            memberPortrait.contentMode = UIViewContentModeScaleAspectFill;
            memberPortrait.image = [UIImage imageNamed:@"MemberDefaultPortrait"];//默认头像
            memberPortrait.tag = 11;
            memberPortrait.clipsToBounds = YES;
            [backImage addSubview:memberPortrait];
        }
    }
    return self;
}

- (IBAction)tappedMemberButton:(id)sender {
    switch ([sender tag]) {
        case 0:
            if (_delegate && [_delegate respondsToSelector:@selector(memberViewDidTapButton:)]) {
                [_delegate memberViewDidTapButton:ViewControllerTypeMemberInfo];
            }
            break;
        case 1:
            if (_delegate && [_delegate respondsToSelector:@selector(memberViewDidTapButton:)]) {
                [_delegate memberViewDidTapButton:ViewControllerTypeCollection];
            }
            break;
        case 2:
            if (_delegate && [_delegate respondsToSelector:@selector(memberViewDidTapButton:)]) {
                [_delegate memberViewDidTapButton:ViewControllerTypeMessage];
            }
            break;
        case 4:
            if (_delegate && [_delegate respondsToSelector:@selector(memberViewDidTapButton:)]) {
                [_delegate memberViewDidTapButton:ViewControllerTypeFood];
            }
            break;
        case 5:
            if (_delegate && [_delegate respondsToSelector:@selector(memberViewDidTapButton:)]) {
                [_delegate memberViewDidTapButton:ViewControllerTypeRegister];
            }
            break;
        case 6:
            if (_delegate && [_delegate respondsToSelector:@selector(memberViewDidTapButton:)]) {
                [_delegate memberViewDidTapButton:ViewControllerTypeReset];
            }
            break;
        case 8:
            if (_delegate && [_delegate respondsToSelector:@selector(memberViewDidTapButton:)]) {
                [_delegate memberViewDidTapButton:ViewControllerTypeOnline];
            }
            break;
        case 9:
            if (_delegate && [_delegate respondsToSelector:@selector(memberViewDidTapButton:)]) {
                [_delegate memberViewDidTapButton:ViewControllerTypeOffline];
            }
            break;
        default:
        {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"敬请期待" message:@"对不起，该功能暂未开放。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"该功能暂未开放，敬请期待！"];
            break;
        }
    }
}

- (IBAction)tappedLoginButton:(id)sender {
    NSString * MOBILE = @"^1(3[0-9]|5[0-9]|8[0-9])\\d{8}$";//总况
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:phoneTextField.text] == NO)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"请输入正确的手机号！"];
        return;
    }
    
    if (passwordTextField.text.length == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"请输入密码！"];
        return;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"正在登陆……"];
    
    [phoneTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    
    if (_delegate && [_delegate respondsToSelector:@selector(memberViewDidLoginWithPhone:andPassword:)]) {
        [_delegate memberViewDidLoginWithPhone:phoneTextField.text andPassword:passwordTextField.text];
    }
}

- (IBAction)tappedLogoutButton:(id)sender {
    infoView.alpha = 0;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"memberLogout" object:nil];
    
    if (!loginView) {
        [self initLoginView];
    } else {
        loginView.alpha = 1;
    }
    
    [(UIImageView *)[self viewWithTag:11] setImage:[UIImage imageNamed:@"MemberDefaultPortrait"]];//默认头像
}

- (void)refreshMessageCount:(NSInteger)count {
    //NSString *sum = [NSString stringWithFormat:@"%ld", [[(UILabel *)[self viewWithTag:10] text] intValue] + count];
    [(UILabel *)[self viewWithTag:10] setText:count > 99 ? @"99+" : [NSString stringWithFormat:@"%ld", (long)count]];
}

#pragma mark - Login & Info View Init

- (void)initInfoView {
    float s = 1.f;
    if (self.frame.size.height == 480) s = 480.f / 568.f;
    
    infoView = [[UIButton alloc] initWithFrame:CGRectMake(190 * self.scale * s + self.frame.size.width * (1 - s), 270 * self.scale * s, 180 * self.scale * s, 310 * self.scale * s)];
    [self addSubview:infoView];
    
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120 * self.scale * s, 20 * self.scale * s)];
    welcomeLabel.text = @"欢迎回来";
    welcomeLabel.textColor = AbsoluteWhite;
    welcomeLabel.font = [UIFont systemFontOfSize:18 * self.scale * s];
    [infoView addSubview:welcomeLabel];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20 * self.scale * s, 180 * self.scale * s, 40 * self.scale * s)];
    nameLabel.text = _memberEntity.nickName;
    nameLabel.textColor = AbsoluteWhite;
    nameLabel.font = [UIFont systemFontOfSize:30 * self.scale * s];
    [infoView addSubview:nameLabel];
    
    UIButton *memberButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120 * self.scale * s, 60 * self.scale * s)];
    [memberButton setTag:0];
    [memberButton setExclusiveTouch:YES];
    [memberButton addTarget:self action:@selector(tappedMemberButton:) forControlEvents:UIControlEventTouchUpInside];
    [infoView addSubview:memberButton];
    
    UILabel *onlinePointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(-30 * self.scale * s, 100 * self.scale * s, 100 * self.scale * s, 50 * self.scale * s)];
    onlinePointsLabel.text = _memberEntity.onlinePoint;
    onlinePointsLabel.textColor = AbsoluteWhite;
    onlinePointsLabel.textAlignment = NSTextAlignmentRight;
    onlinePointsLabel.font = [UIFont systemFontOfSize:25 * self.scale];
    [infoView addSubview:onlinePointsLabel];
    
    UIButton *onlinePointsButton = [[UIButton alloc] initWithFrame:CGRectMake(80 * self.scale * s, 90 * self.scale * s, 100 * self.scale * s, 50 * self.scale * s)];
    [onlinePointsButton setTag:8];
    [onlinePointsButton setExclusiveTouch:YES];
    [onlinePointsButton addTarget:self action:@selector(tappedMemberButton:) forControlEvents:UIControlEventTouchUpInside];
    [infoView addSubview:onlinePointsButton];
    
    UILabel *onlinePointsNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 * self.scale * s, 0 * self.scale * s, 80 * self.scale * s, 20 * self.scale * s)];
    onlinePointsNumberLabel.text = _memberEntity.onlineNumber;
    onlinePointsNumberLabel.textColor = AbsoluteWhite;
    onlinePointsNumberLabel.textAlignment = NSTextAlignmentCenter;
    onlinePointsNumberLabel.font = [UIFont boldSystemFontOfSize:14 * self.scale * s];
    [onlinePointsButton addSubview:onlinePointsNumberLabel];
    
    UILabel *onlinePointsEntranceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 * self.scale * s, 20 * self.scale * s, 80 * self.scale * s, 30 * self.scale * s)];
    onlinePointsEntranceLabel.text = @"线上积分";
    onlinePointsEntranceLabel.textColor = AbsoluteWhite;
    onlinePointsEntranceLabel.textAlignment = NSTextAlignmentCenter;
    onlinePointsEntranceLabel.font = [UIFont boldSystemFontOfSize:16 * self.scale];
    [onlinePointsButton addSubview:onlinePointsEntranceLabel];
    
    UIImageView *onlinePointsEntranceImage = [[UIImageView alloc] initWithFrame:CGRectMake(80 * self.scale * s, 10 * self.scale * s, 8 * self.scale * s, 30 * self.scale * s)];
    [onlinePointsEntranceImage setImage:[UIImage imageNamed:@"MemberView_SideTriangle"]];
    [onlinePointsButton addSubview:onlinePointsEntranceImage];
    
    UILabel *offlinePointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(-30 * self.scale * s, 180 * self.scale * s, 100 * self.scale * s, 50 * self.scale * s)];
    offlinePointsLabel.text = _memberEntity.offlinePoint;
    offlinePointsLabel.textColor = AbsoluteWhite;
    offlinePointsLabel.textAlignment = NSTextAlignmentRight;
    offlinePointsLabel.font = [UIFont systemFontOfSize:25 * self.scale];
    [infoView addSubview:offlinePointsLabel];
    
    UIButton *offlinePointsButton = [[UIButton alloc] initWithFrame:CGRectMake(80 * self.scale * s, 170 * self.scale * s, 100 * self.scale * s, 50 * self.scale * s)];
    [offlinePointsButton setTag:9];
    [offlinePointsButton setExclusiveTouch:YES];
    [offlinePointsButton addTarget:self action:@selector(tappedMemberButton:) forControlEvents:UIControlEventTouchUpInside];
    [infoView addSubview:offlinePointsButton];
    
    UILabel *offlinePointsNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 * self.scale * s, 0 * self.scale * s, 80 * self.scale * s, 20 * self.scale * s)];
    offlinePointsNumberLabel.text = _memberEntity.offlineNumber;
    offlinePointsNumberLabel.textColor = AbsoluteWhite;
    offlinePointsNumberLabel.textAlignment = NSTextAlignmentCenter;
    offlinePointsNumberLabel.font = [UIFont boldSystemFontOfSize:14 * self.scale * s];
    [offlinePointsButton addSubview:offlinePointsNumberLabel];
    
    UILabel *offlinePointsEntranceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 * self.scale * s, 20 * self.scale * s, 80 * self.scale * s, 30 * self.scale * s)];
    offlinePointsEntranceLabel.text = @"线下积分";
    offlinePointsEntranceLabel.textColor = AbsoluteWhite;
    offlinePointsEntranceLabel.textAlignment = NSTextAlignmentCenter;
    offlinePointsEntranceLabel.font = [UIFont boldSystemFontOfSize:16 * self.scale];
    [offlinePointsButton addSubview:offlinePointsEntranceLabel];
    
    UIImageView *offlinePointsEntranceImage = [[UIImageView alloc] initWithFrame:CGRectMake(80 * self.scale * s, 10 * self.scale * s, 8 * self.scale * s, 30 * self.scale * s)];
    [offlinePointsEntranceImage setImage:[UIImage imageNamed:@"MemberView_SideTriangle"]];
    [offlinePointsButton addSubview:offlinePointsEntranceImage];
}

- (void)initLoginView {
    float s = 1.f;
    if (self.frame.size.height == 480) s = 480.f / 568.f;
    
    //登陆界面
    
    endTextingButton = [[UIButton alloc] initWithFrame:self.bounds];
    [endTextingButton setEnabled:NO];
    [endTextingButton setExclusiveTouch:YES];
    [endTextingButton addTarget:self action:@selector(textFieldShouldReturn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:endTextingButton];
    
    loginView = [[UIButton alloc] initWithFrame:CGRectMake(190 * self.scale * s + self.frame.size.width * (1 - s), 270 * self.scale * s, 180 * self.scale * s, 310 * self.scale * s)];
    [self addSubview:loginView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10 * self.scale * s, 30 * self.scale * s)];
    
    phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0 * self.scale * s, 180 * self.scale * s, 35 * self.scale * s)];
    phoneTextField.layer.cornerRadius = phoneTextField.frame.size.height / 2.f;
    phoneTextField.layer.borderColor = Color(143, 122, 122, 1).CGColor;
    phoneTextField.layer.borderWidth = 1.5f * self.scale;
    phoneTextField.leftView = view;
    phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    [phoneTextField setPlaceholder:@"手机号"];
    [phoneTextField setFont:[UIFont systemFontOfSize:16 * self.scale]];
    [phoneTextField setBackgroundColor:AbsoluteWhite];
    [phoneTextField setDelegate:self];
    [phoneTextField setReturnKeyType:UIReturnKeyDone];
    [phoneTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [phoneTextField setTintColor:color];
    [phoneTextField setTextColor:color];
    [loginView addSubview:phoneTextField];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10 * self.scale * s, 30 * self.scale * s)];
    
    passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 50 * self.scale * s, 180 * self.scale * s, 35 * self.scale * s)];
    passwordTextField.layer.cornerRadius = phoneTextField.frame.size.height / 2.f;
    passwordTextField.layer.borderColor = Color(143, 122, 122, 1).CGColor;
    passwordTextField.layer.borderWidth = 1.5f * self.scale;
    passwordTextField.leftView = view2;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    [passwordTextField setPlaceholder:@"密码"];
    [passwordTextField setSecureTextEntry:YES];
    [passwordTextField setFont:[UIFont systemFontOfSize:16 * self.scale]];
    [passwordTextField setBackgroundColor:AbsoluteWhite];
    [passwordTextField setDelegate:self];
    [passwordTextField setReturnKeyType:UIReturnKeyDone];
    [passwordTextField setKeyboardType:UIKeyboardTypeDefault];
    [passwordTextField setTintColor:color];
    [passwordTextField setTextColor:color];
    [loginView addSubview:passwordTextField];
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 110 * self.scale * s, 180 * self.scale * s, 60 * self.scale * s)];
    [loginButton addTarget:self action:@selector(tappedLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setExclusiveTouch:YES];
    [loginView addSubview:loginButton];
    
    UILabel *loginLabel = [[UILabel alloc] initWithFrame:loginButton.bounds];
    loginLabel.layer.cornerRadius = loginLabel.frame.size.height / 2.f;
    loginLabel.layer.backgroundColor = Color(243, 244, 153, 1).CGColor;
    loginLabel.text = @"登陆";
    loginLabel.textColor = color;
    loginLabel.textAlignment = NSTextAlignmentCenter;
    loginLabel.font = [UIFont systemFontOfSize:50 * self.scale];
    [loginButton addSubview:loginLabel];
    
    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 185 * self.scale * s, 180 * self.scale * s, 45 * self.scale * s)];
    [registerButton setTag:5];
    [registerButton setExclusiveTouch:YES];
    [registerButton addTarget:self action:@selector(tappedMemberButton:) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:registerButton];
    
    UILabel *registerLabel = [[UILabel alloc] initWithFrame:registerButton.bounds];
    registerLabel.layer.cornerRadius = registerLabel.frame.size.height / 2.f;
    registerLabel.layer.backgroundColor = AbsoluteWhite.CGColor;
    registerLabel.text = @"注册";
    registerLabel.textColor = color;
    registerLabel.textAlignment = NSTextAlignmentCenter;
    registerLabel.font = [UIFont systemFontOfSize:30 * self.scale];
    [registerButton addSubview:registerLabel];
    
    UIButton *forgottenButton = [[UIButton alloc] initWithFrame:CGRectMake(80 * self.scale * s, 290 * self.scale * s, 100 * self.scale * s, 25 * self.scale * s)];
    [forgottenButton setTag:6];
    [forgottenButton setExclusiveTouch:YES];
    [forgottenButton addTarget:self action:@selector(tappedMemberButton:) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:forgottenButton];
    
    UILabel *forgottenLabel = [[UILabel alloc] initWithFrame:forgottenButton.bounds];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"忘记密码"]];
    NSRange contentRange = {0,[content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    forgottenLabel.attributedText = content;
    forgottenLabel.textColor = AbsoluteWhite;
    forgottenLabel.textAlignment = NSTextAlignmentRight;
    forgottenLabel.font = [UIFont systemFontOfSize:18 * self.scale];
    [forgottenButton addSubview:forgottenLabel];
}

#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [phoneTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [endTextingButton setEnabled:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [endTextingButton setEnabled:NO];
}

@end
