//
//  TipView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/8.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TipView.h"		

@implementation TipView

- (id)initWithMessage:(NSString *)message andColor:(UIColor *)color {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIApplication sharedApplication].statusBarFrame.size.width, 64);
        //self.frame = [UIApplication sharedApplication].statusBarFrame;
        self.windowLevel = UIWindowLevelStatusBar + 1.0f;
        self.hidden = NO;
        self.alpha = 1;
        
//        UIViewController *view = [[UIViewController alloc] init];
//        [self setRootViewController:view];
        
        _messageLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [_messageLabel setText:message];
        [_messageLabel setTextColor:color];
        [_messageLabel setTextAlignment:NSTextAlignmentCenter];
        [_messageLabel setFont:[UIFont boldSystemFontOfSize:16.f]];
        [_messageLabel setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.9]];
        [self addSubview:_messageLabel];
    }
    return self;
}

- (void)showTipView {
    self.frame = (CGRect){0, -self.frame.size.height, self.frame.size };
    [UIView animateWithDuration:0.4
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        self.frame = (CGRect){0, 0, self.frame.size };
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.4
                              delay:1.2
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
            self.frame = (CGRect){0, -self.frame.size.height, self.frame.size };
        } completion:^(BOOL finished){
            _messageLabel.text = @"";
            self.hidden = YES;
        }];
    }];
}

@end
