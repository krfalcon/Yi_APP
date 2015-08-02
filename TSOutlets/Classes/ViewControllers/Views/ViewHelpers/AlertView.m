//
//  AlertView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/28.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView

- (id)initWithFrame:(CGRect)frame andTheme:(NSString *)theme andContent:(UIView *)content {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
        
        UIButton *backgroundButton = [[UIButton alloc] initWithFrame:self.bounds];
        [backgroundButton addTarget:self action:@selector(tappedBackButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backgroundButton];
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 200)];
        contentView.layer.cornerRadius = 10.f;
        contentView.layer.borderColor = ThemeRed_136_028_018.CGColor;
        contentView.layer.borderWidth = 1.f;
        [contentView setClipsToBounds:YES];
        [contentView setCenter:self.center];
        [contentView setBackgroundColor:AbsoluteWhite];
        [self addSubview:contentView];
        
        UIButton *commitButton = [[UIButton alloc] initWithFrame:CGRectMake(90, 130, 100, 50)];
        [commitButton setExclusiveTouch:YES];
        [commitButton addTarget:self action:@selector(tappedCommitButton) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:commitButton];
        
        UILabel *commitLabel = [[UILabel alloc] initWithFrame:commitButton.bounds];
        commitLabel.layer.borderColor = ThemeRed_136_028_018.CGColor;
        commitLabel.layer.borderWidth = 1.f;
        commitLabel.layer.cornerRadius = 10.f;
        [commitLabel setClipsToBounds:YES];
        [commitLabel setBackgroundColor:ThemeRed_255_184_194];
        [commitLabel setText:@"确定"];
        [commitLabel setTextColor:AbsoluteWhite];
        [commitLabel setTextAlignment:NSTextAlignmentCenter];
        [commitLabel setFont:[UIFont boldSystemFontOfSize:24]];
        [commitButton addSubview:commitLabel];
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(240, 0, 40, 40)];
        [cancelButton setBackgroundColor:[UIColor yellowColor]];
        [cancelButton addTarget:self action:@selector(tappedBackButton) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:cancelButton];
        
        [contentView addSubview:content];
    }
    return self;
}

- (void)tappedBackButton {
    [UIView animateWithDuration:0.2 animations:^{self.alpha = 0;} completion:^(BOOL finished){[self removeFromSuperview];}];
}

- (void)tappedCommitButton {
    [UIView animateWithDuration:0.2 animations:^{self.alpha = 0;} completion:^(BOOL finished){[self removeFromSuperview];}];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"alertViewDidCommit" object:nil];
}

@end
