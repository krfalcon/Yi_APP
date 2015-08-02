//
//  TipView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/8.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipView : UIWindow

@property (strong, nonatomic) UILabel*                      messageLabel;

- (id)initWithMessage:(NSString *)message andColor:(UIColor *)color;
- (void)showTipView;

@end
