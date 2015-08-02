//
//  ModalTransitionAnimation.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/20.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ModalTransitionAnimationPresent.h"

@implementation ModalTransitionAnimationPresent

//动画持续时间，单位是秒
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    if ([toVC isKindOfClass:[MemberViewController class]]) {
//        return 0;
//    }
    return 0.4;
}

//动画效果
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //通过键值UITransitionContextToViewControllerKey获取需要呈现的视图控制器toVC
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //得到toVC完全呈现后的frame
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    
    //NSTimeInterval *time = [0.4 doubleValue];
    toVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
//    if ([toVC isKindOfClass:[MemberViewController class]]) {
//        //需要呈现的视图是模态视图，此时将模态视图的frame放到屏幕空间下方，这样才能实现从下方弹出的效果
//        //time = 0;
//    } else {
//        //需要呈现的视图是主视图，此时将主视图的frame放在屏幕空间上方，这样才能实现从上方放下的效果
//        toVC.view.frame = CGRectOffset(finalFrame, -[UIScreen mainScreen].bounds.size.width, 0);
//    }
    toVC.view.frame = CGRectOffset(finalFrame, [UIScreen mainScreen].bounds.size.width, 0);
    
    //切换在containerView中完成，需要将toVC.view加到containerView中
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    //开始动画，这里使用了UIKit提供的弹簧效果动画，usingSpringWithDamping越接近1弹性效果越不明显，此API在IOS7之后才能使用
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         toVC.view.frame = finalFrame;
                         fromVC.view.transform = CGAffineTransformMakeScale(300.f / 320.f, 548.f / 568.f);
                         fromVC.view.alpha = 0.5;
                     } completion:^(BOOL finished) {
                         //通知系统动画切换完成
                         [transitionContext completeTransition:YES];
                         //[toVC.view insertSubview:fromVC.view atIndex:0];
                     }];
}

@end
