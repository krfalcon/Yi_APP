//
//  ShopVideoView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/7.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"
#import "VideoEntity.h"

@protocol ShopVideoViewDelegate;

@interface ShopVideoView : TempletView<UIScrollViewDelegate>
{
    UIScrollView        *videoScrollView;
    NSArray             *videoArray;
}

@property(weak, nonatomic) id<ShopVideoViewDelegate>                delegate;

- (void)createEventListWithEventEntityArray:(NSArray *)array;

@end

@protocol ShopVideoViewDelegate <NSObject>

- (void)shopVideoView:(ShopVideoView *)shopVideoView didStartDragScrollView:(UIScrollView *)scrollView;
- (void)shopVideoView:(ShopVideoView *)shopVideoView didPlayerVideo:(NSString *)url;

@end
