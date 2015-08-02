//
//  MemberInfoView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/19.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "MemberInfoView.h"

@implementation MemberInfoView

- (void)getInfo:(MemberEntity *)memberEntity {
    _memberEntity = memberEntity;
    
    UIScrollView *memberScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleHeight, self.frame.size.width, self.frame.size.height - self.titleHeight)];
    [self addSubview:memberScrollView];
    
    UIButton *changeImageButton = [[UIButton alloc] initWithFrame:CGRectMake(self.center.x, 135 * self.scale, 130 * self.scale, 25 * self.scale)];
    [changeImageButton addTarget:self action:@selector(tappedImageButton) forControlEvents:UIControlEventTouchUpInside];
    [changeImageButton setExclusiveTouch:YES];
    [memberScrollView addSubview:changeImageButton];
    
    UILabel *changeImageLabel = [[UILabel alloc] initWithFrame:changeImageButton.bounds];
    changeImageLabel.layer.cornerRadius = changeImageLabel.frame.size.height / 2;
    changeImageLabel.layer.backgroundColor = Color(255, 151, 174, 1).CGColor;
    changeImageLabel.text = @"            修改头像";
    changeImageLabel.textColor = Color(62, 60, 60, 1);
    changeImageLabel.textAlignment = NSTextAlignmentCenter;
    changeImageLabel.font = [UIFont systemFontOfSize:13 * self.scale];
    [changeImageButton addSubview:changeImageLabel];
    
    UIImageView *memberPortrait = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 130 * self.scale, 130 * self.scale)];
    memberPortrait.layer.cornerRadius = memberPortrait.frame.size.height / 2;
    memberPortrait.layer.borderColor = ThemeRed.CGColor;
    memberPortrait.layer.borderWidth = 8.f * self.scale;
    memberPortrait.contentMode = UIViewContentModeScaleAspectFill;
    memberPortrait.center = CGPointMake(self.center.x, 95 * self.scale);
    memberPortrait.image = [UIImage imageNamed:@"MemberDefaultPortrait"];//默认头像
    memberPortrait.tag = 1;
    memberPortrait.clipsToBounds = YES;
    [memberScrollView addSubview:memberPortrait];
    if (_memberEntity.login) {
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
        }
    }
    

    UIButton *memberNameButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 180 * self.scale, self.frame.size.width, 70 * self.scale)];
    memberNameButton.exclusiveTouch = YES;
    memberNameButton.tag = 12;
    [memberNameButton addTarget:self action:@selector(tappedEditButton:) forControlEvents:UIControlEventTouchUpInside];
    [memberScrollView addSubview:memberNameButton];
    
    UIView *changeNameView = [[UIView alloc] initWithFrame:CGRectMake(self.center.x, 2.5 * self.scale, self.center.x - 35 * self.scale, 45 * self.scale)];
    changeNameView.layer.cornerRadius = changeNameView.frame.size.height / 2;
    changeNameView.backgroundColor = Color(255, 151, 174, 1);
    changeNameView.userInteractionEnabled = NO;
    [memberNameButton addSubview:changeNameView];
    
    UILabel *changeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(changeNameView.frame.size.width - 25 * self.scale, 0, 25 * self.scale, changeNameView.frame.size.height)];
    changeNameLabel.text = @"修\n改";
    changeNameLabel.textColor = Color(62, 60, 60, 1);
    changeNameLabel.numberOfLines = 0;
    changeNameLabel.font = [UIFont systemFontOfSize:13 * self.scale];
    [changeNameView addSubview:changeNameLabel];
    
    UILabel *memberNickName = [[UILabel alloc] initWithFrame:CGRectMake(50 * self.scale, 0, 255 * self.scale, 50 * self.scale)];
    memberNickName.layer.cornerRadius = memberNickName.frame.size.height / 2;
    memberNickName.layer.backgroundColor = ThemeRed.CGColor;
    memberNickName.text = _memberEntity.nickName;
    memberNickName.textColor = AbsoluteWhite;
    memberNickName.textAlignment = NSTextAlignmentCenter;
    memberNickName.font = [UIFont systemFontOfSize:28 * self.scale];
    memberNickName.tag = 2;
    [memberNameButton addSubview:memberNickName];
    
    UILabel *memberName = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 100 * self.scale) / 2, 45 * self.scale, 100 * self.scale, 25 * self.scale)];
    memberName.layer.cornerRadius = memberName.frame.size.height / 2;
    memberName.layer.backgroundColor = Color(255, 151, 174, 1).CGColor;
    //memberName.text = _memberEntity.name;
    memberName.textColor = Color(62, 60, 60, 1);
    memberName.textAlignment = NSTextAlignmentCenter;
    memberName.font = [UIFont systemFontOfSize:18 * self.scale];
    memberName.tag = 3;
    [memberNameButton addSubview:memberName];
    
    UIButton *memberGenderButton = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 220 * self.scale) / 2, 280 * self.scale, 220 * self.scale, 35 * self.scale)];
    memberGenderButton.layer.cornerRadius = memberGenderButton.frame.size.height / 2;
    memberGenderButton.layer.borderColor = ThemeRed.CGColor;
    memberGenderButton.layer.borderWidth = 2.f * self.scale;
    memberGenderButton.exclusiveTouch = YES;
    memberGenderButton.tag = 13;
    [memberGenderButton addTarget:self action:@selector(tappedEditButton:) forControlEvents:UIControlEventTouchUpInside];
    [memberScrollView addSubview:memberGenderButton];
    
    UILabel *memberGenderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.scale, 0, 60 * self.scale, 35 * self.scale)];
    memberGenderLabel.text = @"性别";
    memberGenderLabel.textColor = ThemeRed;
    memberGenderLabel.font = [UIFont systemFontOfSize:18 * self.scale];
    [memberGenderButton addSubview:memberGenderLabel];
    
    UILabel *memberGender = [[UILabel alloc] initWithFrame:CGRectMake(80 * self.scale, 0, 120 * self.scale, 35 * self.scale)];
    memberGender.text = _memberEntity.gender;
    memberGender.textColor = Color(62, 60, 60, 1);
    memberGender.textAlignment = NSTextAlignmentRight;
    memberGender.font = [UIFont systemFontOfSize:18 * self.scale];
    memberGender.tag = 4;
    [memberGenderButton addSubview:memberGender];
    
    UIImageView *memberGenderImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MemberView_Tri_Red"]];
    [memberGenderImage setFrame:CGRectMake(205 * self.scale, 10 * self.scale, 9 * self.scale, 15 * self.scale)];
    [memberGenderButton addSubview:memberGenderImage];
    
    UIButton *memberPhoneButton = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 220 * self.scale) / 2, 340 * self.scale, 220 * self.scale, 35 * self.scale)];
    memberPhoneButton.layer.cornerRadius = memberPhoneButton.frame.size.height / 2;
    memberPhoneButton.layer.borderColor = ThemeRed.CGColor;
    memberPhoneButton.layer.borderWidth = 2.f * self.scale;
    memberPhoneButton.exclusiveTouch = YES;
    memberPhoneButton.tag = 14;
    [memberPhoneButton addTarget:self action:@selector(tappedEditButton:) forControlEvents:UIControlEventTouchUpInside];
    [memberScrollView addSubview:memberPhoneButton];
    
    UILabel *memberPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.scale, 0, 60 * self.scale, 35 * self.scale)];
    memberPhoneLabel.text = @"手机";
    memberPhoneLabel.textColor = ThemeRed;
    memberPhoneLabel.font = [UIFont systemFontOfSize:18 * self.scale];
    [memberPhoneButton addSubview:memberPhoneLabel];
    
    UILabel *memberPhone = [[UILabel alloc] initWithFrame:CGRectMake(80 * self.scale, 0, 120 * self.scale, 35 * self.scale)];
    memberPhone.text = _memberEntity.phone;
    memberPhone.textColor = Color(62, 60, 60, 1);
    memberPhone.textAlignment = NSTextAlignmentRight;
    memberPhone.font = [UIFont systemFontOfSize:18 * self.scale];
    memberPhone.tag = 5;
    [memberPhoneButton addSubview:memberPhone];
    
//    UIImageView *memberPhoneImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MemberView_Tri_Red"]];
//    [memberPhoneImage setFrame:CGRectMake(205 * self.scale, 10 * self.scale, 9 * self.scale, 15 * self.scale)];
//    [memberPhoneButton addSubview:memberPhoneImage];
    
    UIButton *memberPasswordButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 120 * self.scale, 30 * self.scale, 190 * self.scale, 35 * self.scale)];
    memberPasswordButton.layer.cornerRadius = memberPasswordButton.frame.size.height / 2;
    memberPasswordButton.layer.backgroundColor = ThemeRed.CGColor;
    memberPasswordButton.exclusiveTouch = YES;
    [memberPasswordButton addTarget:self action:@selector(tappedResetButton) forControlEvents:UIControlEventTouchUpInside];
    [memberScrollView addSubview:memberPasswordButton];
    
    UILabel *changePasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * self.scale, 0 * self.scale, 100 * self.scale, 35 * self.scale)];
    changePasswordLabel.text = @"更改密码";
    changePasswordLabel.textColor = AbsoluteWhite;
    changePasswordLabel.textAlignment = NSTextAlignmentLeft;
    changePasswordLabel.font = [UIFont systemFontOfSize:22 * self.scale];
    [memberPasswordButton addSubview:changePasswordLabel];
    
    UIButton *memberAddressButton = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 320 * self.scale) / 2, 400 * self.scale, 320 * self.scale, 60 * self.scale)];
    memberAddressButton.layer.cornerRadius = memberAddressButton.frame.size.height / 2;
    memberAddressButton.layer.borderColor = ThemeRed.CGColor;
    memberAddressButton.layer.borderWidth = 2.f * self.scale;
    memberAddressButton.exclusiveTouch = YES;
    memberAddressButton.tag = 15;
    [memberAddressButton addTarget:self action:@selector(tappedEditButton:) forControlEvents:UIControlEventTouchUpInside];
    [memberScrollView addSubview:memberAddressButton];
    
    UILabel *memberAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.scale, 0, 60 * self.scale, 60 * self.scale)];
    memberAddressLabel.text = @"地址";
    memberAddressLabel.textColor = ThemeRed;
    memberAddressLabel.font = [UIFont systemFontOfSize:18 * self.scale];
    [memberAddressButton addSubview:memberAddressLabel];
    
    UILabel *memberAddress = [[UILabel alloc] initWithFrame:CGRectMake(80 * self.scale, 0, 220 * self.scale, 60 * self.scale)];
    memberAddress.text = [NSString stringWithFormat:@"%@%@%@\n%@",
                          _memberEntity.province.length > 0 ? [NSString stringWithFormat:@"%@省", _memberEntity.province] : @"",
                          _memberEntity.city.length > 0 ? [NSString stringWithFormat:@"%@市", _memberEntity.city] : @"",
                          _memberEntity.area.length > 0 ? [NSString stringWithFormat:@"%@区", _memberEntity.area] : @"",
                          _memberEntity.address];
    memberAddress.textColor = Color(62, 60, 60, 1);
    memberAddress.textAlignment = NSTextAlignmentRight;
    memberAddress.font = [UIFont systemFontOfSize:18 * self.scale];
    memberAddress.numberOfLines = 2;
    memberAddress.tag = 6;
    [memberAddressButton addSubview:memberAddress];
    
    UIImageView *memberAddressImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MemberView_Tri_Red"]];
    [memberAddressImage setFrame:CGRectMake(305 * self.scale, 22.5 * self.scale, 9 * self.scale, 15 * self.scale)];
    [memberAddressButton addSubview:memberAddressImage];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getImage:) name:@"getImage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMemberInfo:) name:@"updateMemberInfo" object:nil];
}

#pragma mark - Button Events

- (void)tappedResetButton {
    if (_delegate && [_delegate respondsToSelector:@selector(memberInfoViewDidResetPasswordButton)]) {
        [_delegate memberInfoViewDidResetPasswordButton];
    }
}

- (void)tappedImageButton {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"相册选取", @"拍照", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self];
}

- (void)tappedEditButton:(UIButton *)button {
    switch (button.tag) {
        case 12:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(memberInfoViewDidEditButtonWithType:andMemberEntity:)]) {
                [_delegate memberInfoViewDidEditButtonWithType:0 andMemberEntity:_memberEntity];
            }
            break;
        }
        case 13:
            if (_delegate && [_delegate respondsToSelector:@selector(memberInfoViewDidEditButtonWithType:andMemberEntity:)]) {
                [_delegate memberInfoViewDidEditButtonWithType:1 andMemberEntity:_memberEntity];
            }
            break;
        case 14:
//            if (_delegate && [_delegate respondsToSelector:@selector(memberInfoViewDidEditButtonWithType:andMemberEntity:)]) {
//                [_delegate memberInfoViewDidEditButtonWithType:2 andMemberEntity:_memberEntity];
//            }
            break;
        case 15:
            if (_delegate && [_delegate respondsToSelector:@selector(memberInfoViewDidEditButtonWithType:andMemberEntity:)]) {
                [_delegate memberInfoViewDidEditButtonWithType:4 andMemberEntity:_memberEntity];
            }
            break;
        default:
            break;
    }
}

#pragma mark - Action Sheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(memberInfoViewDidImageButtonWithType:)]) {
                [_delegate memberInfoViewDidImageButtonWithType:@"album"];
            }
            break;
        }
        case 1:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(memberInfoViewDidImageButtonWithType:)]) {
                [_delegate memberInfoViewDidImageButtonWithType:@"camera"];
            }
            break;
        }
        default:
            break;
    }
    
}

#pragma mark - Notification Center 

- (void)getImage:(id)sender {
    _memberEntity.portrait = UIImageJPEGRepresentation((UIImage *)[[sender object] objectForKey:@"image"], 1);
    [(UIImageView *)[self viewWithTag:1] setImage:(UIImage *)[[sender object] objectForKey:@"image"]];
    
    if (_delegate && [_delegate respondsToSelector:@selector(memberInfoViewDidSavePortrait:)]) {
        [_delegate memberInfoViewDidSavePortrait:_memberEntity];
    }
}

- (void)updateMemberInfo:(NSNotification *)notification {
    _memberEntity = [notification object];
    [(UILabel *)[self viewWithTag:2] setText:_memberEntity.nickName];
    //[(UILabel *)[self viewWithTag:3] setText:_memberEntity.name];
    [(UILabel *)[self viewWithTag:4] setText:_memberEntity.gender];
    [(UILabel *)[self viewWithTag:5] setText:_memberEntity.phone];
    [(UILabel *)[self viewWithTag:6] setText:[NSString stringWithFormat:@"%@%@%@\n%@",
                                              _memberEntity.province.length > 0 ? [NSString stringWithFormat:@"%@省", _memberEntity.province] : @"",
                                              _memberEntity.city.length > 0 ? [NSString stringWithFormat:@"%@市", _memberEntity.city] : @"",
                                              _memberEntity.area.length > 0 ? [NSString stringWithFormat:@"%@区", _memberEntity.area] : @"",
                                              _memberEntity.address]];
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(memberInfoViewDidSaveMemberEntity:)]) {
        [_delegate memberInfoViewDidSaveMemberEntity:_memberEntity];
    }
}

@end
