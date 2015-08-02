//
//  VideoMallView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/9.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"

#import "VideoEntity.h"

@protocol VideoMallViewDelegate;

@interface VideoMallView : TempletView<UIScrollViewDelegate>
{
    UIScrollView*                                           videoScrollView;
}

@property (weak, nonatomic)   id<VideoMallViewDelegate>     delegate;
@property (retain, nonatomic) NSArray*                      videoListArray;

- (void)refreshSelf;
- (void)createVideoListWithVideoEntityArray;

@end

@protocol VideoMallViewDelegate <NSObject>

- (void)videoMallView:(VideoMallView *)videoMallView didStartDragScrollView:(UIScrollView *)scrollView;
- (void)videoMallView:(VideoMallView *)videoMallView didPlayerVideo:(NSString *)url;
- (void)videoMallViewDidRefresh;

@end
