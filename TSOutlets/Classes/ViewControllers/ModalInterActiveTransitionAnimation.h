//
//  ModalInterActiveTransitionAnimation.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/20.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModalInterActiveTransitionAnimation : UIPercentDrivenInteractiveTransition

@property(nonatomic,assign)BOOL interacting;
- (void)wireToViewController:(UIViewController*)viewController;

@end
