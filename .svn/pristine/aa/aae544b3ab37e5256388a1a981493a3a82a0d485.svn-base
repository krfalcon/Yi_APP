//
//  ShopItemView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/31.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ShopItemView.h"

@implementation ShopItemView

- (void)getInfo {
    _page = 0;
    
    itemScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleHeight, self.frame.size.width, self.frame.size.height - self.titleHeight)];
    [itemScrollView setShowsVerticalScrollIndicator:NO];
    [itemScrollView setDelegate:self];
    [self addSubview:itemScrollView];
    
    [self addListButton];
}

- (void)addListButton {
    if (_itemListArray.count == 0) return;
    
    if (_page * 10 + 10 < _itemListArray.count) {
        for (int i = 0; i < 10; i++) {
            ItemEntity *ety = (ItemEntity *)[_itemListArray objectAtIndex:i + _page * 10];
            [itemScrollView addSubview:[self createListButtonWithItemEntity:ety andTag:i + _page * 10]];
        }
        
        _page += 1;
        [itemScrollView setContentSize:CGSizeMake(itemScrollView.frame.size.width, _page * 1500 * self.scale)];
    } else if (_page * 10 < _itemListArray.count) {
        for (int i = _page * 10; i < _itemListArray.count; i++) {
            ItemEntity *ety = (ItemEntity *)_itemListArray[i];
            [itemScrollView addSubview:[self createListButtonWithItemEntity:ety andTag:i]];
        }
        
        _page += 1;
        [itemScrollView setContentSize:CGSizeMake(itemScrollView.frame.size.width, _itemListArray.count / 2 * 300 * self.scale + 120 * self.scale)];
    } else {
        return;
    }
}

- (UIView *)createListButtonWithItemEntity:(ItemEntity *)entity andTag:(int)tag {
    UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(187.5 * (tag % 2) * self.scale + 15 * self.scale, 300 * (tag / 2) * self.scale, 155 * self.scale, 300 * self.scale)];
    
    MDIncrementalImageView *itemImage = [[MDIncrementalImageView alloc] initWithFrame:CGRectMake(10 * self.scale, 12.5 * self.scale, 140 * self.scale, 225 * self.scale)];
    [itemImage setImageUrl:[NSURL URLWithString:entity.carouselArray.firstObject]];
    [itemView addSubview:itemImage];
    
    UILabel *itemName = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.scale, 240 * self.scale, itemImage.frame.size.width, 20 * self.scale)];
    [itemName setText:entity.title];
    [itemName setTextColor:ThemeBlue];
    [itemName setTextAlignment:NSTextAlignmentCenter];
    [itemName setFont:[UIFont systemFontOfSize:16 * self.scale]];
    [itemView addSubview:itemName];
    
    UIView *priceView = [[UIView alloc] initWithFrame:CGRectMake(30 * self.scale, 270 * self.scale, 120 * self.scale, 20 * self.scale)];
    priceView.layer.cornerRadius = 10 * self.scale;
    priceView.backgroundColor = ThemeBlue_177_231_255;
    [itemView addSubview:priceView];
    
    NSString *timeString = [NSString stringWithFormat:@"%@", entity.price];
    NSMutableAttributedString *priceStr;
    priceStr = [[NSMutableAttributedString alloc] initWithString:timeString];
    [priceStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, entity.price.length)];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 * self.scale, 0 * self.scale, priceView.frame.size.width - 5 * self.scale, 20 * self.scale)];
    [priceLabel setBackgroundColor:AbsoluteClear];
    [priceLabel setAttributedText:priceStr];
    [priceLabel setTextColor:ThemeBlue_123_204_225];
    [priceLabel setTextAlignment:NSTextAlignmentRight];
    [priceLabel setFont:[UIFont systemFontOfSize:14 * self.scale]];
    [priceView addSubview:priceLabel];
    
    UIView *saleView = [[UIView alloc] initWithFrame:CGRectMake(10 * self.scale, 265 * self.scale, 85 * self.scale, 25 * self.scale)];
    saleView.layer.cornerRadius = 12.5 * self.scale;
    saleView.backgroundColor = ThemeBlue;
    [itemView addSubview:saleView];
    
    UILabel *saleLabel = [[UILabel alloc] initWithFrame:saleView.bounds];
    [saleLabel setBackgroundColor:AbsoluteClear];
    [saleLabel setText:entity.sale];
    [saleLabel setTextColor:AbsoluteWhite];
    [saleLabel setTextAlignment:NSTextAlignmentCenter];
    [saleLabel setFont:[UIFont systemFontOfSize:20 * self.scale]];
    [saleView addSubview:saleLabel];
    
    UIButton *itemButton = [[UIButton alloc] initWithFrame:itemView.bounds];
    [itemButton setExclusiveTouch:YES];
    [itemButton setTag:tag];
    [itemButton addTarget:self action:@selector(tappedItemButton:) forControlEvents:UIControlEventTouchUpInside];
    [itemView addSubview:itemButton];
    
    return itemView;
}

#pragma mark - Button Events

- (void)tappedItemButton:(UIButton *)sender {
    ItemEntity *ety = [_itemListArray objectAtIndex:sender.tag];
    if (_delegate && [_delegate respondsToSelector:@selector(shopItemView:didTapItemButtonWithItemEntity:)]) {
        [_delegate shopItemView:self didTapItemButtonWithItemEntity:ety];
    }
}

#pragma mark - ScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_delegate && [_delegate respondsToSelector:@selector(shopItemView:didStartDragScrollView:)]) {
        [_delegate shopItemView:self didStartDragScrollView:scrollView ];
    }
    //瀑布流显示
    if (itemScrollView.contentSize.height - itemScrollView.contentOffset.y < itemScrollView.frame.size.height * 2) {
        [self addListButton];
    }
}

@end
