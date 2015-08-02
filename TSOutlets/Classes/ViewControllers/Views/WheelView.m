//
//  WheelView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/19.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "WheelView.h"
#import "ScreenHelper.h"

@implementation WheelView

- (id)initWithFrame:(CGRect)frame andType:(NSString *)type andColor:(NSString *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:CGRectMake(0, frame.size.height - frame.size.width / 3, frame.size.width, frame.size.width)];
        //[self setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:0.6f]];
        self.isShow = YES;
        [self setUserInteractionEnabled:NO];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
        
        wheelView = [[UIView alloc] initWithFrame:CGRectMake(- self.frame.size.width / 6, - self.frame.size.width / 40, self.frame.size.width * 4 / 3, self.frame.size.width * 4 / 3)];
        [self addSubview:wheelView];
        
        wheelView.transform = CGAffineTransformMakeScale(0.6, 0.6);
        self.transform = CGAffineTransformMakeTranslation(0, 50);
        
        wheelImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width * 4 / 3, self.frame.size.width * 4 / 3)];
        [wheelImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"WheelView_%@", type]]];
        [wheelView addSubview:wheelImage];
        
        wheelHoldImage =[[UIImageView alloc] initWithFrame:CGRectMake(- self.frame.size.width / 6, - self.frame.size.width / 40, self.frame.size.width * 4 / 3, self.frame.size.width * 4 / 3)];
        [wheelHoldImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"WheelViewHold_%@", color]]];
        [self addSubview:wheelHoldImage];
        
        UIButton *button11111 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width * 0, self.frame.size.width / 35 * 5, self.frame.size.width / 5, self.frame.size.width / 5)];
        //[button11111 setBackgroundColor:[UIColor yellowColor]];
        //[button11111 setAlpha:0.5];
        [button11111 setExclusiveTouch:YES];
        [button11111 addTarget:self action:@selector(tappedButton1) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button11111];
        
        UIButton *button22222 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width / 5, self.frame.size.width / 35 * 2, self.frame.size.width / 5, self.frame.size.width / 5)];
        //[button22222 setBackgroundColor:[UIColor yellowColor]];
        //[button22222 setAlpha:0.5];
        [button22222 setExclusiveTouch:YES];
        [button22222 addTarget:self action:@selector(tappedButton2) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button22222];
        
        UIButton *button33333 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width / 5 * 2, 0, self.frame.size.width / 5, self.frame.size.width / 5)];
        //[button33333 setBackgroundColor:themeColor];
        [button33333 setExclusiveTouch:YES];
        [button33333 addTarget:self action:@selector(tappedButton3) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button33333];
        
        UIButton *button44444 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width / 5 * 3, self.frame.size.width / 35 * 2, self.frame.size.width / 5, self.frame.size.width / 5)];
        //[button44444 setBackgroundColor:themeColor];
        [button44444 setExclusiveTouch:YES];
        [button44444 addTarget:self action:@selector(tappedButton4) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button44444];
        
        UIButton *button55555 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width / 5 * 4, self.frame.size.width / 35 * 5, self.frame.size.width / 5, self.frame.size.width / 5)];
        //[button55555 setBackgroundColor:themeColor];
        [button55555 setExclusiveTouch:YES];
        [button55555 addTarget:self action:@selector(tappedButton5) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button55555];
        
        wheelTypeArray = [[NSMutableArray alloc] init];
        [wheelTypeArray addObject:@""];
        currentType = @"";
    }
    return self;
}


- (void)tappedButton1
{
    if (![buttonType isEqualToString:@"3"]) {
        if (_delegate && [_delegate respondsToSelector:@selector(wheelViewDidTapButton1:)]) {
            [_delegate wheelViewDidTapButton1:self ];
        }
    }
}

- (void)tappedButton2
{
    if (![buttonType isEqualToString:@"3"]) {
        currentType = [[currentType substringToIndex:currentType.length - 1] stringByAppendingString:@"2"];
        [wheelImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"WheelView_%@", currentType]]];
        [wheelTypeArray removeLastObject];
        [wheelTypeArray addObject:currentType];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(wheelViewDidTapButton2:)]) {
        [_delegate wheelViewDidTapButton2:self ];
    }
}

- (void)tappedButton3
{
    currentType = [[currentType substringToIndex:currentType.length - 1] stringByAppendingString:@"3"];
    [wheelImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"WheelView_%@", currentType]]];
    [wheelTypeArray removeLastObject];
    [wheelTypeArray addObject:currentType];
    
    if (_delegate && [_delegate respondsToSelector:@selector(wheelViewDidTapButton3:)]) {
        [_delegate wheelViewDidTapButton3:self ];
    }
}

- (void)tappedButton4
{
    currentType = [[currentType substringToIndex:currentType.length - 1] stringByAppendingString:@"4"];
    [wheelImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"WheelView_%@", currentType]]];
    [wheelTypeArray removeLastObject];
    [wheelTypeArray addObject:currentType];
    
    if (_delegate && [_delegate respondsToSelector:@selector(wheelViewDidTapButton4:)]) {
        [_delegate wheelViewDidTapButton4:self ];
    }
}

- (void)tappedButton5
{
    if (![buttonType isEqualToString:@"4"] && ![buttonType isEqualToString:@"3"]) {
        currentType = [[currentType substringToIndex:currentType.length - 1] stringByAppendingString:@"5"];
        [wheelImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"WheelView_%@", currentType]]];
        [wheelTypeArray removeLastObject];
        [wheelTypeArray addObject:currentType];
        
        if (_delegate && [_delegate respondsToSelector:@selector(wheelViewDidTapButton5:)]) {
            [_delegate wheelViewDidTapButton5:self ];
        }
    }
}

#pragma mark - Wheel Animation

- (void)createNewWheelViewWithType:(NSString *)wheelViewType andColor:(NSString *)color andButtonType:(NSString *)button {
    nextType = wheelViewType;
    buttonType = button;
    if (color.length > 0) {
        [wheelHoldImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"WheelViewHold_%@", color]]];
    }
    
    wheelTypeArrayIsAdd = YES;
}

- (void)getPreWheelView {
    nextType = [wheelTypeArray objectAtIndex:wheelTypeArray.count - 2];
    
    wheelTypeArrayIsAdd = NO;
}

- (void)getFirstWheelView {
    nextType = [wheelTypeArray firstObject];
    
    for (int i = 1; i < wheelTypeArray.count - 1; i++) {
        [wheelTypeArray removeObjectAtIndex:i];
    }
    
    wheelTypeArrayIsAdd = NO;
}

- (void)wheelAnimation {
    UIImage *nextWheel = [UIImage imageNamed:[NSString stringWithFormat:@"WheelView_%@", nextType]];
    
    if (nextType.length != 0 || currentType.length != 0) {
        if (currentType.length == 0) [wheelImage setImage:nextWheel];
        
        [UIView animateWithDuration:0.2f
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             if (currentType && currentType.length > 0) {
                                 wheelView.transform = CGAffineTransformMakeScale(0.6, 0.6);
                             } else {
                                 self.transform = CGAffineTransformMakeTranslation(0, 0);
                             }
                         }
                         completion:^(BOOL finished){
                             [wheelImage setImage:nextWheel];
                             
                             if ([nextType rangeOfString:@"Member"].location != NSNotFound || [nextType rangeOfString:@"Event"].location != NSNotFound) {
                                 [wheelHoldImage setImage:[UIImage imageNamed:@"WheelViewHold_Red"]];
                             } else if ([nextType rangeOfString:@"Shop"].location != NSNotFound) {
                                 [wheelHoldImage setImage:[UIImage imageNamed:@"WheelViewHold_Blue"]];
                             } else if ([nextType rangeOfString:@"Service"].location != NSNotFound) {
                                 [wheelHoldImage setImage:[UIImage imageNamed:@"WheelViewHold_Yellow"]];
                             }
                             //[wheelHoldImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"WheelViewHold_%@", nextType]]];
                         }];
        
        [UIView animateWithDuration:0.2f
                              delay:0.25f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             if (nextType && nextType.length > 0) {
                                 wheelView.transform = CGAffineTransformMakeScale(1, 1);
                             } else {
                                 self.transform = CGAffineTransformMakeTranslation(0, 50);
                             }
                         }
                         completion:^(BOOL finished){
                             if (wheelTypeArrayIsAdd) {
                                 [wheelTypeArray addObject:nextType];
                                 currentType = nextType;
                                 nextType = @"";
                             } else {
                                 [wheelTypeArray removeLastObject];
                                 currentType = nextType;
                                 nextType = @"";
                             }
                             
                             if (currentType && currentType.length > 0) {
                                 _isShow = YES; self.userInteractionEnabled = YES;

                                 if (_delegate && [_delegate respondsToSelector:@selector(wheelDidShow)]) {
                                     [_delegate wheelDidShow];
                                 }
                             }
                             else {
                                 _isShow = NO; self.userInteractionEnabled = NO;
                                 
                                 if (_delegate && [_delegate respondsToSelector:@selector(wheelDidHide)]) {
                                     [_delegate wheelDidHide];
                                 }
                             }
                         }];
    } else {
        if (wheelTypeArrayIsAdd) {
            [wheelTypeArray addObject:nextType];
            currentType = nextType;
            nextType = @"";
        } else {
            [wheelTypeArray removeLastObject];
            currentType = nextType;
            nextType = @"";
        }
        _isShow = NO; self.userInteractionEnabled = NO;
        
        if (_delegate && [_delegate respondsToSelector:@selector(wheelDidHide)]) {
            [_delegate wheelDidHide];
        }
    }
}

- (void)wheelAnimationWithRatio:(float)ratio {
    //NSLog(@"current:%@ ,next:%@" , currentType, nextType);
    if (nextType.length !=0 || currentType.length != 0) {
        if (ratio > 0.5)
        {
            if ([currentType rangeOfString:@"Member"].location != NSNotFound || [currentType rangeOfString:@"Event"].location != NSNotFound) {
                [wheelHoldImage setImage:[UIImage imageNamed:@"WheelViewHold_Red"]];
            } else if ([currentType rangeOfString:@"Shop"].location != NSNotFound) {
                [wheelHoldImage setImage:[UIImage imageNamed:@"WheelViewHold_Blue"]];
            } else if ([currentType rangeOfString:@"Service"].location != NSNotFound) {
                [wheelHoldImage setImage:[UIImage imageNamed:@"WheelViewHold_Yellow"]];
            }
            
            if (currentType && currentType.length > 0 && self.isShow) {
                [wheelImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"WheelView_%@", currentType]]];
                wheelView.transform = CGAffineTransformMakeScale(1 - 0.4 * (1 - ratio) * 2, 1 - 0.4 * (1 - ratio) * 2);
            } else if (currentType && currentType.length > 0 && !self.isShow) {
                
            } else if (nextType && nextType.length > 0 && !self.isShow) {
                self.transform = CGAffineTransformMakeTranslation(0, - 50 * (0.5 - ratio) * 2);
            }
        } else {
            if ([nextType rangeOfString:@"Member"].location != NSNotFound || [nextType rangeOfString:@"Event"].location != NSNotFound) {
                [wheelHoldImage setImage:[UIImage imageNamed:@"WheelViewHold_Red"]];
            } else if ([nextType rangeOfString:@"Shop"].location != NSNotFound) {
                [wheelHoldImage setImage:[UIImage imageNamed:@"WheelViewHold_Blue"]];
            } else if ([nextType rangeOfString:@"Service"].location != NSNotFound) {
                [wheelHoldImage setImage:[UIImage imageNamed:@"WheelViewHold_Yellow"]];
            }
            if (nextType && nextType.length > 0) {
                [wheelImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"WheelView_%@", nextType]]];
                self.transform = CGAffineTransformMakeTranslation(0, 0);
                wheelView.transform = CGAffineTransformMakeScale(0.6 + 0.4 * (0.5 - ratio) * 2, 0.6 + 0.4 * (0.5 - ratio) * 2);
            } else {
                wheelView.transform = CGAffineTransformMakeScale(0.6, 0.6);
                self.transform = CGAffineTransformMakeTranslation(0, 50 * (0.5 - ratio) * 2);
            }
        }
    }
    
    if (ratio == 0) {
        [wheelTypeArray removeLastObject];
        currentType = nextType;
        nextType = @"";
        
        if (currentType && currentType.length > 0) {
            _isShow = YES; self.userInteractionEnabled = YES;
            
            if (_delegate && [_delegate respondsToSelector:@selector(wheelDidShow)]) {
                [_delegate wheelDidShow];
            }
        }
        else {
            _isShow = NO; self.userInteractionEnabled = NO;
            
            if (_delegate && [_delegate respondsToSelector:@selector(wheelDidHide)]) {
                [_delegate wheelDidHide];
            }
        }
    }
}

- (void)wheelShow {
    if (currentType && currentType.length > 0) {
        if (!_isShow) {
            [UIView animateWithDuration:0.2f
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 wheelView.transform = CGAffineTransformMakeScale(1, 1);
                             }
                             completion:^(BOOL finished){
                                 _isShow = YES;
                                 self.userInteractionEnabled = YES;
                             }];
        }
    }
}

- (void)wheelHide {
    if (currentType && currentType.length > 0) {
        if (_isShow) {
            [UIView animateWithDuration:0.2f
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 wheelView.transform = CGAffineTransformMakeScale(0.6, 0.6);
                             }
                             completion:^(BOOL finished){
                                 _isShow = NO;
                                 self.userInteractionEnabled = NO;
                             }];
        }
    }
}

@end
