//
//  OfflinePointBindView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/20.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "OfflinePointBindView.h"

@implementation OfflinePointBindView

- (void)initView {
    UIScrollView *pointScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleHeight, self.frame.size.width, self.frame.size.height - self.titleHeight)];
    pointScrollView.contentSize = CGSizeMake(pointScrollView.contentSize.width, 667 * self.scale - self.titleHeight);
    pointScrollView.showsVerticalScrollIndicator = NO;
    pointScrollView.delegate = self;
    [self addSubview:pointScrollView];
    
    UILabel *cardLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 * self.scale, 40 * self.scale, 90 * self.scale, 35 * self.scale)];
    cardLabel.text = @"卡号";
    cardLabel.textColor = ThemeRed;
    cardLabel.font = [UIFont boldSystemFontOfSize:25 * self.scale];
    [pointScrollView addSubview:cardLabel];
    
    InputView *cardField = [[InputView alloc] initWithFrame:CGRectMake(120 * self.scale, 40 * self.scale, 250 * self.scale, 35 * self.scale) andTheme:@"Red" andPlaceholder:@"请输入线下会员卡上的数字" andScale:self.scale];
    cardField.keyboardType = UIKeyboardTypeNumberPad;
    [pointScrollView addSubview:cardField];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 * self.scale, 90 * self.scale, 90 * self.scale, 35 * self.scale)];
    nameLabel.text = @"姓名";
    nameLabel.textColor = ThemeRed;
    nameLabel.font = [UIFont boldSystemFontOfSize:25 * self.scale];
    [pointScrollView addSubview:nameLabel];
    
    InputView *nameField = [[InputView alloc] initWithFrame:CGRectMake(120 * self.scale, 90 * self.scale, 250 * self.scale, 35 * self.scale) andTheme:@"Red" andPlaceholder:@"请输入线下会员卡绑定的真实姓名" andScale:self.scale];
    nameField.keyboardType = UIKeyboardTypeDefault;
    [pointScrollView addSubview:nameField];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 * self.scale, 140 * self.scale, 90 * self.scale, 35 * self.scale)];
    phoneLabel.text = @"手机";
    phoneLabel.tag = 22;
    phoneLabel.textColor = ThemeRed;
    phoneLabel.font = [UIFont boldSystemFontOfSize:25 * self.scale];
    [pointScrollView addSubview:phoneLabel];
    
    InputView *phoneField = [[InputView alloc] initWithFrame:CGRectMake(120 * self.scale, 140 * self.scale, 250 * self.scale, 35 * self.scale) andTheme:@"Red" andPlaceholder:@"请输入线下会员卡绑定的手机号" andScale:self.scale];
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    [pointScrollView addSubview:phoneField];
    
    UILabel *identifyingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 * self.scale, 190 * self.scale, 90 * self.scale, 35 * self.scale)];
    identifyingLabel.text = @"验证码";
    identifyingLabel.textColor = ThemeRed;
    identifyingLabel.font = [UIFont boldSystemFontOfSize:25 * self.scale];
    [pointScrollView addSubview:identifyingLabel];
    
    InputView *identifyingField = [[InputView alloc] initWithFrame:CGRectMake(120 * self.scale, 190 * self.scale, 120 * self.scale, 35 * self.scale) andTheme:@"Red" andPlaceholder:@"" andScale:self.scale];
    identifyingField.keyboardType = UIKeyboardTypeDefault;
    identifyingField.autocapitalizationType = NO;
    [pointScrollView addSubview:identifyingField];
    
    UIButton *identifyingButton = [[UIButton alloc] initWithFrame:CGRectMake(260 * self.scale, 190 * self.scale, 110 * self.scale, 35 * self.scale)];
    [identifyingButton setExclusiveTouch:YES];
    [identifyingButton addTarget:self action:@selector(getIdentifyingCode) forControlEvents:UIControlEventTouchUpInside];
    [pointScrollView addSubview:identifyingButton];
    
    UILabel *buttonLabel = [[UILabel alloc] initWithFrame:identifyingButton.bounds];
    buttonLabel.layer.cornerRadius = buttonLabel.frame.size.height / 2;
    buttonLabel.layer.backgroundColor = ThemeRed.CGColor;
    buttonLabel.tag = 99;
    buttonLabel.text = @"获取";
    buttonLabel.textColor = AbsoluteWhite;
    buttonLabel.textAlignment = NSTextAlignmentCenter;
    buttonLabel.font = [UIFont boldSystemFontOfSize:25 * self.scale];
    [identifyingButton addSubview:buttonLabel];
    
    UIButton *bindButton = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 190 * self.scale) / 2, 260 * self.scale, 190 * self.scale, 60 * self.scale)];
    bindButton.exclusiveTouch = YES;
    [bindButton addTarget:self action:@selector(tappedBindButton) forControlEvents:UIControlEventTouchUpInside];
    [pointScrollView addSubview:bindButton];
    
    UILabel *bindLabel = [[UILabel alloc] initWithFrame:bindButton.bounds];
    bindLabel.layer.cornerRadius = bindLabel.frame.size.height / 2;
    bindLabel.layer.backgroundColor = ThemeRed.CGColor;
    bindLabel.text = @"绑定";
    bindLabel.textColor = AbsoluteWhite;
    bindLabel.textAlignment = NSTextAlignmentCenter;
    bindLabel.font = [UIFont boldSystemFontOfSize:40 * self.scale];
    bindLabel.tag = 11;
    [bindButton addSubview:bindLabel];
    
    UIButton *getButton = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 260 * self.scale) / 2, 380 * self.scale, 260 * self.scale, 65 * self.scale)];
    getButton.exclusiveTouch = YES;
    [pointScrollView addSubview:getButton];
    
    NSMutableAttributedString *getString = [[NSMutableAttributedString alloc] initWithString:@"没有线下会员卡？\n点我领取"];
    [getString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0 * self.scale] range:NSMakeRange(0, 8)];
    [getString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:23.0 * self.scale] range:NSMakeRange(8, getString.length - 8)];
    
    UILabel *getLabel = [[UILabel alloc] initWithFrame:getButton.bounds];
    getLabel.layer.cornerRadius = getLabel.frame.size.height / 2;
    getLabel.layer.borderColor = ThemeRed.CGColor;
    getLabel.layer.borderWidth = 2.f;
    getLabel.attributedText = getString;
    getLabel.textColor = ThemeRed;
    getLabel.textAlignment = NSTextAlignmentCenter;
    getLabel.numberOfLines = 0;
    [getButton addSubview:getLabel];
}

#pragma mark - Button Events

- (void)tappedBindButton {
    if (_delegate && [_delegate respondsToSelector:@selector(offlinePointBindViewDidTapBindButton)]) {
        [_delegate offlinePointBindViewDidTapBindButton];
    }
}

- (void)getIdentifyingCode {
    [(UILabel *)[self viewWithTag:99] setText:@"60秒后重新获取"];
    [(UILabel *)[self viewWithTag:99] setFont:[UIFont boldSystemFontOfSize:12 * self.scale]];
    [[(UILabel *)[self viewWithTag:99] layer] setBackgroundColor:Color(161, 161, 161, 1).CGColor];
    [(UIButton *)[[self viewWithTag:99] superview] setEnabled:NO];
    timeLeft = 60;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tiktok) userInfo:nil repeats:YES];
    
    //返回当前的消息循环对象
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)tiktok {
    timeLeft --;
    if (timeLeft == 0) {
        [(UILabel *)[self viewWithTag:99] setText:@"获取"];
        [(UILabel *)[self viewWithTag:99] setFont:[UIFont boldSystemFontOfSize:25 * self.scale]];
        [[(UILabel *)[self viewWithTag:99] layer] setBackgroundColor:ThemeRed.CGColor];
        [(UIButton *)[[self viewWithTag:99] superview] setEnabled:YES];
        
        [timer invalidate];
        timer = nil;
    } else {
        [(UILabel *)[self viewWithTag:99] setText:[NSString stringWithFormat:@"%d秒后重新获取", timeLeft]];
    }
}

#pragma mark - Scroll View Delegate 

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewDidScroll)]) {
        [_delegate scrollViewDidScroll];
    }
}

@end
