//
//  DropDownListView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/25.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnumHelper.h"
#import "ScreenHelper.h"

@class DropDownListView;

@protocol DropDownListViewDelegate <NSObject>

@optional
- (void)dropDownListView:(DropDownListView *)dropDownListView didTapOption:(SortType)option;

@end

@interface DropDownListView : UIView
{
    float frameHeight;
    float scrollHeight;
    UILabel *sortLabel;
}
@property (weak, nonatomic) id<DropDownListViewDelegate>        delegate;
@property (assign, nonatomic) BOOL                              isShow;

- (id)initWithFrame:(CGRect)frame andSelections:(int)type andColor:(UIColor *)color;

@end