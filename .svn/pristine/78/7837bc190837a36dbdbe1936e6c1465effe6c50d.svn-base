//
//  ShopListView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/18.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"
#import "DropDownListView.h"
#import "SearchTextView.h"

#import "ShopEntity.h"

@protocol ShopListViewDelegate;

@interface ShopListView : TempletView<UIScrollViewDelegate, MDIncrementalImageViewDelegate, DropDownListViewDelegate, SearchTextViewDelegate>
{
    UIScrollView        *mainScrollView;
    UIScrollView        *searchScrollView;
    UIScrollView        *sideView;
    
    SearchTextView      *searchView;
}
@property (weak, nonatomic)   id<ShopListViewDelegate>    delegate;
@property (assign, nonatomic) int                         page;
@property (assign, nonatomic) int                         searchpage;
@property (retain, nonatomic) NSArray                     *shopListArray;
@property (retain, nonatomic) NSArray                     *shopSearchArray;
@property (retain, nonatomic) NSString                    *category;

- (void)refreshSelf;

- (void)resetListScrollView;
- (void)addListButton;

- (void)addSearchList;
- (void)removeSearchList;
- (void)didSearch;

- (void)createCategoryList;
- (void)showCategoryList:(BOOL)show;

- (void)setFavoriteSucceedWithShopEntity:(ShopEntity *)shopEntity andTag:(NSInteger)tag;

@end

@protocol ShopListViewDelegate <NSObject>

- (void)shopListView:(ShopListView *)shopListView didTapShopButtonWithShopEntity:(ShopEntity *)shopEntity;
- (void)shopListViewDidTapCollectButtonWithShopEntity:(ShopEntity *)shopEntity andTag:(NSInteger)tag;
- (void)shopListViewDidRefresh;
- (void)shopListView:(ShopListView *)shopListView didStartDragScrollView:(UIScrollView *)scrollView;
- (void)shopListView:(ShopListView *)shopListView didTapDropDownListOption:(SortType)option;
- (void)shopListView:(ShopListView *)shopListView didSearch:(NSString *)string;
- (void)shopListView:(ShopListView *)shopListView didStartTexting:(NSString *)string;
- (void)shopListView:(ShopListView *)shopListView didEndTexting:(NSString *)string;
- (void)shopListView:(ShopListView *)shopListView didTapCategoryButtonWithCategory:(NSString *)category;

@end