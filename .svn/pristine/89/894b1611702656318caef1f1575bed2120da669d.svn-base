//
//  CollectionView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/13.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "CollectionView.h"

@implementation CollectionView

- (void)initView {
    _page = 0;
    
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleHeight + 60, self.frame.size.width, self.frame.size.height - self.titleHeight - 60)];
    [mainScrollView setContentSize:CGSizeMake(mainScrollView.frame.size.width, mainScrollView.frame.size.height + 2)];
    [mainScrollView setShowsVerticalScrollIndicator:NO];
    [mainScrollView setDelegate:self];
    [self addSubview:mainScrollView];
    
    DropDownListView *ddlView = [[DropDownListView alloc] initWithFrame:CGRectMake(0, self.titleHeight, 100, 60) andSelections:0 andColor:ThemeBlue];
    [ddlView setDelegate:self];
    [self addSubview:ddlView];
    
    searchView = [[SearchTextView alloc] initWithFrame:CGRectMake(110, self.titleHeight, mainScrollView.frame.size.width - 115, 60) andColor:ThemeBlue_123_204_225];
    [searchView setDelegate:self];
    [self addSubview:searchView];
    
}

- (void)resetListScrollView {
    _page = 0;
    
    [[mainScrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self addListButton];
}

- (void)addListButton {
    
    if (_shopListArray.count > 0 && _page == 0) {
        UIImageView *bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mainScrollView.frame.size.width, 1.5f)];
        [bottomLine setImage:[UIImage imageNamed:@"ShopListLine"]];
        [mainScrollView addSubview:bottomLine];
    }
    
    if (_shopListArray.count == 0) return;
    
    if (_page * 10 + 10 < _shopListArray.count) {
        for (int i = 0; i < 10; i++) {
            ShopEntity *ety = (ShopEntity *)[_shopListArray objectAtIndex:i + _page * 10];
            [mainScrollView addSubview:[self createListButtonWithFrame:CGRectMake(0, i * 105 * self.scale + _page * 1050 * self.scale, mainScrollView.frame.size.width, 105 * self.scale) andShopEntity:ety andTag:i + _page * 10]];
        }
        
        _page += 1;
        [mainScrollView setContentSize:CGSizeMake(mainScrollView.frame.size.width, _page * 1050 * self.scale)];
    } else if (_page * 10 < _shopListArray.count) {
        for (int i = _page * 10; i < _shopListArray.count; i++) {
            ShopEntity *ety = (ShopEntity *)[_shopListArray objectAtIndex:i];
            [mainScrollView addSubview:[self createListButtonWithFrame:CGRectMake(0, i * 105 * self.scale, mainScrollView.frame.size.width, 105 * self.scale) andShopEntity:ety andTag:i]];
        }
        
        _page += 1;
        [mainScrollView setContentSize:CGSizeMake(mainScrollView.frame.size.width, _shopListArray.count * 105 * self.scale + 120 * self.scale)];
    } else {
        return;
    }
}

- (UIView *)createListButtonWithFrame:(CGRect)frame andShopEntity:(ShopEntity *)ety andTag:(int)tag {
    UIView *listButton = [[UIView alloc] initWithFrame:frame];
    //[listButton setBackgroundColor:[UIColor yellowColor]];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width * 0.f, 0, frame.size.width * 1.f, frame.size.height)];
    [button setTag:tag];
    [button addTarget:self action:@selector(tappedShopInfoButton:) forControlEvents:UIControlEventTouchUpInside];
    [listButton addSubview:button];
    //图标
    
    if (ety.logoImage) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width * 0.1f, frame.size.height * 0.1f, frame.size.width * 0.41f, frame.size.height * 0.8f)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView setImage:[UIImage imageWithData:ety.logoImage]];
        [listButton addSubview:imageView];
    } else {
        MDIncrementalImageView *imageView = [[MDIncrementalImageView alloc] initWithFrame:CGRectMake(frame.size.width * 0.05f, frame.size.height * 0.1f, frame.size.width * 0.38f, frame.size.height * 0.8f)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView setShowLoadingIndicatorWhileLoading:YES];
        [imageView setImageUrl:[NSURL URLWithString:ety.logoUrl]];
        [listButton addSubview:imageView];
    }
    
    if (ety.hasEvent) {
        UIImageView *imageView =  [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width * 0.36f, frame.size.height * 0.0f, frame.size.width * 0.14f, frame.size.height * 0.4f)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView setImage:[UIImage imageNamed:@"ShopListView_Event"]];
        [listButton addSubview:imageView];
    }
    
    UIView *categoryView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width * 0.5f, frame.size.height * 0.6, frame.size.width * 0.5f, frame.size.height * 0.2)];
    [categoryView setUserInteractionEnabled:NO];
    [listButton addSubview:categoryView];
    
    UIImageView *categoryImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.height * 0.2, frame.size.height * 0.2)];
    [categoryImage setImage:[self getCategoryImageWithCategory:[ety.category intValue]]];
    [categoryView addSubview:categoryImage];
    
    UILabel *chName = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width * 0.5f, frame.size.height * 0.2, frame.size.width * 0.5f, frame.size.height * 0.2)];
    [chName setBackgroundColor:[UIColor clearColor]];
    [chName setText:ety.chName];
    [chName setTextColor:ThemeBlue];
    [chName setFont:[UIFont systemFontOfSize:25.f * self.scale]];
    [listButton addSubview:chName];
    
    UILabel *enName = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width * 0.5f, frame.size.height * 0.4, frame.size.width * 0.5f, frame.size.height * 0.2)];
    [enName setBackgroundColor:[UIColor clearColor]];
    [enName setText:ety.enName];
    [enName setTextColor:ThemeBlue];
    [enName setFont:[UIFont systemFontOfSize:15.f * self.scale]];
    [listButton addSubview:enName];
    
    NSMutableAttributedString *str;
    if (ety.locationArea.length > 0) {
        str = [[NSMutableAttributedString alloc] initWithString:ety.locationArea];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25.0 * self.scale] range:NSMakeRange(0, 1)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0 * self.scale] range:NSMakeRange(1, str.length - 1)];
    } else {
        str = [[NSMutableAttributedString alloc] initWithString:@""];
    }
    
    UILabel *locationArea = [[ UILabel alloc] initWithFrame:CGRectMake(frame.size.width * 0.8f, frame.size.height * 0.65f, frame.size.width * 0.2f, frame.size.height * 0.25)];
    [locationArea setBackgroundColor:[UIColor clearColor]];
    [locationArea setAttributedText:str];
    [locationArea setTextColor:ThemeBlue];
    //[locationArea setFont:[UIFont systemFontOfSize:20]];
    [listButton addSubview:locationArea];
    
    UIImageView *bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height - 1, frame.size.width, 1.5f)];
    [bottomLine setImage:[UIImage imageNamed:@"ShopListLine"]];
    [listButton addSubview:bottomLine];
    
    return listButton;
}

#pragma mark - Search Bar

- (void)addSearchList {
    if (!searchScrollView) {
        
        _searchpage = 0;
        
        searchScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleHeight + 60, self.frame.size.width, self.frame.size.height - self.titleHeight - 60)];
        [searchScrollView setBackgroundColor:AbsoluteWhite];
        [searchScrollView setShowsVerticalScrollIndicator:NO];
        [searchScrollView setDelegate:self];
        [self addSubview:searchScrollView];
        
    }
}

- (void)removeSearchList {
    [searchScrollView removeFromSuperview];
    searchScrollView  =  nil;
}

- (void)didSearch {
    _searchpage = 0;
    
    [[searchScrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [searchScrollView setContentSize:CGSizeMake(searchScrollView.frame.size.width, searchScrollView.frame.size.height)];
    
    if (_shopSearchArray.count != 0) {
        UIImageView *bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, searchScrollView.frame.size.width, 1.5f)];
        [bottomLine setImage:[UIImage imageNamed:@"ShopListLine"]];
        [searchScrollView addSubview:bottomLine];
    }
    
    [self addSearchButton];
}

- (void)addSearchButton {
    if (_shopSearchArray.count == 0) return;
    
    if (_searchpage * 10 + 10 < _shopSearchArray.count) {
        for (int i = 0; i < 10; i++) {
            ShopEntity *ety = (ShopEntity *)[_shopSearchArray objectAtIndex:i + _searchpage * 10];
            [searchScrollView addSubview:[self createListButtonWithFrame:CGRectMake(0, i * 105 + _searchpage * 1050, searchScrollView.frame.size.width, 105) andShopEntity:ety andTag:i + _searchpage * 10]];
        }
        
        _searchpage += 1;
        [searchScrollView setContentSize:CGSizeMake(searchScrollView.frame.size.width, _searchpage * 1050)];
    } else if (_searchpage * 10 < _shopSearchArray.count) {
        for (int i = _searchpage * 10; i < _shopSearchArray.count; i++) {
            ShopEntity *ety = (ShopEntity *)[_shopSearchArray objectAtIndex:i];
            [searchScrollView addSubview:[self createListButtonWithFrame:CGRectMake(0, i * 105, searchScrollView.frame.size.width, 105) andShopEntity:ety andTag:i]];
        }
        
        _searchpage += 1;
        [searchScrollView setContentSize:CGSizeMake(searchScrollView.frame.size.width, _shopSearchArray.count * 105 + 380)];
    } else {
        return;
    }
}

- (UIImage *)getCategoryImageWithCategory:(int)category {
    switch (category) {
        case 21:
            return [UIImage imageNamed:@"Famous_Icon"];
            break;
        case 22:
            return [UIImage imageNamed:@"Clothes_Icon"];
            break;
        case 23:
            return [UIImage imageNamed:@"Casual_Icon"];
            break;
        case 24:
            return [UIImage imageNamed:@"Kid_Icon"];
            break;
        case 25:
            return [UIImage imageNamed:@"Underwear_Icon"];
            break;
        case 26:
            return [UIImage imageNamed:@"Shoes_Icon"];
            break;
        case 27:
            return [UIImage imageNamed:@"Sweater_Icon"];
            break;
        case 28:
            return [UIImage imageNamed:@"Bags_Icon"];
            break;
        case 29:
            return [UIImage imageNamed:@"Ornament_Icon"];
            break;
        case 30:
            return [UIImage imageNamed:@"Food_Icon"];
            break;
        default:
            return [UIImage imageNamed:@"Ornament_Icon"];
            break;
    }
}

#pragma mark - Button Events

- (void)tappedShopInfoButton:(UIButton *)sender {
    ShopEntity *ety;
    if ([[[sender superview] superview] isEqual:mainScrollView]) {
        ety = [_shopListArray objectAtIndex:sender.tag];
    } else {
        ety = [_shopSearchArray objectAtIndex:sender.tag];
    }
    [searchView hideKeyboard];
    if (_delegate && [_delegate respondsToSelector:@selector(collectionView:didTapShopButtonWithShopEntity:)]) {
        [_delegate collectionView:self didTapShopButtonWithShopEntity:ety];
    }
}

#pragma mark - ScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //[searchView hideKeyboard];
    if (_delegate && [_delegate respondsToSelector:@selector(collectionView:didStartDragScrollView:)]) {
        [_delegate collectionView:self didStartDragScrollView:scrollView ];
    }
    
    //瀑布流显示
    if ([scrollView isEqual:mainScrollView]) {
        if (mainScrollView.contentSize.height - mainScrollView.contentOffset.y < mainScrollView.frame.size.height * 2) {
            [self addListButton];
        }
    } else if ([scrollView isEqual:searchScrollView]) {
        if (searchScrollView.contentSize.height - searchScrollView.contentOffset.y < searchScrollView.frame.size.height ) {
            [self addSearchButton];
        }
    }
}

#pragma mark - Search Delegate

- (void)searchTextView:(SearchTextView *)searchTextView didChange:(NSString *)searchText
{
    if (_delegate && [_delegate respondsToSelector:@selector(collectionView:didSearch:)]) {
        [_delegate collectionView:self didSearch:searchText];
    }
}

- (void)searchTextView:(SearchTextView *)searchTextView didStartTexting:(NSString *)searchText {
    if (_delegate && [_delegate respondsToSelector:@selector(collectionView:didStartTexting:)]) {
        [_delegate collectionView:self didStartTexting:searchText];
    }
}

- (void)searchTextView:(SearchTextView *)searchTextView didEndTexting:(NSString *)searchText {
    if (_delegate && [_delegate respondsToSelector:@selector(collectionView:didEndTexting:)]) {
        [_delegate collectionView:self didEndTexting:searchText];
    }
}

#pragma mark - DDL Delegate

- (void)dropDownListView:(DropDownListView *)dropDownListView didTapOption:(SortType)option {
    [searchView hideKeyboard];
    if (_delegate && [_delegate respondsToSelector:@selector(collectionView:didTapDropDownListOption:)]) {
        [_delegate collectionView:self didTapDropDownListOption:option];
    }
}

@end
