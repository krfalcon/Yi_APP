//
//  VideoBrandView.h
//  TSOutlets
//
//  Created by krfalcon on 7/30/15.
//  Copyright (c) 2015 奚潇川. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TempletView.h"
#import "VideoEntity.h"

@protocol VideoBrandViewDelegate;

@interface VideoBrandView : TempletView<UIScrollViewDelegate>
{
    UIScrollView*               videoScrollView;
}

@property (weak, nonatomic) id<VideoBrandViewDelegate>   delegate;
@property (retain, nonatomic)NSArray*                   videoListArray;

- (void)refreshSelf;
- (void)createVideoListWithVideoEntityArray;

@end

@protocol VideoBrandViewDelegate <NSObject>

- (void)videoBrandView:(VideoBrandView *)videoBrandView didStartDragScrollView:(UIScrollView *)scrollView;
- (void)videoBrandView:(VideoBrandView *)videoBrandView didPlayerVideo:(NSString *)url;
- (void)videoBrandViewDidRefresh;

@end