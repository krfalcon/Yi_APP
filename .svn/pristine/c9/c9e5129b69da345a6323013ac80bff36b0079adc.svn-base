//
//  EventShopView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/2.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"

#import "DropDownListView.h"
#import "EventEntity.h"

@protocol EventShopViewDelegate;

@interface EventShopView : TempletView<DropDownListViewDelegate, UIScrollViewDelegate>
{
    UIScrollView*                                           eventScrollView;
    CGFloat                                                 shifting;
}

@property (weak, nonatomic)   id<EventShopViewDelegate>     delegate;
@property (assign, nonatomic) int                           page;
@property (retain, nonatomic) NSArray*                      eventListArray;

- (void)refreshSelf;
- (void)createEventListWithEventEntityArray;

@end

@protocol EventShopViewDelegate <NSObject>

- (void)eventShopView:(EventShopView *)eventShopView didStartDragScrollView:(UIScrollView *)scrollView;
- (void)eventShopView:(EventShopView *)eventShopView didTapEventButtonWithEventEntity:(EventEntity *)eventEntity;
- (void)eventShopView:(EventShopView *)eventShopView didTapDropDownListOption:(SortType)option;
- (void)eventShopViewDidRefresh;

@end