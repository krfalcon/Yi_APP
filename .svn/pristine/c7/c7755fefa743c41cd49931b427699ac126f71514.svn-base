//
//  ShopInfoView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/19.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ShopInfoView.h"

@implementation ShopInfoView

- (void)getInfo {
    
    UIView *upperView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleHeight, self.frame.size.width, 160 * self.scale)];
    [self addSubview:upperView];
    
    [upperView addSubview:[[[ShopTitleView alloc] initWithFrame:self.bounds] getShopTitleViewWithShopEntity:_shopEntity]];
    
    //lower view
    
    UIView *lowerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleHeight + upperView.frame.size.height, self.frame.size.width, self.frame.size.height - self.titleHeight - upperView.frame.size.height)];
    [self addSubview:lowerView];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:lowerView.bounds];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setDelegate:self];
    [lowerView addSubview:scrollView];
    
    CarouselScrollView *bigImage = [[CarouselScrollView alloc] initWithFrame:CGRectMake(0, 0, lowerView.frame.size.width, lowerView.frame.size.width * 400.f / 750.f) andImages:_shopEntity.carouselArray andTheme:@"Blue"];
    [scrollView addSubview:bigImage];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(lowerView.frame.size.width * 0.05, bigImage.frame.size.height, lowerView.frame.size.width * 0.9, 5.f * self.scale)];
    [lineImage setImage:[UIImage imageNamed:@"ShopInfoLine"]];
    [scrollView addSubview:lineImage];
    
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(20 * self.scale, bigImage.frame.size.height + 5 * self.scale, self.frame.size.width - 40 * self.scale, 0)];
    [content setText:_shopEntity.introduction];
    [content setTextColor:ThemeBlue];
    [content setFont:[UIFont systemFontOfSize:16.5 * self.scale]];
    [content setNumberOfLines:0];
    [content sizeToFit];
    [scrollView addSubview:content];
    
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, content.frame.size.height + bigImage.frame.size.height + 105 * self.scale)];
}

#pragma mark - ScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_delegate && [_delegate respondsToSelector:@selector(shopInfoView:didStartDragScrollView:)]) {
        [_delegate shopInfoView:self didStartDragScrollView:scrollView ];
    }
}

@end
