//
//  MenberView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/17.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"

#import "MemberEntity.h"
#import "EnumHelper.h"

#import "MemberCoreDataHelper.h"

@protocol MemberViewDelegate;

@interface MemberView : TempletView <UIGestureRecognizerDelegate, UITextFieldDelegate>
{
    UIColor*                                            color;
    
    UIButton*                                           loginView;
    UIButton*                                           infoView;
    
    UIButton*                                           endTextingButton;
    UITextField*                                        phoneTextField;
    UITextField*                                        passwordTextField;
}

@property (weak, nonatomic) id<MemberViewDelegate>      delegate;
@property (weak, nonatomic) MemberEntity*               memberEntity;

- (id)initWithFrame:(CGRect)frame andColor:(NSString *)themeColor andMemberEntity:(MemberEntity *)member;
- (void)refreshMessageCount:(NSInteger)count;

@end

@protocol MemberViewDelegate <NSObject>

- (void)memberViewDidTapButton:(ViewControllerType)viewControllerType;
- (void)memberViewDidLoginWithPhone:(NSString *)phone andPassword:(NSString *)password;

@end