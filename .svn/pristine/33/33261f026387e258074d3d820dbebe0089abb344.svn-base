//
//  MotherViewController.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/24.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

#import "EditView.h"
#import "ScreenHelper.h"
#import "EnumHelper.h"
#import "SingleCase.h"

#import "BasicInfoAPITool.h"
#import "MemberAPITool.h"
#import "FoodAPITool.h"
#import "LogAPITool.h"
#import "ArticleCoreDataHelper.h"

@protocol MotherViewControllerDelegate;

@interface MotherViewController : UIViewController
<
    UIViewControllerTransitioningDelegate,
    UIGestureRecognizerDelegate,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
>
{
}

@property(nonatomic,weak) id<MotherViewControllerDelegate>      delegate;
@property(nonatomic) BOOL                                       enableGesture;
@property(weak, nonatomic) NSString*                            themeColor;
@property(weak, nonatomic) UIView*                              currentView;
@property(weak, nonatomic) UIView*                              nextView;

//@property(nonatomic,strong)ModalTransitionAnimationPresent *animation;
//@property(nonatomic,strong)ModalTransitionAnimationDismiss *dismation;
//@property(nonatomic,strong)ModalInterActiveTransitionAnimation *interActive;
//@property(nonatomic,strong)ModalMoveTransitionAnimation *interActiveAnimation;

- (void)initFirstViewWithParameter:(NSDictionary *)parameter;
- (void)showNextView;

- (void)pushViewControllerWithViewControllerType:(ViewControllerType)viewControllerType andParameter:(NSDictionary *)parameter;
- (void)popToIndexViewController;

- (void)addOperationToCoredateOperationWithOperation:(NSBlockOperation *)operation;

- (void)wheelViewShouldHide;
- (void)wheelViewTappedButton1;
- (void)wheelViewTappedButton2;
- (void)wheelViewTappedButton3;
- (void)wheelViewTappedButton4;
- (void)wheelViewTappedButton5;

- (void)didTappedVideoWithVideoUrl:(NSString *)url;

- (void)didTappedImagePickerWithTpye:(NSString *)type;

- (void)didTappedEditViewWithTpye:(int)type andMemberEntity:(MemberEntity *)memberEntity;

- (void)didTappedAlertButtonWithTheme:(NSString *)theme andContent:(UIView *)content;

@end

@protocol MotherViewControllerDelegate <NSObject>

//-(void)dismissViewController:(ShopInfoViewController *)mcv;
- (void)pushViewControllerWithViewControllerType:(ViewControllerType)viewControllerType andParameter:(NSDictionary *)parameter;
- (void)popViewControllerWithRatio:(float)ratio;
- (void)popToIndexViewController;

- (void)wheelViewShouldHide;

- (void)alertViewShowWithTheme:(NSString *)theme andContent:(UIView *)content;

@end
