//
//  EventShopView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/2.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "EventShopView.h"
#import "MJRefresh.h"

#define buttonHeight 100.0f

@implementation EventShopView

- (void)initView {
    eventScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleHeight + 60 * self.scale, self.frame.size.width, self.frame.size.height - (self.titleHeight + 60))];
    [eventScrollView setDelegate:self];
    [self addSubview:eventScrollView];
    
    DropDownListView *ddlView = [[DropDownListView alloc] initWithFrame:CGRectMake(0, self.titleHeight, 155, 60) andSelections:1 andColor:ThemeRed];
    [ddlView setDelegate:self];
    [self addSubview:ddlView];
    
    [eventScrollView addHeaderWithTarget:self action:@selector(refresh)];
}

- (void)refresh {
    if (_delegate && [_delegate respondsToSelector:@selector(eventShopViewDidRefresh)]) {
        [_delegate eventShopViewDidRefresh];
    }
}

- (void)refreshSelf {
    [eventScrollView headerEndRefreshing];
    
    [self createEventListWithEventEntityArray];
}

- (void)createEventListWithEventEntityArray {
    for (id d in eventScrollView.subviews) {
        if (![d isMemberOfClass:[MJRefreshHeaderView class]]) [d removeFromSuperview];
    }
    //[[eventScrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _page = 0;
    shifting = 0;
    
    [self addListButton];
}

- (void)addListButton {
    if (_eventListArray.count == 0) return;
    
    if (_page * 10 + 10 < _eventListArray.count) {
        for (int i = 0; i < 10; i++) {
            EventEntity *ety = (EventEntity *)[_eventListArray objectAtIndex:i + _page * 10];
            [eventScrollView addSubview:[self createListButtonWithFrame:CGRectMake(20 * self.scale, (10 + i * (buttonHeight + 20) + _page * 1200) * self.scale + shifting, self.frame.size.width - 40 * self.scale, buttonHeight * self.scale) andShopEntity:ety andTag:i + _page * 10]];
        }
        
        _page += 1;
        [eventScrollView setContentSize:CGSizeMake(eventScrollView.frame.size.width, _page * 1200 * self.scale + 100 * self.scale)];
    } else if (_page * 10 < _eventListArray.count) {
        for (int i = _page * 10; i < _eventListArray.count; i++) {
            EventEntity *ety = (EventEntity *)[_eventListArray objectAtIndex:i];
            [eventScrollView addSubview:[self createListButtonWithFrame:CGRectMake(20 * self.scale, (10 + i * (buttonHeight + 20)) * self.scale + shifting, self.frame.size.width - 40 * self.scale, buttonHeight * self.scale) andShopEntity:ety andTag:i]];
        }
        
        _page += 1;
        [eventScrollView setContentSize:CGSizeMake(eventScrollView.frame.size.width, _eventListArray.count * 120 * self.scale + 100 * self.scale > eventScrollView.frame.size.height ? _eventListArray.count * 120 * self.scale + 100 * self.scale : eventScrollView.frame.size.height + 1)];
    } else {
        return;
    }
}

- (void)tappedEventButton:(UIButton *)button {
    EventEntity *eventEntity = (EventEntity *)[_eventListArray objectAtIndex:button.tag];
    
    if (_delegate && [_delegate respondsToSelector:@selector(eventShopView:didTapEventButtonWithEventEntity:)]) {
        [_delegate eventShopView:self didTapEventButtonWithEventEntity:eventEntity];
    }
}

- (UIButton *)createListButtonWithFrame:(CGRect)frame andShopEntity:(EventEntity *)eventEntity andTag:(int)tag {
    UIButton *eventView = [[UIButton alloc] initWithFrame:frame];
    eventView.clipsToBounds = YES;
    [eventView setTag:tag];
    [eventScrollView addSubview:eventView];
    
    //        UIView *eventView = [[UIView alloc] initWithFrame:CGRectMake(20 * self.scale, 10 * self.scale + i * 120 * self.scale, self.frame.size.width - 40 * self.scale, buttonHeight * self.scale)];
    //        eventView.clipsToBounds = YES;
    //        [eventScrollView addSubview:eventView];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, eventView.frame.size.width - 12.5 * self.scale, eventView.frame.size.height)];
    backView.layer.cornerRadius = 5 * self.scale;
    backView.userInteractionEnabled = NO;
    backView.backgroundColor = ThemeRed_255_231_237;
    backView.tag = -1;
    [eventView addSubview:backView];
    
    UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(120 * self.scale, 0, eventView.frame.size.width - 132.5 * self.scale, 50 * self.scale)];
    timeView.layer.cornerRadius = 5 * self.scale;
    timeView.userInteractionEnabled = NO;
    timeView.backgroundColor = ThemeRed_255_184_194;
    [eventView addSubview:timeView];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(- 25 / 2 * self.scale, 0, eventView.frame.size.width + 25 / 2 * self.scale, 50 / 2 * self.scale)];
    titleView.layer.cornerRadius = 25.f / 2 * self.scale;
    titleView.userInteractionEnabled = NO;
    titleView.backgroundColor = ThemeRed;
    [eventView addSubview:titleView];
    
    UILabel *chName = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.scale, 0, 100 * self.scale, 25 * self.scale)];
    [chName setBackgroundColor:AbsoluteClear];
    [chName setText:eventEntity.shopEntity.chName];
    [chName setTextColor:AbsoluteWhite];
    [chName setFont:[UIFont boldSystemFontOfSize:18 * self.scale]];
    [eventView addSubview:chName];
    
    UILabel *enName = [[UILabel alloc] initWithFrame:CGRectMake(120 * self.scale, 0 * self.scale, eventView.frame.size.width - 120 * self.scale, 25 * self.scale)];
    [enName setBackgroundColor:AbsoluteClear];
    [enName setText:eventEntity.shopEntity.enName];
    [enName setTextColor:AbsoluteWhite];
    [enName setFont:[UIFont boldSystemFontOfSize:15 * self.scale]];
    [eventView addSubview:enName];
    
    NSString *timeString = [NSString stringWithFormat:@"%@至%@", eventEntity.beginTime, eventEntity.endTime];
    NSMutableAttributedString *str;
    str = [[NSMutableAttributedString alloc] initWithString:timeString];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.0 * self.scale] range:NSMakeRange(0, eventEntity.beginTime.length)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0 * self.scale] range:NSMakeRange(eventEntity.beginTime.length, 1)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.0 * self.scale] range:NSMakeRange(eventEntity.beginTime.length + 1, eventEntity.beginTime.length)];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(120 * self.scale, 25 * self.scale, eventView.frame.size.width - 132.5 * self.scale, 25 * self.scale)];
    [timeLabel setBackgroundColor:AbsoluteClear];
    [timeLabel setAttributedText:str];
    [timeLabel setTextColor:ThemeRed_136_028_018];
    [timeLabel setTextAlignment:NSTextAlignmentCenter];
    [eventView addSubview:timeLabel];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120 * self.scale, 50 * self.scale, eventView.frame.size.width - 152.5 * self.scale, eventView.frame.size.height - 50 * self.scale)];
    [titleLabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    [titleLabel setBackgroundColor:AbsoluteClear];
    [titleLabel setText:eventEntity.title];
    [titleLabel setTextColor:ThemeRed_103_014_014];
    [titleLabel setFont:[UIFont systemFontOfSize:20 * self.scale]];
    [eventView addSubview:titleLabel];
    
    if (eventEntity.shopEntity.logoImage) {
        UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0 * self.scale, 25 * self.scale, 100 * self.scale, eventView.frame.size.height - 25 * self.scale)];
        [logoImage setImage:[UIImage imageWithData:eventEntity.shopEntity.logoImage]];
        [eventView addSubview:logoImage];
    } else {
        MDIncrementalImageView *imageView = [[MDIncrementalImageView alloc] initWithFrame:CGRectMake(0 * self.scale, 25 * self.scale, 100 * self.scale, eventView.frame.size.height - 25 * self.scale)];
        [imageView setImageUrl:[NSURL URLWithString:eventEntity.shopEntity.logoUrl]];
        [imageView setShowLoadingIndicatorWhileLoading:YES];
        //[imageView setDelegate:self];
        [eventView addSubview:imageView];
    }
    
    if (eventEntity.imageUrl.length > 0) {
        UIImageView *eventButtonTri = [[UIImageView alloc] initWithFrame:CGRectMake(eventView.frame.size.width - 30 * self.scale, 70 * self.scale, 6 * self.scale, 10 * self.scale)];
        [eventButtonTri setImage:[UIImage imageNamed:@"EventButton_Right"]];
        [eventView addSubview:eventButtonTri];
        
        [eventView addTarget:self action:@selector(tappedEventButton:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        UIImageView *eventButtonTri = [[UIImageView alloc] initWithFrame:CGRectMake(eventView.frame.size.width - 30 * self.scale, 85 * self.scale, 10 * self.scale, 6 * self.scale)];
        [eventButtonTri setImage:[UIImage imageNamed:@"EventButton_Down"]];
        [eventView addSubview:eventButtonTri];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:eventEntity.content ];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentLeft ;
        paragraphStyle.lineSpacing = 3.f * self.scale;
        [paragraphStyle setFirstLineHeadIndent:32 * self.scale];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange (0 ,[eventEntity.content length])];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.scale, eventView.frame.size.height + 5 * self.scale, eventView.frame.size.width - 22.5 * self.scale, 0)];
        [contentLabel setAttributedText:attributedString];
        [contentLabel setNumberOfLines:0];
        [contentLabel setBackgroundColor:AbsoluteClear];
        [contentLabel setTextColor:ThemeRed_103_014_014];
        [contentLabel setFont:[UIFont systemFontOfSize:16 * self.scale]];
        [contentLabel sizeToFit];
        [contentLabel setFrame:(CGRect){contentLabel.frame.origin, CGSizeMake(eventView.frame.size.width - 22.5 * self.scale, contentLabel.frame.size.height)}];
        [contentLabel setTag:-2];
        [eventView addSubview:contentLabel];
        
        [eventView addTarget:self action:@selector(tappedEventButtonShowContent:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return eventView;
}

- (void)tappedEventButtonShowContent:(UIButton *)button {
    
    if (_delegate && [_delegate respondsToSelector:@selector(eventShopView:didStartDragScrollView:)]) {
        [_delegate eventShopView:self didStartDragScrollView:eventScrollView ];
    }
    
    float d = [button viewWithTag:-2].frame.size.height + 10.0f * self.scale;
    
    if (button.frame.size.height == buttonHeight * self.scale) {
        [UIView animateWithDuration:0.4f animations:^{
            [button setFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y, button.frame.size.width, button.frame.size.height + d)];
            [[button viewWithTag:-1] setFrame:CGRectMake([button viewWithTag:-1].frame.origin.x, [button viewWithTag:-1].frame.origin.y, [button viewWithTag:-1].frame.size.width, [button viewWithTag:-1].frame.size.height + d)];
            
            for (UIButton *btn in button.superview.subviews) {
                if (btn.tag > button.tag) {
                    [btn setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y + d, btn.frame.size.width, btn.frame.size.height)];
                }
            }
            
            [eventScrollView setContentSize:CGSizeMake(eventScrollView.frame.size.width, eventScrollView.contentSize.height + d)];
            shifting += d;
        }];
    } else {
        [UIView animateWithDuration:0.4f animations:^{
            [button setFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y, button.frame.size.width, button.frame.size.height - d)];
            [[button viewWithTag:-1] setFrame:CGRectMake([button viewWithTag:-1].frame.origin.x, [button viewWithTag:-1].frame.origin.y, [button viewWithTag:-1].frame.size.width, [button viewWithTag:-1].frame.size.height - d)];
            
            for (UIButton *btn in button.superview.subviews) {
                if (btn.tag > button.tag) {
                    [btn setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y - d, btn.frame.size.width, btn.frame.size.height)];
                }
            }
            
            [eventScrollView setContentSize:CGSizeMake(eventScrollView.frame.size.width, eventScrollView.contentSize.height - d)];
            shifting -= d;
        }];
    }
}

#pragma mark - ScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_delegate && [_delegate respondsToSelector:@selector(eventShopView:didStartDragScrollView:)]) {
        [_delegate eventShopView:self didStartDragScrollView:scrollView ];
    }
    
    if (eventScrollView.contentSize.height - eventScrollView.contentOffset.y < eventScrollView.frame.size.height * 2) {
        [self addListButton];
    }
}

#pragma mark - DDL Delegate

- (void)dropDownListView:(DropDownListView *)dropDownListView didTapOption:(SortType)option {
    if (_delegate && [_delegate respondsToSelector:@selector(eventShopView:didTapDropDownListOption:)]) {
        [_delegate eventShopView:self didTapDropDownListOption:option];
    }
}

@end
