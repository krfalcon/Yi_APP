//
//  CollectionView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/13.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"
#import "DropDownListView.h"
#import "SearchTextView.h"

#import "ShopEntity.h"

@protocol CollectionViewDelegate;

@interface CollectionView : TempletView<UIScrollViewDelegate, MDIncrementalImageViewDelegate, DropDownListViewDelegate, SearchTextViewDelegate>
{
    UIScrollView        *mainScrollView;
    UIScrollView        *searchScrollView;
    UIScrollView        *sideView;
    
    SearchTextView      *searchView;
}

@property (weak, nonatomic)   id<CollectionViewDelegate>  delegate;
@property (assign, nonatomic) int                         page;
@property (assign, nonatomic) int                         searchpage;
@property (retain, nonatomic) NSArray                     *shopListArray;
@property (retain, nonatomic) NSArray                     *shopSearchArray;
@property (retain, nonatomic) NSString                    *category;

- (void)resetListScrollView;
- (void)addListButton;

- (void)addSearchList;
- (void)removeSearchList;
- (void)didSearch;

@end

@protocol CollectionViewDelegate <NSObject>

- (void)collectionView:(CollectionView *)collectionView didTapShopButtonWithShopEntity:(ShopEntity *)shopEntity;
- (void)collectionView:(CollectionView *)collectionView didStartDragScrollView:(UIScrollView *)scrollView;
- (void)collectionView:(CollectionView *)collectionView didTapDropDownListOption:(SortType)option;
- (void)collectionView:(CollectionView *)collectionView didSearch:(NSString *)string;
- (void)collectionView:(CollectionView *)collectionView didStartTexting:(NSString *)string;
- (void)collectionView:(CollectionView *)collectionView didEndTexting:(NSString *)string;

@end
