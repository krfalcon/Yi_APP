//
//  EventMallView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/2.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "EventMallView.h"
#import "MJRefresh.h"

@implementation EventMallView

- (void)initView {
    df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    
    eventScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleHeight, self.frame.size.width, self.frame.size.height - self.titleHeight)];
    [eventScrollView setShowsVerticalScrollIndicator:NO];
    [eventScrollView setDelegate:self];
    [self addSubview:eventScrollView];
    
    [eventScrollView addHeaderWithTarget:self action:@selector(refresh)];
}

- (void)refresh {
    if (_delegate && [_delegate respondsToSelector:@selector(eventMallViewDidRefresh)]) {
        [_delegate eventMallViewDidRefresh];
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
    
    for (int i = 0; i < _eventListArray.count; i++) {
        EventEntity *eventEntity = [_eventListArray objectAtIndex:i];
        
        UIView *eventView = [[UIView alloc] initWithFrame:CGRectMake(0 * self.scale, 10 * self.scale + i * 170 * self.scale, self.frame.size.width - 0 * self.scale, 155 * self.scale)];
        eventView.clipsToBounds = YES;
        [eventScrollView addSubview:eventView];
        if ([[df dateFromString:eventEntity.endTime] compare:[NSDate date]] == NSOrderedAscending) {
            MDIncrementalImageView *imageView = [[MDIncrementalImageView alloc] initWithFrame:CGRectMake(0 * self.scale, 0 * self.scale, self.frame.size.width, 130 * self.scale)];
            [imageView setShowLoadingIndicatorWhileLoading:YES];
            [imageView setIsBlack:YES];
            [imageView setImageUrl:[NSURL URLWithString:eventEntity.imageUrl]];
            [eventView addSubview:imageView];
            
            UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 25 / 2 * self.scale, 130 * self.scale, eventView.frame.size.width / 2 + 25 * self.scale, 25 * self.scale)];
            timeView.layer.cornerRadius = 12.5 * self.scale;
            timeView.backgroundColor = Color(205, 205, 205, 1);
            [eventView addSubview:timeView];
            
            UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(- 25 / 2 * self.scale, 110 * self.scale, eventView.frame.size.width - 35 * self.scale, 50 / 2 * self.scale)];
            titleView.layer.cornerRadius = 25.f / 2 * self.scale;
            titleView.backgroundColor = Color(136, 136, 136, 1);
            [eventView addSubview:titleView];
            
            NSString *timeString = [NSString stringWithFormat:@"已结束"];
            NSMutableAttributedString *str;
            str = [[NSMutableAttributedString alloc] initWithString:timeString];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0 * self.scale] range:NSMakeRange(0, 3)];
            
            UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2, 130 * self.scale, self.frame.size.width / 2, 25 * self.scale)];
            [timeLabel setBackgroundColor:AbsoluteClear];
            [timeLabel setAttributedText:str];
            [timeLabel setTextColor:Color(123, 123, 123, 1)];
            [timeLabel setTextAlignment:NSTextAlignmentCenter];
            [eventView addSubview:timeLabel];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.scale, 110 * self.scale, eventView.frame.size.width - 40 * self.scale, 50 / 2 * self.scale)];
            [titleLabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
            [titleLabel setBackgroundColor:AbsoluteClear];
            [titleLabel setText:eventEntity.title];
            [titleLabel setTextColor:AbsoluteWhite];
            [titleLabel setFont:[UIFont systemFontOfSize:17]];
            [eventView addSubview:titleLabel];
        } else {
            MDIncrementalImageView *imageView = [[MDIncrementalImageView alloc] initWithFrame:CGRectMake(0 * self.scale, 0 * self.scale, self.frame.size.width, 130 * self.scale)];
            [imageView setShowLoadingIndicatorWhileLoading:YES];
            [imageView setIsBlack:NO];
            [imageView setImageUrl:[NSURL URLWithString:eventEntity.imageUrl]];
            [eventView addSubview:imageView];
            
            UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 25 / 2 * self.scale, 130 * self.scale, eventView.frame.size.width / 2 + 25 * self.scale, 25 * self.scale)];
            timeView.layer.cornerRadius = 12.5 * self.scale;
            timeView.backgroundColor = ThemeRed_255_184_194;
            [eventView addSubview:timeView];
            
            UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(- 25 / 2 * self.scale, 110 * self.scale, eventView.frame.size.width - 35 * self.scale, 50 / 2 * self.scale)];
            titleView.layer.cornerRadius = 25.f / 2 * self.scale;
            titleView.backgroundColor = ThemeRed;
            [eventView addSubview:titleView];
            
            NSString *timeString = [NSString stringWithFormat:@"%@至%@", eventEntity.beginTime, eventEntity.endTime];
            NSMutableAttributedString *str;
            str = [[NSMutableAttributedString alloc] initWithString:timeString];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0 * self.scale] range:NSMakeRange(0, eventEntity.beginTime.length)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0 * self.scale] range:NSMakeRange(eventEntity.beginTime.length, 1)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0 * self.scale] range:NSMakeRange(eventEntity.beginTime.length + 1, eventEntity.beginTime.length)];
            
            UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2, 130 * self.scale, self.frame.size.width / 2, 25 * self.scale)];
            [timeLabel setBackgroundColor:AbsoluteClear];
            [timeLabel setAttributedText:str];
            [timeLabel setTextColor:ThemeRed_136_028_018];
            [timeLabel setTextAlignment:NSTextAlignmentCenter];
            [eventView addSubview:timeLabel];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.scale, 110 * self.scale, eventView.frame.size.width - 40 * self.scale, 50 / 2 * self.scale)];
            [titleLabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
            [titleLabel setBackgroundColor:AbsoluteClear];
            [titleLabel setText:eventEntity.title];
            [titleLabel setTextColor:AbsoluteWhite];
            [titleLabel setFont:[UIFont systemFontOfSize:17]];
            [eventView addSubview:titleLabel];
        }
        
        UIButton *eventButton = [[UIButton alloc] initWithFrame:eventView.bounds];
        [eventButton setTag:i];
        [eventButton addTarget:self action:@selector(tappedEventButton:) forControlEvents:UIControlEventTouchUpInside];
        [eventView addSubview:eventButton];
        
        [eventScrollView setContentSize:CGSizeMake(eventScrollView.frame.size.width, ((i + 1) * 170 + 100) * self.scale > eventScrollView.frame.size.height ? ((i + 1) * 170 + 100) * self.scale : eventScrollView.frame.size.height + 1)];
    }
}

- (void)tappedEventButton:(UIButton *)button {
    EventEntity *eventEntity = (EventEntity *)[_eventListArray objectAtIndex:button.tag];
    
    if (_delegate && [_delegate respondsToSelector:@selector(eventMallView:didTapEventButtonWithEventEntity:)]) {
        [_delegate eventMallView:self didTapEventButtonWithEventEntity:eventEntity];
    }
}

#pragma mark - ScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_delegate && [_delegate respondsToSelector:@selector(eventMallView:didStartDragScrollView:)]) {
        [_delegate eventMallView:self didStartDragScrollView:scrollView ];
    }
}

@end
