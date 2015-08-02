//
//  EventInfoView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/8.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"

#import "EventEntity.h"

@protocol EventInfoViewDelegate;

@interface EventInfoView : TempletView

@property (weak,nonatomic) id<EventInfoViewDelegate>             delegate;
- (void)getInfo;

@property(retain,nonatomic) EventEntity                          *eventEntity;

@end

@protocol EventInfoViewDelegate <NSObject>

- (void)eventInfoViewDidTapShopEntity:(ShopEntity *)shopEntity;

@end