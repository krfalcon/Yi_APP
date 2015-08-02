//
//  ShopItemView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/31.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"

#import "ItemEntity.h"

@protocol ShopItemViewDelegate;

@interface ShopItemView : TempletView <UIScrollViewDelegate>
{
    UIScrollView*                                                   itemScrollView;
}

@property(weak, nonatomic) id<ShopItemViewDelegate>                 delegate;
@property (assign, nonatomic) int                                   page;
@property(retain, nonatomic) NSArray*                               itemListArray;

- (void)getInfo;

@end

@protocol ShopItemViewDelegate <NSObject>

- (void)shopItemView:(ShopItemView *)shopItemView didStartDragScrollView:(UIScrollView *)scrollView;
- (void)shopItemView:(ShopItemView *)shopItemView didTapItemButtonWithItemEntity:(ItemEntity *)itemEntity;

@end

