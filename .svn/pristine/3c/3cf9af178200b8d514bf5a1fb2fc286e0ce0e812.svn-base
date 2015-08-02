//
//  ShopEventView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/31.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ShopEventView.h"

@implementation ShopEventView

- (void)getInfo {
    
    UIView *upperView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleHeight, self.frame.size.width, 160 * self.scale)];
    [self addSubview:upperView];
    
    [upperView addSubview:[[[ShopTitleView alloc] initWithFrame:self.bounds] getShopTitleViewWithShopEntity:_shopEntity]];

    UIView *lowerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleHeight + upperView.frame.size.height, self.frame.size.width, self.frame.size.height - self.titleHeight - upperView.frame.size.height)];
    [self addSubview:lowerView];
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:lowerView.bounds];
    [backgroundImage setImage:[UIImage imageNamed:@"ShopEventView_Background"]];
    [lowerView addSubview:backgroundImage];
    
    eventScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, lowerView.frame.size.width, lowerView.frame.size.height)];
    [eventScrollView setDelegate:self];
    [eventScrollView setShowsVerticalScrollIndicator:NO];
    [lowerView addSubview:eventScrollView];
}

- (void)createEventList{
    //NSLog(@"%@", array);
    float h = 10;
    
    for (int i = 0; i < _eventListArray.count; i++) {
        EventEntity *entity = (EventEntity *)[_eventListArray objectAtIndex:i];
        if (entity.imageUrl.length > 0) {
            UIButton *eventView = [[UIButton alloc] initWithFrame:CGRectMake(10 * self.scale, h * self.scale, self.frame.size.width - 20 * self.scale, 180 * self.scale)];
            [eventView setBackgroundColor:ThemeBlue_232_248_255];
            [eventView addTarget:self action:@selector(tappedEventButton:) forControlEvents:UIControlEventTouchUpInside];
            [eventView setTag:i];
            [eventView setExclusiveTouch:YES];
            [eventView setClipsToBounds:YES];
            [eventScrollView addSubview:eventView];
            
            UIView *titleBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, eventView.frame.size.width, 30 * self.scale)];
            [titleBack setBackgroundColor:ThemeBlue_028_188_255];
            [titleBack setUserInteractionEnabled:NO];
            [eventView addSubview:titleBack];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.scale, 0, eventView.frame.size.width, 30 * self.scale)];
            [titleLabel setBackgroundColor:[UIColor clearColor]];
            [titleLabel setText:entity.title];
            [titleLabel setTextColor:AbsoluteWhite];
            [titleLabel setFont:[UIFont boldSystemFontOfSize:19 * self.scale]];
            [titleBack addSubview:titleLabel];
            
            NSString *timeString = [NSString stringWithFormat:@"%@至%@", entity.beginTime, entity.endTime];
            NSMutableAttributedString *str;
            str = [[NSMutableAttributedString alloc] initWithString:timeString];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0 * self.scale] range:NSMakeRange(0, entity.beginTime.length)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11.0 * self.scale] range:NSMakeRange(entity.beginTime.length, 1)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0 * self.scale] range:NSMakeRange(entity.beginTime.length + 1, entity.beginTime.length)];
            
            UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(eventView.frame.size.width / 2, 30 * self.scale, eventView.frame.size.width / 2, 25 * self.scale)];
            [timeLabel setBackgroundColor:ThemeBlue_177_231_255];
            [timeLabel setAttributedText:str];
            [timeLabel setTextColor:ThemeBlue_018_050_085];
            [timeLabel setTextAlignment:NSTextAlignmentCenter];
            [eventView addSubview:timeLabel];
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:entity.content];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.alignment = NSTextAlignmentLeft ;
            paragraphStyle.lineSpacing = 3.f * self.scale;
            [paragraphStyle setFirstLineHeadIndent:32 * self.scale];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange (0 ,[entity.content length])];
            
            UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.scale, 35 * self.scale, eventView.frame.size.width / 2 - 5 * self.scale, eventView.frame.size.height - 30.f * self.scale)];
            [contentLabel setBackgroundColor:[UIColor clearColor]];
            //[contentLabel setText:entity.content];
            [contentLabel setAttributedText:attributedString];
            [contentLabel setTextColor:ThemeBlue];
            [contentLabel setNumberOfLines:0];
            [contentLabel setFont:[UIFont systemFontOfSize:16 * self.scale]];
            [contentLabel sizeToFit];
            [eventView addSubview:contentLabel];
            
            MDIncrementalImageView *imageView = [[MDIncrementalImageView alloc] initWithFrame:CGRectMake(eventView.frame.size.width / 2, 55 * self.scale, eventView.frame.size.width * 0.5f, eventView.frame.size.height - 55.f * self.scale)];
            //imageView.contentMode = UIViewContentModeScaleAspectFit;
            [imageView setShowLoadingIndicatorWhileLoading:YES];
            [imageView setImageUrl:[NSURL URLWithString:entity.imageUrl]];
            [eventView addSubview:imageView];
            
            h += 180 + 5;
        } else {
            UIButton *eventView = [[UIButton alloc] initWithFrame:CGRectMake(10 * self.scale, h * self.scale, self.frame.size.width - 20 * self.scale, 115 * self.scale)];
            [eventView setBackgroundColor:ThemeBlue_232_248_255];
            [eventView addTarget:self action:@selector(tappedEventButtonShowContent:) forControlEvents:UIControlEventTouchUpInside];
            [eventView setTag:i];
            [eventView setExclusiveTouch:YES];
            [eventView setClipsToBounds:YES];
            [eventScrollView addSubview:eventView];
            
            NSString *timeString = [NSString stringWithFormat:@"%@至%@", entity.beginTime, entity.endTime];
            NSMutableAttributedString *str;
            str = [[NSMutableAttributedString alloc] initWithString:timeString];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0 * self.scale] range:NSMakeRange(0, entity.beginTime.length)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11.0 * self.scale] range:NSMakeRange(entity.beginTime.length, 1)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0 * self.scale] range:NSMakeRange(entity.beginTime.length + 1, entity.beginTime.length)];
            
            UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(eventView.frame.size.width / 2, 0 * self.scale, eventView.frame.size.width / 2, 25 * self.scale)];
            [timeLabel setBackgroundColor:ThemeBlue_177_231_255];
            [timeLabel setAttributedText:str];
            [timeLabel setTextColor:ThemeBlue_018_050_085];
            [timeLabel setTextAlignment:NSTextAlignmentCenter];
            [eventView addSubview:timeLabel];
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:entity.content ];
//            attributedString = [[NSMutableAttributedString alloc] initWithString:@"长的要死的内容长的要死的内容长的要死的内容长的要死的内容长的要死的内容长的要死的内容长的要死的内容长的要死的内容长的要死的内容长的要死的内容长的要死的内容长的要死的内容长的要死的内容长的要死的内容长的要死的内容长的要死的内容长的要死的内容长的要死的内容长的要死的内容长的要死的内容长的要死的内容长的要死的内容长的要死的内容长的要死的内容"];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.alignment = NSTextAlignmentLeft ;
            paragraphStyle.lineSpacing = 2.f * self.scale;
            [paragraphStyle setFirstLineHeadIndent:32 * self.scale];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange (0 ,[entity.content length])];
            
            UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.scale, 30 * self.scale, eventView.frame.size.width - 5 * self.scale, eventView.frame.size.height - 30.f * self.scale)];
            [contentLabel setBackgroundColor:[UIColor clearColor]];
            //[contentLabel setText:entity.content];
            [contentLabel setAttributedText:attributedString];
            [contentLabel setTextColor:ThemeBlue];
            [contentLabel setNumberOfLines:0];
            [contentLabel setFont:[UIFont systemFontOfSize:16 * self.scale]];
            [contentLabel sizeToFit];
            [contentLabel setTag:-2];
            [contentLabel setFrame:(CGRect){contentLabel.frame.origin, CGSizeMake(eventView.frame.size.width - 5 * self.scale, contentLabel.frame.size.height)}];
            [eventView addSubview:contentLabel];
            
            h += 115 + 5;
        }
        
    }
    
    h += 180 * self.scale;
    
    [eventScrollView setContentSize:CGSizeMake(eventScrollView.frame.size.width, h * self.scale)];
}

- (void)tappedEventButton:(UIButton *)button {
    EventEntity *eventEntity = (EventEntity *)[_eventListArray objectAtIndex:button.tag];
    
    if (_delegate && [_delegate respondsToSelector:@selector(shopEventView:didTapEventButtonWithEventEntity:)]) {
        [_delegate shopEventView:self didTapEventButtonWithEventEntity:eventEntity];
    }
}

- (void)tappedEventButtonShowContent:(UIButton *)button {
    
    if (_delegate && [_delegate respondsToSelector:@selector(shopEventView:didStartDragScrollView:)]) {
        [_delegate shopEventView:self didStartDragScrollView:eventScrollView ];
    }
    
    float d = [button viewWithTag:-2].frame.size.height + 10.0f * self.scale - 85 * self.scale;
    
    if (d < 0) return;
    
    if (button.frame.size.height == 115 * self.scale) {
        [UIView animateWithDuration:0.4f animations:^{
            [button setFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y, button.frame.size.width, button.frame.size.height + d)];
            //[[button viewWithTag:-1] setFrame:CGRectMake([button viewWithTag:-1].frame.origin.x, [button viewWithTag:-1].frame.origin.y, [button viewWithTag:-1].frame.size.width, [button viewWithTag:-1].frame.size.height + d)];
            
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
            //[[button viewWithTag:-1] setFrame:CGRectMake([button viewWithTag:-1].frame.origin.x, [button viewWithTag:-1].frame.origin.y, [button viewWithTag:-1].frame.size.width, [button viewWithTag:-1].frame.size.height - d)];
            
            for (UIButton *btn in button.superview.subviews) {
                if (btn.tag > button.tag) {
                    [btn setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y - d, btn.frame.size.width, btn.frame.size.height)];
                }
            }
            
            [eventScrollView setContentSize:CGSizeMake(eventScrollView.frame.size.width, eventScrollView.contentSize.height - d)];
        }];
    }
}

#pragma mark - ScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_delegate && [_delegate respondsToSelector:@selector(shopEventView:didStartDragScrollView:)]) {
        [_delegate shopEventView:self didStartDragScrollView:scrollView ];
    }
}

@end
