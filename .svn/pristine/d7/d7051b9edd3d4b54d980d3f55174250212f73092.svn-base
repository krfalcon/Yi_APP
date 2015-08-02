//
//  ShopVideoView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/7.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ShopVideoView.h"
#import "AppDelegate.h"

@implementation ShopVideoView

- (void)initView {
    videoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleHeight, self.frame.size.width, self.frame.size.height - self.titleHeight)];
    [videoScrollView setShowsVerticalScrollIndicator:NO];
    [videoScrollView setDelegate:self];
    [self addSubview:videoScrollView];
}

- (void)createEventListWithEventEntityArray:(NSArray *)array {
    //NSLog(@"%@", array);
    videoArray = array;
    float h = 10;
    int i = 0;
    for (VideoEntity *entity in array) {
        if (i % 2 == 0) {
            UIView *videoView = [[UIView alloc] initWithFrame:CGRectMake(0, h * self.scale, (self.frame.size.width - 10 * self.scale) / 2, 120 * self.scale)];
            [videoView setClipsToBounds:YES];
            [videoScrollView addSubview:videoView];
            
            MDIncrementalImageView *imageView = [[MDIncrementalImageView alloc] initWithFrame:CGRectMake(7.5 * self.scale, 12.5 * self.scale, videoView.frame.size.width - 7.5 * self.scale, videoView.frame.size.height - 20.f * self.scale)];
            [imageView setImageUrl:[NSURL URLWithString:entity.imageUrl]];
            [imageView setShowLoadingIndicatorWhileLoading:YES];
            [videoView addSubview:imageView];
            
            UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(-25 * self.scale, 0, 175 * self.scale, 25 * self.scale)];
            [titleView.layer setCornerRadius:12.5 * self.scale];
            [titleView setBackgroundColor:ThemeBlue];
            [videoView addSubview:titleView];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 * self.scale, 0, 150 * self.scale, 25 * self.scale)];
            [titleLabel setBackgroundColor:AbsoluteClear];
            [titleLabel setText:entity.title];
            [titleLabel setTextColor:AbsoluteWhite];
            [titleLabel setFont:[UIFont boldSystemFontOfSize:16 * self.scale]];
            [titleView addSubview:titleLabel];
            
            UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(70 * self.scale, videoView.frame.size.height - 15 * self.scale, videoView.frame.size.width - 62.5 * self.scale, 15 * self.scale)];
            timeView.layer.cornerRadius = 7.5 * self.scale;
            [timeView setBackgroundColor:ThemeBlue_123_204_225];
            [videoView addSubview:timeView];
            
            UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 * self.scale, 0, timeView.frame.size.width - 12.5 * self.scale, 15 * self.scale)];
            [timeLabel setBackgroundColor:AbsoluteClear];
            [timeLabel setTextColor:ThemeBlue_018_050_085];
            [timeLabel setText:entity.time];
            [timeLabel setTextAlignment:NSTextAlignmentRight];
            [timeLabel setFont:[UIFont systemFontOfSize:12 * self.scale]];
            [timeView addSubview:timeLabel];
            
            UIButton *videoButton = [[UIButton alloc] initWithFrame:videoView.bounds];
            [videoButton setTag:i];
            [videoButton setExclusiveTouch:YES];
            [videoButton addTarget:self action:@selector(tappedVideoButton:) forControlEvents:UIControlEventTouchUpInside];
            [videoView addSubview:videoButton];
        } else {
            UIView *videoView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 + 5 * self.scale, h * self.scale, (self.frame.size.width - 10 * self.scale) / 2, 120 * self.scale)];
            [videoView setClipsToBounds:YES];
            [videoScrollView addSubview:videoView];
            
            MDIncrementalImageView *imageView = [[MDIncrementalImageView alloc] initWithFrame:CGRectMake(0 * self.scale, 12.5 * self.scale, videoView.frame.size.width - 7.5 * self.scale, videoView.frame.size.height - 20.f * self.scale)];
            [imageView setImageUrl:[NSURL URLWithString:entity.imageUrl]];
            [imageView setShowLoadingIndicatorWhileLoading:YES];
            [videoView addSubview:imageView];
            
            UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(videoView.frame.size.width - 150 * self.scale, 0, 175 * self.scale, 25 * self.scale)];
            [titleView.layer setCornerRadius:12.5 * self.scale];
            [titleView setBackgroundColor:ThemeBlue];
            [videoView addSubview:titleView];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 * self.scale, 0, 145 * self.scale, 25 * self.scale)];
            [titleLabel setBackgroundColor:AbsoluteClear];
            [titleLabel setText:entity.title];
            [titleLabel setTextColor:AbsoluteWhite];
            [titleLabel setTextAlignment:NSTextAlignmentRight];
            [titleLabel setFont:[UIFont boldSystemFontOfSize:16 * self.scale]];
            [titleView addSubview:titleLabel];
            
            UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(- 7.5 * self.scale, videoView.frame.size.height - 15 * self.scale, videoView.frame.size.width - 62.5 * self.scale, 15 * self.scale)];
            timeView.layer.cornerRadius = 7.5 * self.scale;
            [timeView setBackgroundColor:ThemeBlue_123_204_225];
            [videoView addSubview:timeView];
            
            UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(12.5 * self.scale, 0, timeView.frame.size.width - 12.5 * self.scale, 15 * self.scale)];
            [timeLabel setBackgroundColor:AbsoluteClear];
            [timeLabel setTextColor:ThemeBlue_018_050_085];
            [timeLabel setText:entity.time];
            [timeLabel setTextAlignment:NSTextAlignmentLeft];
            [timeLabel setFont:[UIFont systemFontOfSize:12 * self.scale]];
            [timeView addSubview:timeLabel];
            
            UIButton *videoButton = [[UIButton alloc] initWithFrame:videoView.bounds];
            [videoButton setTag:i];
            [videoButton setExclusiveTouch:YES];
            [videoButton addTarget:self action:@selector(tappedVideoButton:) forControlEvents:UIControlEventTouchUpInside];
            [videoView addSubview:videoButton];
            
            h += 130;
        }
        
        i ++;
    }
}

- (void)tappedVideoButton:(UIButton *)button {
    VideoEntity *videoEntity = (VideoEntity *)[videoArray objectAtIndex:button.tag];

    if (_delegate && [_delegate respondsToSelector:@selector(shopVideoView:didPlayerVideo:)]) {
        [_delegate shopVideoView:self didPlayerVideo:videoEntity.videoUrl];
    }
}

#pragma mark - ScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_delegate && [_delegate respondsToSelector:@selector(shopVideoView:didStartDragScrollView:)]) {
        [_delegate shopVideoView:self didStartDragScrollView:scrollView ];
    }
}

@end
