//
//  MemberInfoView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/19.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"

#import "MemberEntity.h"

#import "MemberCoreDataHelper.h"

@protocol MemberInfoViewDelegate;

@interface MemberInfoView : TempletView<UIActionSheetDelegate>


@property (weak, nonatomic) id<MemberInfoViewDelegate>              delegate;
@property (retain,nonatomic) MemberEntity*                          memberEntity;

- (void)getInfo:(MemberEntity *)memberEntity;

@end

@protocol MemberInfoViewDelegate <NSObject>

- (void)memberInfoViewDidResetPasswordButton;
- (void)memberInfoViewDidImageButtonWithType:(NSString *)type;
- (void)memberInfoViewDidEditButtonWithType:(int)type andMemberEntity:(MemberEntity *)memberEntity;
- (void)memberInfoViewDidSaveMemberEntity:(MemberEntity *)memberEntity;
- (void)memberInfoViewDidSavePortrait:(MemberEntity *)memberEntity;

@end