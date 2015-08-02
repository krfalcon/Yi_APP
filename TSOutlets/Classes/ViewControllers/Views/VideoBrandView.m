//
//  VideoBrandView.m
//  TSOutlets
//
//  Created by krfalcon on 7/30/15.
//  Copyright (c) 2015 奚潇川. All rights reserved.
//

#import "VideoBrandView.h"
#import "MJRefresh.h"

@implementation VideoBrandView

- (void)initView
{
    videoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleHeight, self.frame.size.width, self.frame.size.height - self.titleHeight)];
    [videoScrollView setDelegate:self];
    [self addSubview:videoScrollView];
    
    [videoScrollView addHeaderWithTarget:self action:@selector(refresh)];
}

- (void)refresh
{
    if (_delegate && [_delegate respondsToSelector:@selector(videoBrandViewDidRefresh)]) {
        [_delegate videoBrandViewDidRefresh];
    }
}

- (void)refreshSelf
{
    [videoScrollView headerEndRefreshing];
    
    [self createVideoListWithVideoEntityArray];
}

- (void)createVideoListWithVideoEntityArray
{
    for (id d in videoScrollView.subviews) {
        if (![d isMemberOfClass:[MJRefreshHeaderView class]])
            [d removeFromSuperview];
    }
            float h = 10 * self.scale;
            int i = 0;
            
            for (VideoEntity* ety in _videoListArray) {
                UIView *videoView = [[UIView alloc]initWithFrame:CGRectMake(0, h, self.frame.size.width, 230 * self.scale)];
                [videoView setClipsToBounds:YES];
                [videoScrollView addSubview:videoView];
                
                MDIncrementalImageView *imageView = [[MDIncrementalImageView alloc] initWithFrame:CGRectMake(7.5*self.scale, 12.5*self.scale, videoView.frame.size.width - 15 * self.scale, videoView.frame.size.height - 20.f *self.scale)];
                [imageView setShowLoadingIndicatorWhileLoading:YES];
                [imageView setImageUrl:[NSURL URLWithString:ety.imageUrl]];
                [videoView addSubview:imageView];
                
                UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(-25 * self.scale, 0, 275*self.scale, 25 *self.scale)];
                [titleView.layer setCornerRadius:12.5*self.scale];
                [titleView setBackgroundColor:ThemeRed];
                [videoView addSubview:titleView];
                
                UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50 * self.scale, 0, 230 * self.scale, 25 * self.scale)];
                [titleLabel setBackgroundColor:AbsoluteClear];
                [titleLabel setText:ety.title];
                [titleLabel setTextColor:AbsoluteWhite];
                [titleLabel setFont:[UIFont boldSystemFontOfSize:16 * self.scale]];
                [titleView addSubview:titleLabel];
                
                UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(videoView.frame.size.width - 80 * self.scale, videoView.frame.size.height - 15 * self.scale, 87.5 * self.scale, 15 * self.scale)];
                timeView.layer.cornerRadius = 7.5 * self.scale;
                [timeView setBackgroundColor:ThemeRed_255_184_194];
                [videoView addSubview:timeView];
                
                UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 * self.scale, 0, timeView.frame.size.width - 12.5 * self.scale, 15 * self.scale)];
                [timeLabel setBackgroundColor:AbsoluteClear];
                [timeLabel setTextColor:ThemeRed_136_028_018];
                [timeLabel setText:ety.time];
                [timeLabel setTextAlignment:NSTextAlignmentRight];
                [timeLabel setFont:[UIFont systemFontOfSize:12 * self.scale]];
                [timeView addSubview:timeLabel];
                
                UIButton *videoButton = [[UIButton alloc] initWithFrame:videoView.bounds];
                [videoButton setTag:i];
                [videoButton setExclusiveTouch:YES];
                [videoButton addTarget:self action:@selector(tappedVideoButton:) forControlEvents:UIControlEventTouchUpInside];
                [videoView addSubview:videoButton];
                
                h += 250 * self.scale;
                i ++;
            }
            
            [videoScrollView setContentSize:CGSizeMake(videoScrollView.frame.size.width, h + 100 * self.scale > videoScrollView.frame.size.height ? h + 100 * self.scale : videoScrollView.frame.size.height + 1)];
    }
    
    - (void)tappedVideoButton:(UIButton *)button {
        VideoEntity *videoEntity = (VideoEntity *)[_videoListArray objectAtIndex:button.tag];
        
        if (_delegate && [_delegate respondsToSelector:@selector(videoBrandView:didPlayerVideo:)]) {
            [_delegate videoBrandView:self didPlayerVideo:videoEntity.videoUrl ];
        }
    }
    
/*#pragma mark - ScrollView Delegate
    
    - (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
        if (_delegate && [_delegate respondsToSelector:@selector(videoBrandView:didStartDragScrollView:)]) {
            [_delegate videoBandView:self didStartDragScrollView:scrollView ];
        }
    }
 */
@end

