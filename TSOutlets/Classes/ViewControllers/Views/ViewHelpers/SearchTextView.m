//
//  SearchTextView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/25.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "SearchTextView.h"

@implementation SearchTextView

- (id)initWithFrame:(CGRect)frame andColor:(UIColor *)color {
    self = [super initWithFrame:frame];
    if (self) {
        rect = frame;
        self.clipsToBounds = YES;
        self.backgroundColor = AbsoluteWhite;
        
        mainView = [[UIView alloc] initWithFrame:CGRectMake(5, rect.size.height / 4, rect.size.width - 5, rect.size.height / 2)];
        mainView.layer.cornerRadius = frame.size.height / 4;
        mainView.layer.borderWidth  = 1.5f;
        mainView.layer.borderColor  = color.CGColor;
        [self addSubview:mainView];
        
        searchField = [[UITextField alloc]initWithFrame:CGRectMake(mainView.frame.size.height / 2, 0, [[UIScreen mainScreen] bounds].size.width - mainView.frame.size.height - 50, mainView.frame.size.height)];
        [searchField setBackgroundColor:AbsoluteClear];
        if ([color isEqual:ThemeRed_255_184_194]) {
            [searchField setTintColor:ThemeRed];
            [searchField setTextColor:ThemeRed];
        } else {
            [searchField setTintColor:ThemeBlue];
            [searchField setTextColor:ThemeBlue];
        }
        [searchField setFont:[UIFont systemFontOfSize:12]];
        [searchField setKeyboardType:UIKeyboardTypeDefault];
        [searchField setReturnKeyType:UIReturnKeyDone];
        //[searchField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [searchField setDelegate:self];
        [searchField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [mainView addSubview:searchField];
        
        UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 60, 0, 60, self.frame.size.height)];
        [searchButton setBackgroundColor:AbsoluteClear];
        [searchButton setExclusiveTouch:YES];
        [searchButton addTarget:self action:@selector(cancelSearch) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:searchButton];
        
        UILabel *searchLabel = [[UILabel alloc] initWithFrame:searchButton.bounds];
        [searchLabel setBackgroundColor:AbsoluteClear];
        [searchLabel setText:@"取消"];
        [searchLabel setTextColor:color];
        [searchLabel setTextAlignment:NSTextAlignmentCenter];
        [searchLabel setFont:[UIFont systemFontOfSize:14]];
        [searchButton addSubview:searchLabel];
        
        searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(mainView.frame.size.width - 25, (mainView.frame.size.height - 20) / 2, 16, 20)];
        [searchIcon setImage:[UIImage imageNamed:@"SearchTextIcon_Blue"]];
        if ([color isEqual:ThemeRed_255_184_194]) {
            [searchIcon setImage:[UIImage imageNamed:@"SearchTextIcon_Red"]];
        }
        [mainView addSubview:searchIcon];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboard) name:@"shouldHideKeyboard" object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textFieldDidChange:(UITextField *)textField {
    NSString *str = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    //NSLog(@"%@",str);
    
    if (_delegate && [_delegate respondsToSelector:@selector(searchTextView:didChange:)]) {
        [_delegate searchTextView:self didChange:str];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (_delegate && [_delegate respondsToSelector:@selector(searchTextView:didStartTexting:)]) {
        [_delegate searchTextView:self didStartTexting:nil];
    }
    
    [searchIcon setAlpha:0];
    [self setFrame:CGRectMake(0, self.frame.origin.y, self.superview.frame.size.width, self.frame.size.height)];
    [mainView setFrame:CGRectMake(mainView.frame.origin.x, mainView.frame.origin.y, self.frame.size.width - 60, mainView.frame.size.height)];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_delegate && [_delegate respondsToSelector:@selector(searchTextView:didEndTexting:)]) {
        [_delegate searchTextView:self didEndTexting:nil];
    }
    
    if (searchField.text.length == 0) {
        [self setFrame:rect];
        [mainView setFrame:CGRectMake(5, rect.size.height / 4, rect.size.width - 5, rect.size.height / 2)];
        [searchIcon setAlpha:1];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [searchField resignFirstResponder];
    
    return YES;
}

- (void)hideKeyboard {
    [searchField resignFirstResponder];
}

- (void)cancelSearch {
    [searchField setText:@""];
    
    if (_delegate && [_delegate respondsToSelector:@selector(searchTextView:didChange:)]) {
        [_delegate searchTextView:self didChange:@""];
    }
    
    if ([searchField isFirstResponder]) {
        [searchField resignFirstResponder];
    } else {
        
        if (_delegate && [_delegate respondsToSelector:@selector(searchTextView:didEndTexting:)]) {
            [_delegate searchTextView:self didEndTexting:nil];
        }
        
        if (searchField.text.length == 0) {
            [self setFrame:rect];
            [mainView setFrame:CGRectMake(5, rect.size.height / 4, rect.size.width - 5, rect.size.height / 2)];
            [searchIcon setAlpha:1];
        }
    }
}

@end
