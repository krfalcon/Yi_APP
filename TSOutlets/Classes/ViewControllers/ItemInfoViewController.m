//
//  ItemInfoViewController.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/7.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ItemInfoViewController.h"

@interface ItemInfoViewController ()

@end

@implementation ItemInfoViewController

#pragma mark - Init View
- (void)initFirstViewWithParameter:(NSDictionary *)parameter
{
    if (!itemInfo) {
        itemInfo = [[ItemInfoView alloc] initWithFrame:self.view.bounds];
        [itemInfo setDelegate:self];
        [itemInfo setItemEntity:_itemEntity];
        [itemInfo getInfo];
        [self.view addSubview:itemInfo];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldRecordLog" object:[NSString stringWithFormat:@"Product: %@", _itemEntity.itemID]];
    }
}

#pragma mark - Delegate
- (void)itemInfoViewDidTapShopEntity:(ShopEntity *)shopEntity {
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_itemEntity.shopEntity, @"entity", nil];
    [self pushViewControllerWithViewControllerType:ViewControllerTypeShopInfo andParameter:dic];
}

@end
