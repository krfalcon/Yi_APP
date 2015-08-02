//
//  MemberViewController.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/23.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberView.h"
#import "MemberAPITool.h"
#import "ServiceAPITool.h"
#import "EnumHelper.h"

@protocol MemberViewControllerDelegate;

@interface MemberViewController : UIViewController
<UIGestureRecognizerDelegate, MemberViewDelegate>
{
    MemberView      *memberView;
    UIView          *shadowView;
    
    MemberAPITool*                                      memberAPI;
}

@property(nonatomic,weak) id<MemberViewControllerDelegate>      delegate;
@property(strong, nonatomic) NSString*                          themeColor;
@property(strong, nonatomic) MemberEntity*                      memberEntity;

@end

@protocol MemberViewControllerDelegate <NSObject>

- (void)pushViewControllerWithViewControllerType:(ViewControllerType)viewControllerType andParameter:(NSDictionary *)parameter;

@end