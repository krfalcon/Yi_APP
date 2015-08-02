//
//  ModalTransitionAnimationDismiss.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/20.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ModalTransitionAnimationDismiss.h"

@implementation ModalTransitionAnimationDismiss

//动画持续时间，单位是秒
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    //NSLog(@"%d",[SingleCase singleCase].backNum);
    return 0.4;
}

//动画效果
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //通过键值UITransitionContextToViewControllerKey获取需要呈现的视图控制器toVC
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //得到toVC完全呈现后的frame
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];

    //切换在containerView中完成，需要将toVC.view加到containerView中
    UIView *containerView = [transitionContext containerView];
    //[containerView addSubview:fromVC.view];
    [containerView insertSubview:toVC.view atIndex:0];
    
//    if ([toVC isMemberOfClass:[ViewController class]]) {
//        toVC.view.transform = CGAffineTransformMakeScale(1, 1);
//    }
    
    //开始动画，这里使用了UIKit提供的弹簧效果动画，usingSpringWithDamping越接近1弹性效果越不明显，此API在IOS7之后才能使用
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         fromVC.view.frame = CGRectOffset(finalFrame, finalFrame.size.width, 0);
                         toVC.view.transform = CGAffineTransformMakeScale(1, 1);
                         toVC.view.alpha = 1;
                     } completion:^(BOOL finished) {
                         //通知系统动画切换完成
                         [transitionContext completeTransition:YES];
                     }];
}

@end
