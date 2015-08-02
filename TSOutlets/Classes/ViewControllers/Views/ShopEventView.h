//
//  ShopEventView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/31.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"
#import "ShopTitleView.h"

#import "ShopEntity.h"
#import "EventEntity.h"

@protocol ShopEventViewDelegate;

@interface ShopEventView : TempletView <UIScrollViewDelegate>
{
    UIScrollView*                                                   eventScrollView;
}

- (void)getInfo;
- (void)createEventList;

@property(weak, nonatomic) id<ShopEventViewDelegate>                delegate;
@property(retain, nonatomic) ShopEntity*                            shopEntity;
@property(retain, nonatomic) NSArray*                               eventListArray;
@end

@protocol ShopEventViewDelegate <NSObject>

- (void)shopEventView:(ShopEventView *)shopEventView didStartDragScrollView:(UIScrollView *)scrollView;
- (void)shopEventView:(ShopEventView *)shopEventView didTapEventButtonWithEventEntity:(EventEntity *)eventEntity;

@end
