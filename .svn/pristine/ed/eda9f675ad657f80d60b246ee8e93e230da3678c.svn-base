//
//  ShopViewController.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/17.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "MotherViewController.h"

#import "ShopListView.h"
#import "ShopEntity.h"

@class ShopViewController;

@interface ShopViewController : MotherViewController
<
    ShopListViewDelegate
>
{
    ShopListView*                                       shopListView;
    
    NSArray*                                            originArray;
    
    NSString*                                           currentString;
    NSString*                                           currentArea;
    NSString*                                           currentCategory;
    SortType                                            currentType;
    
    BOOL                                                onRestaurant;
}

@property(retain,nonatomic) NSString*                   category;

- (void)getShopList;
- (void)rebuildShopList;

@end

