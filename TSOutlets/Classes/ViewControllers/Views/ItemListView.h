//
//  ItemListView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/10.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"

#import "DropDownListView.h"
#import "SearchTextView.h"
#import "ItemEntity.h"

@protocol ItemListViewDelegate;

@interface ItemListView : TempletView<UIScrollViewDelegate, DropDownListViewDelegate, SearchTextViewDelegate>
{
    UIScrollView        *mainScrollView;
    UIScrollView        *searchScrollView;
    
    SearchTextView      *searchView;
}

@property (weak, nonatomic)   id<ItemListViewDelegate>      delegate;
@property (assign, nonatomic) int                           page;
@property (assign, nonatomic) int                           searchpage;
@property (retain, nonatomic) NSArray*                      itemListArray;
@property (retain, nonatomic) NSArray*                      itemSearchArray;

- (void)refreshSelf;

- (void)resetListScrollView;
- (void)addListButton;

- (void)addSearchList;
- (void)removeSearchList;
- (void)didSearch;

@end

@protocol ItemListViewDelegate <NSObject>

- (void)itemListView:(ItemListView *)itemListView didTapItemButtonWithItemEntity:(ItemEntity *)itemEntity;
- (void)itemListView:(ItemListView *)itemListView didStartDragScrollView:(UIScrollView *)scrollView;
- (void)itemListView:(ItemListView *)itemListView didTapDropDownListOption:(SortType)option;
- (void)itemListView:(ItemListView *)itemListView didSearch:(NSString *)string;
- (void)itemListView:(ItemListView *)itemListView didStartTexting:(NSString *)string;
- (void)itemListView:(ItemListView *)itemListView didEndTexting:(NSString *)string;
- (void)itemListView:(ItemListView *)itemListView didTapCategoryButtonWithCategory:(NSString *)category;
- (void)itemListViewDidRefresh;

@end