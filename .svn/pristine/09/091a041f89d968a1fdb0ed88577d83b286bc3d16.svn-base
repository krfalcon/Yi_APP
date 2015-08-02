//
//  VideoShopView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/9.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"
#import "DropDownListView.h"
#import "SearchTextView.h"

#import "VideoEntity.h"

@protocol VideoShopViewDelegate;

@interface VideoShopView : TempletView<DropDownListViewDelegate, SearchTextViewDelegate, UIScrollViewDelegate>
{
    UIScrollView*                                           videoScrollView;
    UIScrollView*                                           searchScrollView;
}

@property (weak, nonatomic)   id<VideoShopViewDelegate>     delegate;
@property (retain, nonatomic) NSArray*                      videoListArray;
@property (retain, nonatomic) NSArray*                      videoSearchArray;
@property (assign, nonatomic) int                           page;
@property (assign, nonatomic) int                           searchpage;


- (void)refreshSelf;
- (void)createVideoListWithVideoEntityArray;

- (void)addSearchList;
- (void)removeSearchList;
- (void)didSearch;

@end

@protocol VideoShopViewDelegate <NSObject>

- (void)videoShopView:(VideoShopView *)videoShopView didStartDragScrollView:(UIScrollView *)scrollView;
- (void)videoShopView:(VideoShopView *)videoShopView didTapDropDownListOption:(SortType)option;
- (void)videoShopView:(VideoShopView *)videoShopView didSearch:(NSString *)string;
- (void)videoShopView:(VideoShopView *)videoShopView didStartTexting:(NSString *)string;
- (void)videoShopView:(VideoShopView *)videoShopView didEndTexting:(NSString *)string;
- (void)videoShopView:(VideoShopView *)videoShopView didPlayerVideo:(NSString *)url;
- (void)videoShopViewDidRefresh;

@end