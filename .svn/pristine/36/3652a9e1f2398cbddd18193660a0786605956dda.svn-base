//
//  ShopInfoViewController.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/23.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "MotherViewController.h"
#import "ShopInfoView.h"
#import "ShopItemView.h"
#import "ShopEventView.h"
#import "ShopVideoView.h"
#import "ShopFoodView.h"

@class ShopInfoViewController;

@interface ShopInfoViewController : MotherViewController
<
    ShopInfoViewDelegate,
    ShopEventViewDelegate,
    ShopVideoViewDelegate,
    ShopFoodViewDelegate,
    ShopItemViewDelegate
>
{
    ShopInfoView                *shopInfoView;
    ShopItemView                *shopItemView;
    ShopEventView               *shopEventView;
    ShopVideoView               *shopVideoView;
    ShopFoodView                *shopFoodView;
}

@property(retain,nonatomic) ShopEntity                          *shopEntity;

- (void)switchToFoodReserveView;

@end
