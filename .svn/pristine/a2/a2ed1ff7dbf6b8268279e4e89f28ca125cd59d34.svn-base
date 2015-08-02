//
//  ShopInfoView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/19.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"
#import "ShopTitleView.h"
#import "CarouselScrollView.h"

#import "ShopEntity.h"

@protocol ShopInfoViewDelegate;

@interface ShopInfoView : TempletView<MDIncrementalImageViewDelegate, UIScrollViewDelegate>
{
}

- (void)getInfo;

@property (weak, nonatomic) id<ShopInfoViewDelegate>            delegate;
@property(retain,nonatomic) ShopEntity                          *shopEntity;
@end

@protocol ShopInfoViewDelegate <NSObject>

- (void)shopInfoView:(ShopInfoView *)shopInfoView didStartDragScrollView:(UIScrollView *)scrollView;
@end