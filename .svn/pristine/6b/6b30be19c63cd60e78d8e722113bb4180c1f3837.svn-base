//
//  TempletView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/25.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"

@implementation TempletView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = AbsoluteWhite;
        self.clipsToBounds = YES;
        
        //设定高度
        _titleHeight = 64.f;
        _scale = self.frame.size.width / 375.f;
        
        _scale = floorf(_scale * 100)/100;
        
        if (iPhone6Plus) {
            self.frame = iPhone6PlusScreenRect;
        } else if (iPhone6) {
            self.frame = iPhone6ScreenRect;
        } else if (iPhone5){
            self.frame = iPhone5ScreenRect;
        } else {
            self.frame = iPhone4ScreenRect;
        }
        
        [self initView];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initView {
    
}

- (void)showLoadingView {
    if (!activityIndicatorView) {
        activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityIndicatorView setCenter:self.center];
        //[activityIndicatorView setBackgroundColor:AbsoluteBlack];
        [activityIndicatorView startAnimating];
        [self addSubview:activityIndicatorView];
    }
}

- (void)hideLoadingView {
    [activityIndicatorView stopAnimating];
    [activityIndicatorView removeFromSuperview];
    activityIndicatorView = nil;
}

@end
