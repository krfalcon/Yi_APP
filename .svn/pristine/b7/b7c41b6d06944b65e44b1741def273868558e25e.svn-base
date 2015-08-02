//
//  EventMallView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/2.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"

#import "CarouselScrollView.h"
#import "EventEntity.h"

@protocol EventMallViewDelegate;

@interface EventMallView : TempletView<UIScrollViewDelegate>
{
    UIScrollView*                                           eventScrollView;
    NSDateFormatter*                                        df;
}

@property (weak,nonatomic)   id<EventMallViewDelegate>      delegate;
@property (retain,nonatomic) NSArray*                       eventListArray;

- (void)refreshSelf;
- (void)createEventListWithEventEntityArray;

@end

@protocol EventMallViewDelegate <NSObject>

- (void)eventMallView:(EventMallView *)eventMallView didStartDragScrollView:(UIScrollView *)scrollView;
- (void)eventMallView:(EventMallView *)eventMallView didTapEventButtonWithEventEntity:(EventEntity *)eventEntity;
- (void)eventMallViewDidRefresh;

@end