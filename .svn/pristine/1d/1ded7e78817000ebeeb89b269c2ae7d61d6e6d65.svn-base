//
//  EventInfoView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/8.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "EventInfoView.h"

@implementation EventInfoView

- (void)getInfo {
    
    UIView *upperView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleHeight, self.frame.size.width, 125 * self.scale)];
    [self addSubview:upperView];
    
    //name
    
    UIView *nameView = [[UIView alloc] initWithFrame:CGRectMake(160 * self.scale, 5 * self.scale, self.frame.size.width - 140 * self.scale, 40 * self.scale)];
    nameView.layer.cornerRadius = 20.f * self.scale;
    [nameView setBackgroundColor:ThemeRed];
    [upperView addSubview:nameView];
    
    UILabel *chNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 * self.scale, 0 * self.scale, nameView.frame.size.width - 40 * self.scale, 25 * self.scale)];
    [chNameLabel setBackgroundColor:[UIColor clearColor]];
    [chNameLabel setText:_eventEntity.shopEntity.chName];
    [chNameLabel setTextColor:AbsoluteWhite];
    [chNameLabel setTextAlignment:NSTextAlignmentLeft];
    [chNameLabel setFont:[UIFont boldSystemFontOfSize:22 * self.scale]];
    [nameView addSubview:chNameLabel];
    
    UILabel *enNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 * self.scale, 25 * self.scale, nameView.frame.size.width - 42 * self.scale, 15 * self.scale)];
    [enNameLabel setBackgroundColor:[UIColor clearColor]];
    [enNameLabel setText:_eventEntity.shopEntity.enName];
    [enNameLabel setTextColor:AbsoluteWhite];
    [enNameLabel setTextAlignment:NSTextAlignmentRight];
    [enNameLabel setFont:[UIFont boldSystemFontOfSize:11 * self.scale]];
    [nameView addSubview:enNameLabel];
    
    UIButton *nameButton = [[UIButton alloc] initWithFrame:nameView.bounds];
    [nameButton setExclusiveTouch:YES];
    [nameButton addTarget:self action:@selector(tappedNameButton) forControlEvents:UIControlEventTouchUpInside];
    [nameView addSubview:nameButton];
    
    //tele
    
    UIButton *telButton = [[UIButton alloc] initWithFrame:CGRectMake(155 * self.scale, 85 * self.scale, 160 * self.scale, 30 * self.scale)];
    [telButton addTarget:self action:@selector(tappedTelButton) forControlEvents:UIControlEventTouchUpInside];
    [upperView addSubview:telButton];
    
    UIView *telView = [[UIView alloc] initWithFrame:CGRectMake(-12.5 * self.scale, 5 * self.scale, 65 * self.scale, 25 * self.scale)];
    telView.layer.cornerRadius = 12.5f * self.scale;
    [telView setUserInteractionEnabled:NO];
    [telView setBackgroundColor:ThemeRed];
    [telButton addSubview:telView];
    
    UILabel *telLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * self.scale, 5 * self.scale, 50 * self.scale, 25 * self.scale)];
    [telLabel setBackgroundColor:[UIColor clearColor]];
    [telLabel setText:@"TEL"];
    [telLabel setTextColor:AbsoluteWhite];
    [telLabel setFont:[UIFont systemFontOfSize:17.f * self.scale]];
    [telButton addSubview:telLabel];
    
    UIView *telLine = [[UIView alloc] initWithFrame:CGRectMake(0, 30 * self.scale - 1, 180 * self.scale, 1)];
    [telLine setBackgroundColor:ThemeRed];
    [telButton addSubview:telLine];
    
    UILabel *tel = [[UILabel alloc] initWithFrame:CGRectMake(55 * self.scale, 13 * self.scale, 125 * self.scale, 15 * self.scale)];
    [tel setBackgroundColor:[UIColor clearColor]];
    [tel setText:_eventEntity.shopEntity.telephone];
    [tel setTextColor:ThemeRed];
    [tel setFont:[UIFont systemFontOfSize:18.f * self.scale]];
    [telButton addSubview:tel];
    
    UIImageView *telTri = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"EventInfoView_TelTri"]];
    [telTri setFrame:CGRectMake(0, 0, 9 * self.scale, 12 * self.scale)];
    [telTri setCenter:CGPointMake(9 * self.scale, 17.5 * self.scale)];
    [telButton addSubview:telTri];
    
    //location
    
    UIButton *locationButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 100 * self.scale, 50 * self.scale, 100 * self.scale, 30 * self.scale)];
    //[locationButton setBackgroundColor:[UIColor yellowColor]];
    [upperView addSubview:locationButton];
    
    UIImageView *locationIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"EventInfoView_LocationIcon"]];
    [locationIcon setFrame:CGRectMake(- 10.5f * self.scale, 0 * self.scale, 21 * self.scale, 30 * self.scale)];
    [locationButton addSubview:locationIcon];
    
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.scale, 0, 80 * self.scale, 30 * self.scale)];
    NSMutableAttributedString *str;
    if (_eventEntity.shopEntity.locationArea.length > 0) {
        str = [[NSMutableAttributedString alloc] initWithString:_eventEntity.shopEntity.locationArea];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:36.0 * self.scale] range:NSMakeRange(0, 1)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22.0 * self.scale] range:NSMakeRange(1, str.length - 1)];
    } else {
        str = [[NSMutableAttributedString alloc] initWithString:@"A111"];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24.0 * self.scale] range:NSMakeRange(0, 1)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0 * self.scale] range:NSMakeRange(1, str.length - 1)];
    }
    [locationLabel setAttributedText:str];
    [locationLabel setTextColor:ThemeRed];
    [locationButton addSubview:locationLabel];
    
    UIView *locationLine = [[UIView alloc] initWithFrame:CGRectMake(0, 30 * self.scale - 1, 100 * self.scale, 1)];
    [locationLine setBackgroundColor:ThemeRed];
    [locationButton addSubview:locationLine];
    
    UIImageView *locationTri = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"EventInfoView_LocationTri"]];
    [locationTri setFrame:CGRectMake(0, 0, 9 * self.scale, 12 * self.scale)];
    [locationTri setCenter:CGPointMake(locationButton.frame.size.width - 10 * self.scale, 20 * self.scale)];
    [locationButton addSubview:locationTri];
    
    if (_eventEntity.shopEntity.logoImage) {
        UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(5 * self.scale, 5 * self.scale, 150 * self.scale, 110 * self.scale)];
        [logoImage setImage:[UIImage imageWithData:_eventEntity.shopEntity.logoImage]];
        //[logoImage setContentMode:UIViewContentModeScaleAspectFit];
        [upperView addSubview:logoImage];
    } else {
        MDIncrementalImageView *imageView = [[MDIncrementalImageView alloc] initWithFrame:CGRectMake(5 * self.scale, 5 * self.scale, 150 * self.scale, 110 * self.scale)];
        //imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView setImageUrl:[NSURL URLWithString:_eventEntity.shopEntity.logoUrl]];
        [imageView setShowLoadingIndicatorWhileLoading:YES];
        //[imageView setDelegate:self];
        //[imageView setTag:(int)avc];
        [upperView addSubview:imageView];
    }
    
    /////////lower
    
    UIView *lowerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleHeight + upperView.frame.size.height, self.frame.size.width, self.frame.size.height - self.titleHeight - upperView.frame.size.height)];
    [self addSubview:lowerView];
    
    UIScrollView *eventScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, lowerView.frame.size.width, lowerView.frame.size.height)];
    //[eventScrollView setDelegate:self];
    [lowerView addSubview:eventScrollView];
    
    if (_eventEntity.imageUrl) {
        MDIncrementalImageView *bigImage = [[MDIncrementalImageView alloc] initWithFrame:CGRectMake(0, 0, lowerView.frame.size.width, lowerView.frame.size.width * 270.f / 750.f)];
        //bigImage.contentMode = UIViewContentModeScaleAspectFill;
        [bigImage setImageUrl:[NSURL URLWithString:_eventEntity.imageUrl]];
        [bigImage setShowLoadingIndicatorWhileLoading:YES];
        [lowerView addSubview:bigImage];
    }
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(7.5 * self.scale, 160 * self.scale, self.frame.size.width - (7.5 - 17.5) * self.scale, 35 * self.scale)];
    titleView.layer.cornerRadius = 17.5 * self.scale;
    titleView.backgroundColor = ThemeRed;
    [eventScrollView addSubview:titleView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(17.5 * self.scale, 0, titleView.frame.size.width, 35 * self.scale)];
    [titleLabel setBackgroundColor:AbsoluteClear];
    [titleLabel setText:_eventEntity.title];
    [titleLabel setTextColor:AbsoluteWhite];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:20 * self.scale]];
    [titleView addSubview:titleLabel];
    
    UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(110 * self.scale, 190 * self.scale, self.frame.size.width - (110 - 12.5) * self.scale, 25 * self.scale)];
    timeView.layer.cornerRadius = 12.5 * self.scale;
    timeView.backgroundColor = ThemeRed_255_184_194;
    [eventScrollView addSubview:timeView];
    
    NSString *timeString = [NSString stringWithFormat:@"%@ 至 %@", _eventEntity.beginTime, _eventEntity.endTime];
    NSMutableAttributedString *timeStr;
    timeStr = [[NSMutableAttributedString alloc] initWithString:timeString];
    [timeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.0 * self.scale] range:NSMakeRange(0, _eventEntity.beginTime.length)];
    [timeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0 * self.scale] range:NSMakeRange(_eventEntity.beginTime.length, 1)];
    [timeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.0 * self.scale] range:NSMakeRange(_eventEntity.beginTime.length + 1, _eventEntity.beginTime.length)];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(12.5 * self.scale, 0 * self.scale, timeView.frame.size.width - 25 * self.scale, 25 * self.scale)];
    [timeLabel setBackgroundColor:AbsoluteClear];
    [timeLabel setAttributedText:timeStr];
    [timeLabel setTextColor:ThemeRed_136_028_018];
    [timeLabel setTextAlignment:NSTextAlignmentCenter];
    [timeView addSubview:timeLabel];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_eventEntity.content ];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft ;
    paragraphStyle.lineSpacing = 3.f * self.scale;
    [paragraphStyle setFirstLineHeadIndent:32 * self.scale];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange (0 ,[_eventEntity.content length])];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(12.5 * self.scale, 230 * self.scale, self.frame.size.width - 25 * self.scale, lowerView.frame.size.height - 230 * self.scale)];
    [contentLabel setAttributedText:attributedString];
    [contentLabel setBackgroundColor:AbsoluteClear];
    [contentLabel setTextColor:ThemeRed_103_014_014];
    [contentLabel setNumberOfLines:0];
    [contentLabel setFont:[UIFont systemFontOfSize:18 * self.scale]];
    [contentLabel sizeToFit];
    [contentLabel setFrame:(CGRect){contentLabel.frame.origin, CGSizeMake(self.frame.size.width - 25 * self.scale, contentLabel.frame.size.height)}];
    [eventScrollView addSubview:contentLabel];
    
    [eventScrollView setContentSize:CGSizeMake(eventScrollView.frame.size.width, 230 * self.scale + contentLabel.frame.size.height)];
}

- (void)tappedTelButton {
    UIWebView *callPhoneWebVw = [[UIWebView alloc] init];
    //NSLog(@"%@", [NSString stringWithFormat:@"tel://%@", _shopEntity.telephone]);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", _eventEntity.shopEntity.telephone]]];
    [callPhoneWebVw loadRequest:request];
    
    [self.superview addSubview:callPhoneWebVw];
}

- (void)tappedNameButton {
    if (_delegate && [_delegate respondsToSelector:@selector(eventInfoViewDidTapShopEntity:)]) {
        [_delegate  eventInfoViewDidTapShopEntity:nil];
    }
}

@end
