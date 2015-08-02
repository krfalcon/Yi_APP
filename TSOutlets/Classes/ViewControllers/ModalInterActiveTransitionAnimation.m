//
//  ModalInterActiveTransitionAnimation.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/20.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ModalInterActiveTransitionAnimation.h"
#import "SingleCase.h"

@interface ModalInterActiveTransitionAnimation()

@property (nonatomic, strong) UIViewController *presentingVC;
@property (nonatomic, assign) BOOL shouldComplete;

@end

@implementation ModalInterActiveTransitionAnimation

- (void)wireToViewController:(UIViewController*)viewController{
    _presentingVC = viewController;
    
    //添加手势
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [viewController.view addGestureRecognizer:gesture];
}

-(CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}

-(void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:{
            _interacting = YES;
            [self.presentingVC dismissViewControllerAnimated:YES completion:nil];
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            CGFloat fraction = translation.x / 320.0;
            fraction = fminf(fmaxf(fraction, 0.0), 1.0);
            _shouldComplete = (fraction > 0.5);
            
            [self updateInteractiveTransition:fraction];
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            _interacting = NO;
            if (!_shouldComplete || gestureRecognizer.state == UIGestureRecognizerStateCancelled || [gestureRecognizer velocityInView:gestureRecognizer.view].x < 0 ) {
                [self cancelInteractiveTransition];
                
                //self.presentingVC.view.alpha = 0;
            } else {
                [self finishInteractiveTransition];
                //NSLog(@"%d",[SingleCase singleCase].backNum);
            }
            
            break;
        }
        default:
            break;
    }
}

@end
