//
//  EventThemeView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/9.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "EventThemeView.h"

@implementation EventThemeView

- (void)getInfo {
    MDIncrementalImageView *imageView = [[MDIncrementalImageView alloc] initWithFrame:CGRectMake(0, self.titleHeight, self.frame.size.width, self.frame.size.width * 270 / 750)];
    [imageView setImageUrl:[NSURL URLWithString:_eventEntity.imageUrl]];
    [imageView setShowLoadingIndicatorWhileLoading:YES];
    //[imageView setDelegate:self];
    [self addSubview:imageView];

    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.05, self.titleHeight + imageView.frame.size.height, self.frame.size.width * 0.9, 40 * self.scale)];
    [self addSubview:headView];

    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headView.frame.size.width, 30 * self.scale)];
    titleView.backgroundColor = ThemeRed;
    titleView.layer.cornerRadius = 15.f * self.scale;
    [headView addSubview:titleView];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 4 * self.scale, titleView.frame.size.width, 20 * self.scale)];
    titleLabel.text = _eventEntity.title;
    [titleLabel setTextColor:AbsoluteWhite];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:20 * self.scale]];
    [titleView addSubview:titleLabel];

    UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(titleView.frame.size.width / 4, 25 * self.scale, titleView.frame.size.width / 2, 20 * self.scale)];
    timeView.backgroundColor = ThemeRed_255_184_194;
    timeView.layer.cornerRadius = 7.5f * self.scale;
    [headView addSubview:timeView];
    
    NSString *timeString = [NSString stringWithFormat:@"%@至%@", _eventEntity.beginTime, _eventEntity.endTime];
    NSMutableAttributedString *str;
    str = [[NSMutableAttributedString alloc] initWithString:timeString];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0 * self.scale] range:NSMakeRange(0, _eventEntity.beginTime.length)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11.0 * self.scale] range:NSMakeRange(_eventEntity.beginTime.length, 1)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0 * self.scale] range:NSMakeRange(_eventEntity.beginTime.length + 1, _eventEntity.beginTime.length)];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:timeView.bounds];
    [timeLabel setBackgroundColor:AbsoluteClear];
    [timeLabel setAttributedText:str];
    [timeLabel setTextColor:ThemeRed_136_028_018];
    [timeLabel setTextAlignment:NSTextAlignmentCenter];
    [timeView addSubview:timeLabel];
    
    eventScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, headView.frame.origin.y + headView.frame.size.height + 20 * self.scale, self.frame.size.width, self.frame.size.height - (headView.frame.origin.y + headView.frame.size.height + 20 * self.scale))];
    [eventScrollView setDelegate:self];
    [self addSubview:eventScrollView];
    
    if (_eventEntity.entityArray == nil || _eventEntity.entityArray.count == 0) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_eventEntity.content ];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentLeft ;
        paragraphStyle.lineSpacing = 3.f * self.scale;
        [paragraphStyle setFirstLineHeadIndent:32 * self.scale];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange (0 ,[_eventEntity.content length])];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(12.5 * self.scale, 20 * self.scale, self.frame.size.width - 25 * self.scale, 0)];
        [contentLabel setAttributedText:attributedString];
        [contentLabel setBackgroundColor:AbsoluteClear];
        [contentLabel setTextColor:ThemeRed_103_014_014];
        [contentLabel setNumberOfLines:0];
        [contentLabel setFont:[UIFont systemFontOfSize:18 * self.scale]];
        [contentLabel sizeToFit];
        [contentLabel setFrame:(CGRect){contentLabel.frame.origin, CGSizeMake(self.frame.size.width - 25 * self.scale, contentLabel.frame.size.height)}];
        [eventScrollView addSubview:contentLabel];
        
        [eventScrollView setContentSize:CGSizeMake(eventScrollView.frame.size.width, 230 * self.scale + contentLabel.frame.size.height)];
    } else {
        
        for (int i = 0; i < _eventEntity.entityArray.count; i++) {
            EventEntity *eventEntity = [_eventEntity.entityArray objectAtIndex:i];
            
            UIButton *eventView = [[UIButton 	alloc] initWithFrame:CGRectMake(20 * self.scale, 10 * self.scale + i * 120 * self.scale, self.frame.size.width - 40 * self.scale, 100 * self.scale)];
            eventView.clipsToBounds = YES;
            [eventView setTag:i];
            [eventScrollView addSubview:eventView];
            
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, eventView.frame.size.width - 12.5 * self.scale, eventView.frame.size.height)];
            backView.layer.cornerRadius = 5 * self.scale;
            backView.userInteractionEnabled = NO;
            backView.backgroundColor = ThemeRed_255_231_237;
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
            [chName setFont:[UIFont boldSystemFontOfSize:18]];
            [eventView addSubview:chName];
            
            UILabel *enName = [[UILabel alloc] initWithFrame:CGRectMake(120 * self.scale, 0 * self.scale, eventView.frame.size.width - 120 * self.scale, 25 * self.scale)];
            [enName setBackgroundColor:AbsoluteClear];
            [enName setText:eventEntity.shopEntity.enName];
            [enName setTextColor:AbsoluteWhite];
            [enName setFont:[UIFont boldSystemFontOfSize:15]];
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
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120 * self.scale, 50 * self.scale, eventView.frame.size.width - 132.5 * self.scale, eventView.frame.size.height - 50 * self.scale)];
            [titleLabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
            [titleLabel setBackgroundColor:AbsoluteClear];
            [titleLabel setText:eventEntity.title];
            [titleLabel setTextColor:ThemeRed_103_014_014];
            [titleLabel setFont:[UIFont systemFontOfSize:20]];
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
                [contentLabel setTag:-2];
                [eventView addSubview:contentLabel];
                
                [eventView addTarget:self action:@selector(tappedEventButtonShowContent:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            //        UIButton *eventButton = [[UIButton alloc] initWithFrame:eventView.bounds];
            //        [eventButton setTag:i];
            //        [eventButton addTarget:self action:@selector(tappedEventButton:) forControlEvents:UIControlEventTouchUpInside];
            //        [eventView addSubview:eventButton];
            
            [eventScrollView setContentSize:CGSizeMake(eventScrollView.frame.size.width, (i + 2) * 120 * self.scale)];
        }
    }
}

- (void)tappedEventButton:(UIButton *)button {
    EventEntity *eventEntity = (EventEntity *)[_eventEntity.entityArray objectAtIndex:button.tag];
    
    if (_delegate && [_delegate respondsToSelector:@selector(eventThemeView:didTapEventButtonWithEventEntity:)]) {
        [_delegate eventThemeView:self didTapEventButtonWithEventEntity:eventEntity];
    }
}

- (void)tappedEventButtonShowContent:(UIButton *)button {
    float d = [button viewWithTag:-2].frame.size.height + 10.0f * self.scale;
    if (button.frame.size.height == 100 * self.scale) {
        [UIView animateWithDuration:0.4f animations:^{
            [button setFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y, button.frame.size.width, button.frame.size.height + d)];
            [[button viewWithTag:-1] setFrame:CGRectMake([button viewWithTag:-1].frame.origin.x, [button viewWithTag:-1].frame.origin.y, [button viewWithTag:-1].frame.size.width, [button viewWithTag:-1].frame.size.height + d)];
            
            for (UIButton *btn in button.superview.subviews) {
                if (btn.tag > button.tag) {
                    [btn setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y + d, btn.frame.size.width, btn.frame.size.height)];
                }
            }
            
            [eventScrollView setContentSize:CGSizeMake(eventScrollView.frame.size.width, eventScrollView.contentSize.height + d)];
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
        }];
    }
}

@end
