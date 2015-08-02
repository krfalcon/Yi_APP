//
//  InputView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/20.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "InputView.h"
#import "ScreenHelper.h"

@implementation InputView

- (id)initWithFrame:(CGRect)frame andTheme:(NSString *)theme andPlaceholder:(NSString *)placeholder andScale:(float)scale {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.layer.cornerRadius = self.frame.size.height / 2;
        self.layer.borderColor = ThemeRed.CGColor;
        self.layer.borderWidth = 1.5f;
        //self.placeholder = @"请输入手机号";
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = ThemeRed;
        self.tintColor = ThemeRed;
        self.returnKeyType = UIReturnKeyDone;
        self.font = [UIFont boldSystemFontOfSize:20 * scale];
        
        UILabel *placeholderLabel = [[UILabel alloc] initWithFrame:self.bounds];
        placeholderLabel.text = placeholder;
        placeholderLabel.textColor = Color(190, 190, 190, 1);
        placeholderLabel.textAlignment = NSTextAlignmentCenter;
        placeholderLabel.font = [UIFont systemFontOfSize:13 * scale];
        [self addSubview:placeholderLabel];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboard) name:@"shouldHideKeyboard" object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)hideKeyboard {
    [self resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [(UILabel *)[[textField subviews] firstObject] setHidden:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length == 0) {
        [(UILabel *)[[textField subviews] firstObject] setHidden:NO];
    }
}

@end
