//
//  DropDownListView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/25.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "DropDownListView.h"

@implementation DropDownListView

- (id)initWithFrame:(CGRect)frame andSelections:(int)type andColor:(UIColor *)color {
    self = [super initWithFrame:frame];
    if (self) {
        //[self setBackgroundColor:[UIColor whiteColor]];
        [self setClipsToBounds:YES];
        [self setIsShow:NO];
        frameHeight = frame.size.height;
        
        UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(- frame.size.height / 4, frame.size.height * 0.25, frame.size.width + frame.size.height * 0.2, frame.size.height * 0.5)];
        mainView.layer.cornerRadius = frame.size.height * 0.25;
        mainView.layer.borderWidth  = 1.5f;
        mainView.layer.borderColor  = color.CGColor;
        [self addSubview:mainView];
        
        sortLabel = [[UILabel alloc] initWithFrame:mainView.frame];
        [sortLabel setBackgroundColor:[UIColor clearColor]];
        [sortLabel setText:@"选择排序"];
        [sortLabel setTextAlignment:NSTextAlignmentCenter];
        [sortLabel setTextColor:color];
        [sortLabel setFont:[UIFont systemFontOfSize:18.f]];
        [self addSubview:sortLabel];
        
        UIImageView *sortImage = [[UIImageView alloc] initWithFrame:CGRectMake(mainView.frame.size.width - 15, (mainView.frame.size.height - 8) / 2, 9, 8)];
        if ([color isEqual:ThemeRed]) {
            [sortImage setImage:[UIImage imageNamed:@"DropDownListIcon_Red"]];
        } else {
            [sortImage setImage:[UIImage imageNamed:@"DropDownListIcon_Blue"]];
        }
        [mainView addSubview:sortImage];
        
        UIButton *sortButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height * 0.75)];
        //[sortButton setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
        [sortButton setExclusiveTouch:YES];
        [sortButton addTarget:self action:@selector(tappedSortButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sortButton];
        
        UIButton *chNameAscButton = [[UIButton alloc] initWithFrame:CGRectMake(-1, frame.size.height * 0.75 - 1, frame.size.width + 1, frameHeight)];
        [chNameAscButton setTag:1];
        [chNameAscButton setExclusiveTouch:YES];
        [chNameAscButton addTarget:self action:@selector(tappedOptionButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:chNameAscButton];
        
        UILabel *chNameAscLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, chNameAscButton.frame.size.width - chNameAscButton.frame.size.height / 4, chNameAscButton.frame.size.height)];
        chNameAscLabel.layer.borderColor = color.CGColor;
        chNameAscLabel.layer.borderWidth = 1.f;
        chNameAscLabel.backgroundColor = [UIColor whiteColor];
        chNameAscLabel.text = @"中文顺序";
        chNameAscLabel.textAlignment = NSTextAlignmentCenter;
        chNameAscLabel.textColor = color;
        chNameAscLabel.font = [UIFont systemFontOfSize:18.f];
        [chNameAscButton addSubview:chNameAscLabel];
        
        UIButton *enNameAscButton = [[UIButton alloc] initWithFrame:CGRectMake(-1, frame.size.height * 0.75 + frameHeight -2, frame.size.width + 1, frameHeight)];
        [enNameAscButton setTag:2];
        [enNameAscButton setExclusiveTouch:YES];
        [enNameAscButton addTarget:self action:@selector(tappedOptionButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:enNameAscButton];
        
        UILabel *enNameAscLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, enNameAscButton.frame.size.width - enNameAscButton.frame.size.height / 4, enNameAscButton.frame.size.height)];
        enNameAscLabel.layer.borderColor = color.CGColor;
        enNameAscLabel.layer.borderWidth = 1.f;
        enNameAscLabel.backgroundColor = [UIColor whiteColor];
        enNameAscLabel.text = @"英文顺序";
        enNameAscLabel.textAlignment = NSTextAlignmentCenter;
        enNameAscLabel.textColor = color;
        enNameAscLabel.font = [UIFont systemFontOfSize:18.f];
        [enNameAscButton addSubview:enNameAscLabel];
        
        switch (type) {
            case 0:
            {
                scrollHeight = frameHeight * 3 - 3;
                
                UIButton *locationButton = [[UIButton alloc] initWithFrame:CGRectMake(-1, frame.size.height * 0.75 + frameHeight * 2 -3, frame.size.width + 1, frameHeight)];
                [locationButton setTag:3];
                [locationButton setExclusiveTouch:YES];
                [locationButton addTarget:self action:@selector(tappedOptionButton:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:locationButton];
                
                UILabel *locationAscLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, locationButton.frame.size.width - locationButton.frame.size.height / 4, locationButton.frame.size.height)];
                locationAscLabel.layer.borderColor = color.CGColor;
                locationAscLabel.layer.borderWidth = 1.f;
                locationAscLabel.backgroundColor = [UIColor whiteColor];
                locationAscLabel.text = @"商号顺序";
                locationAscLabel.textAlignment = NSTextAlignmentCenter;
                locationAscLabel.textColor = color;
                locationAscLabel.font = [UIFont systemFontOfSize:18.f];
                [locationButton addSubview:locationAscLabel];
                break;
            }
            case 1:
            {
                scrollHeight = frameHeight * 3 - 3;
                
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(-1, frame.size.height * 0.75 + frameHeight * 2 -3, frame.size.width + 1, frameHeight)];
                [button setTag:4];
                [button setExclusiveTouch:YES];
                [button addTarget:self action:@selector(tappedOptionButton:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];
                
                UILabel *buttonLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, button.frame.size.width - button.frame.size.height / 4, button.frame.size.height)];
                buttonLabel.layer.borderColor = color.CGColor;
                buttonLabel.layer.borderWidth = 1.f;
                buttonLabel.backgroundColor = [UIColor whiteColor];
                buttonLabel.text = @"结束时间顺序";
                buttonLabel.textAlignment = NSTextAlignmentCenter;
                buttonLabel.textColor = color;
                buttonLabel.font = [UIFont systemFontOfSize:18.f];
                [button addSubview:buttonLabel];
                break;
            }
            case 2:
            {
                scrollHeight = frameHeight * 3 - 3;
                
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(-1, frame.size.height * 0.75 + frameHeight * 2 - 3, frame.size.width + 1, frameHeight)];
                [button setTag:5];
                [button setExclusiveTouch:YES];
                [button addTarget:self action:@selector(tappedOptionButton:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];
                
                UILabel *buttonLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, button.frame.size.width - button.frame.size.height / 4, button.frame.size.height)];
                buttonLabel.layer.borderColor = color.CGColor;
                buttonLabel.layer.borderWidth = 1.f;
                buttonLabel.backgroundColor = [UIColor whiteColor];
                buttonLabel.text = @"上传顺序";
                buttonLabel.textAlignment = NSTextAlignmentCenter;
                buttonLabel.textColor = color;
                buttonLabel.font = [UIFont systemFontOfSize:18.f];
                [button addSubview:buttonLabel];
                break;
            }
            case 3:
            {
                scrollHeight = frameHeight * 4 - 4;
                
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(-1, frame.size.height * 0.75 + frameHeight * 2 -3, frame.size.width + 1, frameHeight)];
                [button setTag:6];
                [button setExclusiveTouch:YES];
                [button addTarget:self action:@selector(tappedOptionButton:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];
                
                UILabel *buttonLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, button.frame.size.width - button.frame.size.height / 4, button.frame.size.height)];
                buttonLabel.layer.borderColor = color.CGColor;
                buttonLabel.layer.borderWidth = 1.f;
                buttonLabel.backgroundColor = [UIColor whiteColor];
                buttonLabel.text = @"价格顺序";
                buttonLabel.textAlignment = NSTextAlignmentCenter;
                buttonLabel.textColor = color;
                buttonLabel.font = [UIFont systemFontOfSize:18.f];
                [button addSubview:buttonLabel];
                
                
                UIButton *buttonTwo = [[UIButton alloc] initWithFrame:CGRectMake(-1, frame.size.height * 0.75 + frameHeight * 3 -4, frame.size.width + 1, frameHeight)];
                [buttonTwo setTag:7];
                [buttonTwo setExclusiveTouch:YES];
                [buttonTwo addTarget:self action:@selector(tappedOptionButton:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:buttonTwo];
                
                UILabel *buttonTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, buttonTwo.frame.size.width - buttonTwo.frame.size.height / 4, buttonTwo.frame.size.height)];
                buttonTwoLabel.layer.borderColor = color.CGColor;
                buttonTwoLabel.layer.borderWidth = 1.f;
                buttonTwoLabel.backgroundColor = [UIColor whiteColor];
                buttonTwoLabel.text = @"折扣顺序";
                buttonTwoLabel.textAlignment = NSTextAlignmentCenter;
                buttonTwoLabel.textColor = color;
                buttonTwoLabel.font = [UIFont systemFontOfSize:18.f];
                [buttonTwo addSubview:buttonTwoLabel];
                break;
            }
            default:
                break;
        }
        
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height * 0.75)];
    }
    return self;
}

- (void)tappedSortButton {
    if (self.isShow) {
        [UIView animateWithDuration:0.4f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - scrollHeight)];
        }completion:^(BOOL finished){
            self.isShow = NO;
        }];
    } else {
        [UIView animateWithDuration:0.4f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height + scrollHeight)];
        }completion:^(BOOL finished){
            self.isShow = YES;
        }];
    }
}

- (void)tappedOptionButton:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            sortLabel.text = @"中文顺序";
            if (_delegate && [_delegate respondsToSelector:@selector(dropDownListView:didTapOption:)]) {
                [_delegate dropDownListView:self didTapOption:SortTypeCHNameAsc];
            }
            break;
        case 2:
            sortLabel.text = @"英文顺序";
            if (_delegate && [_delegate respondsToSelector:@selector(dropDownListView:didTapOption:)]) {
                [_delegate dropDownListView:self didTapOption:SortTypeENNameAsc];
            }
            break;
        case 3:
            sortLabel.text = @"商号顺序";
            if (_delegate && [_delegate respondsToSelector:@selector(dropDownListView:didTapOption:)]) {
                [_delegate dropDownListView:self didTapOption:SortTypeLocation];
            }
            break;
        case 4:
            sortLabel.text = @"结束时间顺序";
            if (_delegate && [_delegate respondsToSelector:@selector(dropDownListView:didTapOption:)]) {
                [_delegate dropDownListView:self didTapOption:SortTypeEndDateAsc];
            }
            break;
        case 5:
            sortLabel.text = @"上传顺序";
            if (_delegate && [_delegate respondsToSelector:@selector(dropDownListView:didTapOption:)]) {
                [_delegate dropDownListView:self didTapOption:SortTypeUploadDateDesc];
            }
            break;
        case 6:
            sortLabel.text = @"价格顺序";
            if (_delegate && [_delegate respondsToSelector:@selector(dropDownListView:didTapOption:)]) {
                [_delegate dropDownListView:self didTapOption:SortTypeDiscountAsc];
            }
            break;
        case 7:
            sortLabel.text = @"折扣顺序";
            if (_delegate && [_delegate respondsToSelector:@selector(dropDownListView:didTapOption:)]) {
                [_delegate dropDownListView:self didTapOption:SortTypeDiscountRateAsc];
            }
            break;
        default:
            break;
    }
    
    [UIView animateWithDuration:0.4f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - scrollHeight)];
    }completion:^(BOOL finished){
        self.isShow = NO;
    }];
}

@end
