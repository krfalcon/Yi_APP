//
//  SearchTextView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/25.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenHelper.h"

@class SearchTextView;

@protocol SearchTextViewDelegate <NSObject>

- (void)searchTextView:(SearchTextView *)searchTextView didChange:(NSString *)searchText;
- (void)searchTextView:(SearchTextView *)searchTextView didStartTexting:(NSString *)searchText;
- (void)searchTextView:(SearchTextView *)searchTextView didEndTexting:(NSString *)searchText;

@end

@interface SearchTextView : UIView<UITextFieldDelegate>
{
    UITextField*                                                searchField;
    UIImageView*                                                searchIcon;
    
    UIView*                                                     mainView;
    CGRect                                                      rect;
}

- (id)initWithFrame:(CGRect)frame andColor:(UIColor *)color;
- (void)hideKeyboard;

@property (weak, nonatomic) id<SearchTextViewDelegate>          delegate;

@end
