//
//  ShopFoodView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/8.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"
#import "ShopTitleView.h"

#import "ShopEntity.h"

@protocol ShopFoodViewDelegate;

@interface ShopFoodView : TempletView <UIScrollViewDelegate>
{
    UIScrollView*                                                   foodScrollView;
    UIScrollView*                                                   foodStepScrollView;
    UIScrollView*                                                   reservedScrollView;
}

@property(weak, nonatomic) id<ShopFoodViewDelegate>                 delegate;
@property(retain, nonatomic) ShopEntity*                            shopEntity;

- (void)getInfo;
- (void)refreshInfo;

@end

@protocol ShopFoodViewDelegate <NSObject>

- (void)shopFoodViewDidTapReserveButtonWithNumber:(NSString *)number andShopID:(NSString *)shopID;
- (void)shopFoodViewDidTapCancelButtonWithShopID:(NSString *)shopID;
- (void)shopFoodView:(ShopFoodView *)shopFoodView didStartDragScrollView:(UIScrollView *)scrollView;

@end
