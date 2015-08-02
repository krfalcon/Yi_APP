//
//  EventThemeView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/9.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"

#import "EventEntity.h"

@protocol EventThemeViewDelegate;

@interface EventThemeView : TempletView<UIScrollViewDelegate>
{
    UIScrollView *eventScrollView;
}

- (void)getInfo;

@property (weak,nonatomic)  id<EventThemeViewDelegate>            delegate;
@property(retain,nonatomic) EventEntity                          *eventEntity;

@end

@protocol EventThemeViewDelegate <NSObject>

- (void)eventThemeView:(EventThemeView *)eventThemeView didTapEventButtonWithEventEntity:(EventEntity *)eventEntity;

@end