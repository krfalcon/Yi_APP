//
//  MessageView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/19.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "MessageView.h"
#import "MJRefresh.h"

#define notTodayColor [UIColor colorWithRed:138.f/255.f green:138.f/255.f blue:138.f/255.f alpha:1]

@implementation MessageView

- (void)initView {
    messageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleHeight, self.frame.size.width, self.frame.size.height - self.titleHeight)];
    [self addSubview:messageScrollView];
    
    [messageScrollView addHeaderWithTarget:self action:@selector(refresh)];
    [messageScrollView headerBeginRefreshing];
}

- (void)refresh {
    if (_delegate && [_delegate respondsToSelector:@selector(messageViewDidRefresh)]) {
        [_delegate messageViewDidRefresh];
    }
}

- (void)refreshMessageView:(NSArray *)array {
    [self initMessageView:array];
    
    [messageScrollView headerEndRefreshing];
}

- (void)initMessageView:(NSArray *)array {
    for (id d in messageScrollView.subviews) {
        if (![d isMemberOfClass:[MJRefreshHeaderView class]]) [d removeFromSuperview];
    }
    
    float   h = 0;
    int     i = 0;
    BOOL    today = YES;
    BOOL    first = YES;
    messageArray = array;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDate = [df stringFromDate:[NSDate date]];
    
    for (MessageEntity *ety in array) {
        //NSLog(@"%@", ety.date);
        if (![[ety.date substringToIndex:10] isEqual:currentDate]) {
            currentDate = [ety.date substringToIndex:10];
            
            today = NO;
            first = YES;
            if (first) {
                UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, h, selfWidth, 40 * self.scale)];
                timeLabel.text = [ety.date substringToIndex:10];
                timeLabel.textColor = notTodayColor;
                timeLabel.textAlignment = NSTextAlignmentCenter;
                timeLabel.font = [UIFont systemFontOfSize:20.f * self.scale];
                timeLabel.tag = i;
                [messageScrollView addSubview:timeLabel];
                
                UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, h + 20 * self.scale - 1, selfWidth * 0.3, 2)];
                [leftLine setBackgroundColor:notTodayColor];
                leftLine.tag = i;
                [messageScrollView addSubview:leftLine];
                
                UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(selfWidth * 0.7, h + 20 * self.scale - 1, selfWidth * 0.3, 2)];
                [rightLine setBackgroundColor:notTodayColor];
                rightLine.tag = i;
                [messageScrollView addSubview:rightLine];
                
                h += 40 * self.scale;
                
                first = NO;
            }
        } else {
            if (first) {
                if (today) {
                    UILabel *todayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, h, selfWidth, 40 * self.scale)];
                    todayLabel.text = @"今天";
                    todayLabel.textColor = ThemeRed;
                    todayLabel.textAlignment = NSTextAlignmentCenter;
                    todayLabel.font = [UIFont systemFontOfSize:20.f * self.scale];
                    [messageScrollView addSubview:todayLabel];
                    
                    h += 40 * self.scale;
                } else {
                    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, h, selfWidth, 40 * self.scale)];
                    timeLabel.text = [ety.date substringToIndex:10];
                    timeLabel.textColor = notTodayColor;
                    timeLabel.textAlignment = NSTextAlignmentCenter;
                    timeLabel.font = [UIFont systemFontOfSize:20.f * self.scale];
                    timeLabel.tag = i;
                    [messageScrollView addSubview:timeLabel];
                    
                    UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, h + 20 * self.scale - 1, selfWidth * 0.3, 2)];
                    [leftLine setBackgroundColor:notTodayColor];
                    leftLine.tag = i;
                    [messageScrollView addSubview:leftLine];
                    
                    UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(selfWidth * 0.7, h + 20 * self.scale - 1, selfWidth * 0.3, 2)];
                    [rightLine setBackgroundColor:notTodayColor];
                    rightLine.tag = i;
                    [messageScrollView addSubview:rightLine];
                    
                    h += 40 * self.scale;
                }
                first = NO;
            }
        }
        
        UIButton *messageButton = [[UIButton alloc] initWithFrame:CGRectMake(10 * self.scale, h + 10 * self.scale, selfWidth - 20 * self.scale, 60 * self.scale)];
        messageButton.layer.cornerRadius = 15.f * self.scale;
        messageButton.layer.borderColor = today ? ThemeRed.CGColor : notTodayColor.CGColor;
        messageButton.layer.borderWidth = 1.5f;
        [messageButton setExclusiveTouch:YES];
        [messageButton setClipsToBounds:YES];
        [messageButton setTag:i];
        [messageButton addTarget:self action:@selector(tappedMessageButton:) forControlEvents:UIControlEventTouchUpInside];
        [messageScrollView addSubview:messageButton];
        
        [messageButton addSubview:[self getMessageIconWithType:ety.type andToday:today]];
        
        [messageButton addSubview:[self getMessageTitleWithType:ety.type andToday:today]];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(60 * self.scale, 30 * self.scale, self.frame.size.width - 110 * self.scale, 30 * self.scale)];
        [contentLabel setText:ety.content];
        [contentLabel setTextColor:today ? ThemeRed : notTodayColor];
        [contentLabel setFont:[UIFont systemFontOfSize:18 * self.scale]];
        [messageButton addSubview:contentLabel];
        
        UIImageView *triImage = [[UIImageView alloc] initWithFrame:CGRectMake(messageButton.frame.size.width - 20 * self.scale, 24 * self.scale, 6 * self.scale, 12 * self.scale)];
        [triImage setImage:[UIImage imageNamed:today ? @"MessageTri" : @"MessageTri_NotToday"]];
        [triImage setTag:-11];
        [messageButton addSubview:triImage];
        
        if ([ety.type intValue] == 0) {
            UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.scale, messageButton.frame.size.height + 10 * self.scale, messageButton.frame.size.width - 20 * self.scale, 0)];
            [contentLabel setText:ety.point];
            [contentLabel setTextColor:today ? Color(65, 65, 65, 1) : notTodayColor];
            [contentLabel setFont:[UIFont systemFontOfSize:18 * self.scale]];
            [contentLabel sizeToFit];
            [contentLabel setTag:-10];
            [messageButton addSubview:contentLabel];
        }
        
        h += 80 * self.scale;
        
        i ++;
        
        [messageScrollView setContentSize:CGSizeMake(messageScrollView.frame.size.width, h)];
    }
}

#pragma mark - Button Event
- (void)tappedMessageButton:(UIButton *)button {
    MessageEntity *ety = messageArray[button.tag];
    if ([ety.type intValue] == 0) {
        [self slideMessageButton:button];
    } else {
    if (_delegate && [_delegate respondsToSelector:@selector(messageViewDidTapMessageButtonWithMessageEntity:)]) {
        [_delegate messageViewDidTapMessageButtonWithMessageEntity:ety];
    }
    }
}

- (void)slideMessageButton:(UIButton *)button {
    float d = [button viewWithTag:-10].frame.size.height + 20.0f * self.scale;
    
    if (button.frame.size.height == 60 * self.scale) {
        [UIView animateWithDuration:0.4f animations:^{
            [button setFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y, button.frame.size.width, button.frame.size.height + d)];
            [button viewWithTag:-11].transform = CGAffineTransformMakeRotation(M_PI_2);
            
            for (id btn in button.superview.subviews) {
                if ([btn tag] > button.tag) {
                    [btn setFrame:CGRectMake([btn frame].origin.x, [btn frame].origin.y + d, [btn frame].size.width, [btn frame].size.height)];
                }
            }
            
            [messageScrollView setContentSize:CGSizeMake(messageScrollView.frame.size.width, messageScrollView.contentSize.height + d)];
        }];
    } else {
        [UIView animateWithDuration:0.4f animations:^{
            [button setFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y, button.frame.size.width, button.frame.size.height - d)];
            [button viewWithTag:-11].transform = CGAffineTransformMakeRotation(0);
            
            for (UIButton *btn in button.superview.subviews) {
                if (btn.tag > button.tag) {
                    [btn setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y - d, btn.frame.size.width, btn.frame.size.height)];
                }
            }
            
            [messageScrollView setContentSize:CGSizeMake(messageScrollView.frame.size.width, messageScrollView.contentSize.height - d)];
        }];
    }
}

- (UIImageView *)getMessageIconWithType:(NSString *)type andToday:(BOOL)today {
    UIImage *resImage;
    
    switch ([type intValue]) {
        case 0:
            resImage = [UIImage imageNamed:today ? @"MessageSystem" : @"MessageSystem_NotToday"];
            break;
        case 1:
            resImage = [UIImage imageNamed:today ? @"MessageMallEvent" : @"MessageMallEvent_NotToday"];
            break;
        case 2:
            resImage = [UIImage imageNamed:today ? @"MessageBrandEvent" : @"MessageBrandEvent_NotToday"];
            break;
        case 3:
            resImage = [UIImage imageNamed:today ? @"MessageFeedback" : @"MessageFeedback_NotToday"];
            break;
        case 4:
            resImage = [UIImage imageNamed:today ? @"MessageQueue" : @"MessageQueue_NotToday"];
            break;
        default:
            break;
    }
    
    UIImageView *messageIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10 * self.scale, 10 * self.scale, 40 * self.scale, 40 * self.scale)];
    [messageIcon setImage:resImage];
    
    return messageIcon;
}

- (UILabel *)getMessageTitleWithType:(NSString *)type andToday:(BOOL)today {
    UILabel *messageTitle = [[UILabel alloc] initWithFrame:CGRectMake(60 * self.scale, 0, self.frame.size.width - 110 * self.scale, 30 * self.scale)];
    [messageTitle setFont:[UIFont systemFontOfSize:18 * self.scale]];
    
    switch ([type intValue]) {
        case 0:
            [messageTitle setText:@"系统消息"];
            break;
        case 1:
            [messageTitle setText:@"活动消息"];
            break;
        case 2:
            [messageTitle setText:@"活动消息"];
            break;
        case 3:
            [messageTitle setText:@"客服消息"];
            break;
        case 4:
            [messageTitle setText:@"餐排消息"];
            break;
        default:
            break;
    }
    
    [messageTitle setTextColor:today ? Color(65, 65, 65, 1) : notTodayColor];
    
    return messageTitle;
}

@end
