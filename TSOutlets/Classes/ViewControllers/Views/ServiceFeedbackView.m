//
//  ServiceFeedbackView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/3.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ServiceFeedbackView.h"
#import "MJRefresh.h"

@implementation ServiceFeedbackView

- (void)initView {
    UIView *upperView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleHeight, self.frame.size.width, 60.f * self.scale)];
    [self addSubview:upperView];
    
    UIButton *manualButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.15f, 15.f * self.scale, self.frame.size.width * 0.7f, 30 * self.scale)];
    manualButton.layer.cornerRadius = 15.f * self.scale;
    [manualButton setBackgroundColor:ThemeYellowOrange];
    [manualButton addTarget:self action:@selector(tappedCustomerButton) forControlEvents:UIControlEventTouchUpInside];
    [upperView addSubview:manualButton];
    
    UILabel *manualLabel = [[UILabel alloc] initWithFrame:manualButton.bounds];
    [manualLabel setBackgroundColor:[UIColor clearColor]];
    [manualLabel setText:@"我要反馈"];
    [manualLabel setTextColor:AbsoluteWhite];
    [manualLabel setTextAlignment:NSTextAlignmentCenter];
    [manualLabel setFont:[UIFont systemFontOfSize:19 * self.scale]];
    [manualButton addSubview:manualLabel];

    //lowerView
    
    UIView *lowerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleHeight + upperView.frame.size.height, self.frame.size.width, self.frame.size.height - self.titleHeight - upperView.frame.size.height)];
    [self addSubview:lowerView];
    
    feedbackScrollView = [[UIScrollView alloc] initWithFrame:lowerView.bounds];
    [feedbackScrollView setDelegate:self];
    [feedbackScrollView setContentSize:CGSizeMake(feedbackScrollView.frame.size.width, feedbackScrollView.frame.size.height + 1)];
    [lowerView addSubview:feedbackScrollView];
    
    [feedbackScrollView addHeaderWithTarget:self action:@selector(refresh)];
    [feedbackScrollView headerBeginRefreshing];
}

- (void)refresh {
    if (_delegate && [_delegate respondsToSelector:@selector(serviceFeedbackViewDidRefresh)]) {
        [_delegate serviceFeedbackViewDidRefresh];
    }
}

- (void)createFeedbackScrollWithArray:(NSArray *)array {
    for (id d in feedbackScrollView.subviews) {
        if (![d isMemberOfClass:[MJRefreshHeaderView class]]) [d removeFromSuperview];
    }
    
    float h = 10 * self.scale;
    int i = 0;
    
    for (FeedbackEntity *ety in array) {
        UIButton *feedbackView = [[UIButton alloc] initWithFrame:CGRectMake(20 * self.scale, h, self.frame.size.width - 40 * self.scale, 120 * self.scale)];
        feedbackView.layer.cornerRadius = 5.f * self.scale;
        feedbackView.layer.borderWidth = 1.5f;
        feedbackView.layer.borderColor = Color(255, 180, 170, 1).CGColor;
        feedbackView.backgroundColor = Color(255, 238, 228, 1);
        [feedbackView setExclusiveTouch:YES];
        [feedbackView setClipsToBounds:YES];
        [feedbackView setTag:i];
        [feedbackView addTarget:self action:@selector(tappedFeedbackButton:) forControlEvents:UIControlEventTouchUpInside];
        [feedbackScrollView addSubview:feedbackView];
        
        UILabel *questrionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.scale, 10 * self.scale, feedbackView.frame.size.width - 20 * self.scale, 80 * self.scale)];
        questrionLabel.text = ety.question;
        questrionLabel.textColor =  ThemeYellowFont;
        questrionLabel.font = [UIFont systemFontOfSize:18.f * self.scale];
        questrionLabel.numberOfLines = 0;
        [questrionLabel sizeToFit];
        [feedbackView addSubview:questrionLabel];
        
        if (ety.reply) {
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"信息已处理，点击查看" ];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.f * self.scale] range:NSMakeRange(0, 6)];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22.f * self.scale] range:NSMakeRange(6, 4)];
            [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(6, 4)];
            
            UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.scale, 90 * self.scale, feedbackView.frame.size.width - 20 * self.scale, 20 * self.scale)];
            [statusLabel setAttributedText:attributedString];
            [statusLabel setTextAlignment:NSTextAlignmentRight];
            [statusLabel setTextColor:Color(255, 110, 120, 1)];
            [feedbackView addSubview:statusLabel];
            
            UIView *replyLine = [[UIView alloc] initWithFrame:CGRectMake(10 * self.scale, feedbackView.frame.size.height + 2 * self.scale, feedbackView.frame.size.width - 20 * self.scale, 1.f)];
            [replyLine setBackgroundColor:Color(255, 180, 170, 1)];
            [feedbackView addSubview:replyLine];
            
            UILabel *replyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.scale, feedbackView.frame.size.height + 10 * self.scale, feedbackView.frame.size.width - 20 * self.scale, 80 * self.scale)];
            replyLabel.text = ety.reply;
            replyLabel.textColor =  ThemeYellowFont;
            replyLabel.font = [UIFont systemFontOfSize:18.f * self.scale];
            replyLabel.tag = -1;
            replyLabel.numberOfLines = 0;
            [replyLabel sizeToFit];
            [feedbackView addSubview:replyLabel];
        } else {
            UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.scale, 90 * self.scale, feedbackView.frame.size.width - 20 * self.scale, 20 * self.scale)];
            [statusLabel setText:@"处理中"];
            [statusLabel setTextAlignment:NSTextAlignmentRight];
            [statusLabel setTextColor:Color(138, 138, 138, 1)];
            [statusLabel setFont:[UIFont systemFontOfSize:22.f * self.scale]];
            [feedbackView addSubview:statusLabel];
            
            [feedbackView setEnabled:NO];
        }
        
        h += 140 * self.scale;
        i++;
    }
    
    h += 130 * self.scale;
    
    [feedbackScrollView setContentSize:CGSizeMake(feedbackScrollView.frame.size.width, h)];
}

- (void)refreshFeedbackScrollWithArray:(NSArray *)array {
    [feedbackScrollView headerEndRefreshing];
    [self createFeedbackScrollWithArray:array];
}

- (void)tappedFeedbackButton:(UIButton *)button {
    
    float d = [button viewWithTag:-1].frame.size.height + 20.0f * self.scale;
    
    if (button.frame.size.height == 120 * self.scale) {
        [UIView animateWithDuration:0.4f animations:^{
            [button setFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y, button.frame.size.width, button.frame.size.height + d)];
            //[[button viewWithTag:-1] setFrame:CGRectMake([button viewWithTag:-1].frame.origin.x, [button viewWithTag:-1].frame.origin.y, [button viewWithTag:-1].frame.size.width, [button viewWithTag:-1].frame.size.height + d)];
            
            for (UIButton *btn in button.superview.subviews) {
                if (btn.tag > button.tag) {
                    [btn setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y + d, btn.frame.size.width, btn.frame.size.height)];
                }
            }
            
            [feedbackScrollView setContentSize:CGSizeMake(feedbackScrollView.frame.size.width, feedbackScrollView.contentSize.height + d)];
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
            
            [feedbackScrollView setContentSize:CGSizeMake(feedbackScrollView.frame.size.width, feedbackScrollView.contentSize.height - d)];
        }];
    }
}

- (void)tappedCustomerButton
{
    if (_delegate && [_delegate respondsToSelector:@selector(serviceFeedbackViewDidTapFeedbackButton)]) {
        [_delegate serviceFeedbackViewDidTapFeedbackButton];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_delegate && [_delegate respondsToSelector:@selector(serviceFeedbackView:didStartDragScrollView:)]) {
        [_delegate serviceFeedbackView:self didStartDragScrollView:scrollView ];
    }
}

@end
