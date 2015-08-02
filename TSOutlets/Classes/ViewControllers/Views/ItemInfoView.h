//
//  ItemInfoView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/7.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"

#import "CarouselScrollView.h"
#import "ItemEntity.h"

@protocol ItemInfoViewDelegate;

@interface ItemInfoView : TempletView

@property (weak,nonatomic) id<ItemInfoViewDelegate>             delegate;
- (void)getInfo;

@property(retain,nonatomic) ItemEntity                          *itemEntity;

@end

@protocol ItemInfoViewDelegate <NSObject>

- (void)itemInfoViewDidTapShopEntity:(ShopEntity *)shopEntity;

@end
