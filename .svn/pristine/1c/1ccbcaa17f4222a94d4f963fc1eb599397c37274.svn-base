//
//  ShopViewController.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/17.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ShopViewController.h"

#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "pinyin.h"

@implementation ShopViewController

#pragma mark - InitView

- (void)initFirstViewWithParameter:(NSDictionary *)parameter
{
    if (!shopListView) {
        shopListView = [[ShopListView alloc] initWithFrame:self.view.bounds];
        [shopListView setDelegate:self];
        [self.view addSubview:shopListView];
        if (_category.length > 0) {
            shopListView.category = _category;
            [shopListView createCategoryList];
        }
    }
    
    //[shopListView showLoadingView];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldRecordLog" object:@"Brand List"];
    [self getShopList];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBasicInfo) name:@"updateInfo" object:nil];
}

#pragma mark - View Operation

- (void)getShopList {
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
        originArray = [ArticleCoreDataHelper getShopList];
        shopListView.shopListArray = originArray;
        if (_category.length > 0) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category CONTAINS %@", _category];
            shopListView.shopListArray = [shopListView.shopListArray filteredArrayUsingPredicate: predicate];
        }
    }];
                                   
    [operation setCompletionBlock:^(){
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [shopListView addListButton];
            [shopListView hideLoadingView];
        }];
    }];
    
    [self addOperationToCoredateOperationWithOperation:operation];
}

- (void)rebuildShopList {
//    NSMutableArray *tempArray = originArray;
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
        switch (currentType) {
            case SortTypeCHNameAsc:
            {
                shopListView.shopListArray = [originArray sortedArrayUsingComparator:^NSComparisonResult(ShopEntity *obj1, ShopEntity *obj2) {
                    // 排序
                    NSComparisonResult result = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([obj1.chName characterAtIndex:0])] compare:[NSString stringWithFormat:@"%c",pinyinFirstLetter([obj2.chName characterAtIndex:0])]];
                    if(NSOrderedSame==result){
                        result=[obj1.chName compare:obj2.chName options:NSCaseInsensitiveSearch];
                    }
                    return result;
                }];
                //shopListView.shopListArray = originArray;
                break;
            }
            case SortTypeENNameAsc:
            {
                shopListView.shopListArray = [originArray sortedArrayUsingComparator:^NSComparisonResult(ShopEntity *obj1, ShopEntity *obj2) {
                    // 先按照姓排序
                    NSComparisonResult result = [obj1.enName compare:obj2.enName];
                    return result;
                }];
                break;
            }
            case SortTypeLocation:
            {
                shopListView.shopListArray = [originArray sortedArrayUsingComparator:^NSComparisonResult(ShopEntity *obj1, ShopEntity *obj2) {
                    // 先按照姓排序
                    NSComparisonResult result = [obj1.locationArea compare:obj2.locationArea];
                    return result;
                }];
                break;
            }
            default:
                shopListView.shopListArray = originArray;
                break;
        }
        if (currentArea.length > 0) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"location = %@",currentArea];
            shopListView.shopListArray = [shopListView.shopListArray filteredArrayUsingPredicate: predicate];
        }
        if (currentCategory.length > 0) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category CONTAINS %@",currentCategory];
            shopListView.shopListArray = [shopListView.shopListArray filteredArrayUsingPredicate: predicate];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [shopListView resetListScrollView];
        });
    }];
    
    [[SingleCase singleCase].coredataOperationQueue addOperation:operation];
}

- (void)addSearchList {
    [shopListView addSearchList];
}

- (void)removeSearchList {
    if (currentString.length == 0) {
        [shopListView removeSearchList];
    }
}

- (void)rebuildSearchList {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (currentString && currentString.length > 0) {
            if (![ChineseInclude isIncludeChineseInString:currentString]) {
                for (ShopEntity *ety in originArray) {
                    if ([ChineseInclude isIncludeChineseInString:ety.chName]) {
                        NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:ety.chName];
                        NSRange titleResult=[tempPinYinStr rangeOfString:currentString options:NSCaseInsensitiveSearch];
                        if (titleResult.length > 0) {
                            [tempArray addObject:ety];
                        } else {
                            NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:ety.chName];
                            NSRange titleHeadResult = [tempPinYinHeadStr rangeOfString:currentString options:NSCaseInsensitiveSearch];
                            if (titleHeadResult.length > 0) {
                                [tempArray addObject:ety];
                            }
                        }
                    }
                    else {
                        NSRange titleResult = [ety.chName rangeOfString:currentString options:NSCaseInsensitiveSearch];
                        if (titleResult.length > 0) {
                            [tempArray addObject:ety];
                        }
                    }
                }
            } else if ([ChineseInclude isIncludeChineseInString:currentString]) {
                for (ShopEntity *ety in originArray) {
                    NSRange titleResult = [ety.chName rangeOfString:currentString options:NSCaseInsensitiveSearch];
                    if (titleResult.length > 0) {
                        [tempArray addObject:ety];
                    }
                }
            }
        } else {
            //[tempArray addObjectsFromArray:originArray];
        }
        
        shopListView.shopSearchArray = tempArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [shopListView didSearch];
        });
    });
}

#pragma mark - Notification

- (void)updateBasicInfo {
    //    NSMutableArray *tempArray = originArray;
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
        originArray = [ArticleCoreDataHelper getShopList];
        switch (currentType) {
            case SortTypeCHNameAsc:
            {
                shopListView.shopListArray = [originArray sortedArrayUsingComparator:^NSComparisonResult(ShopEntity *obj1, ShopEntity *obj2) {
                    // 排序
                    NSComparisonResult result = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([obj1.chName characterAtIndex:0])] compare:[NSString stringWithFormat:@"%c",pinyinFirstLetter([obj2.chName characterAtIndex:0])]];
                    if(NSOrderedSame==result){
                        result=[obj1.chName compare:obj2.chName options:NSCaseInsensitiveSearch];
                    }
                    return result;
                }];
                //shopListView.shopListArray = originArray;
                break;
            }
            case SortTypeENNameAsc:
            {
                shopListView.shopListArray = [originArray sortedArrayUsingComparator:^NSComparisonResult(ShopEntity *obj1, ShopEntity *obj2) {
                    // 先按照姓排序
                    NSComparisonResult result = [obj1.enName compare:obj2.enName];
                    return result;
                }];
                break;
            }
            case SortTypeLocation:
            {
                shopListView.shopListArray = [originArray sortedArrayUsingComparator:^NSComparisonResult(ShopEntity *obj1, ShopEntity *obj2) {
                    // 先按照姓排序
                    NSComparisonResult result = [obj1.locationArea compare:obj2.locationArea];
                    return result;
                }];
                break;
            }
            default:
                shopListView.shopListArray = originArray;
                break;
        }
        if (currentArea.length > 0) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"location = %@",currentArea];
            shopListView.shopListArray = [shopListView.shopListArray filteredArrayUsingPredicate: predicate];
        }
        if (currentCategory.length > 0) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category CONTAINS %@",currentCategory];
            shopListView.shopListArray = [shopListView.shopListArray filteredArrayUsingPredicate: predicate];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [shopListView refreshSelf];
        });
    }];
    
    [[SingleCase singleCase].coredataOperationQueue addOperation:operation];
}

#pragma mark - Shop List View Delegate

- (void)shopListView:(ShopListView *)shopListView didTapShopButtonWithShopEntity:(ShopEntity *)shopEntity {
    NSDictionary *parameter = [NSDictionary dictionaryWithObjectsAndKeys:shopEntity, @"entity", nil];
    [self pushViewControllerWithViewControllerType:ViewControllerTypeShopInfo andParameter:parameter];
}

- (void)shopListViewDidTapCollectButtonWithShopEntity:(ShopEntity *)shopEntity andTag:(NSInteger)tag {
    MemberAPITool *memberAPI = [[MemberAPITool alloc] init];
    if (![memberAPI getLoginStatus]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"请先登录！"];
        return;
    }
    
    shopEntity = [memberAPI setLocalFavoriteWithBrandID:shopEntity];
    if (shopEntity) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"收藏成功！"];
        [shopListView setFavoriteSucceedWithShopEntity:shopEntity andTag:tag];
    }
}

- (void)shopListView:(ShopListView *)shopListView didTapCategoryButtonWithCategory:(NSString *)category {
    [self wheelViewShouldHide];
    currentCategory = category;
    [self rebuildShopList];
}

- (void)shopListView:(ShopListView *)shopListView didStartDragScrollView:(UIScrollView *)scrollView {
    [self wheelViewShouldHide];
}

- (void)shopListView:(ShopListView *)shopListView didTapDropDownListOption:(SortType)option {
    currentType = option;
    [self rebuildShopList];
}

- (void)shopListView:(ShopListView *)shopListView didSearch:(NSString *)string {
    currentString = string;
    [self rebuildSearchList];
}

- (void)shopListView:(ShopListView *)shopListView didStartTexting:(NSString *)string {
    [self addSearchList];
}

- (void)shopListView:(ShopListView *)shopListView didEndTexting:(NSString *)string {
    [self removeSearchList];
}

- (void)shopListViewDidRefresh {
    MemberAPITool *mat = [[MemberAPITool alloc] init];
    NSString *dateTime = [mat getLastUpdateDate];
    BasicInfoAPITool *bat = [[BasicInfoAPITool alloc] init];
    [bat updateBasicInfoByDate:dateTime];
}

#pragma mark - Wheel View Button

- (void)wheelViewTappedButton1 {
    [self popToIndexViewController];
}

- (void)wheelViewTappedButton2 {
    currentArea = @"";
    if (onRestaurant) {
        onRestaurant = NO;
        currentCategory = @"";
    }
    [shopListView showCategoryList:YES];
    [self rebuildShopList];
}

- (void)wheelViewTappedButton3 {
    currentArea = @"18";
    if (onRestaurant) {
        onRestaurant = NO;
        currentCategory = @"";
    }
    [shopListView showCategoryList:YES];
    [self rebuildShopList];
}

- (void)wheelViewTappedButton4 {
    currentArea = @"19";
    if (onRestaurant) {
        onRestaurant = NO;
        currentCategory = @"";
    }
    [shopListView showCategoryList:YES];
    [self rebuildShopList];
}

- (void)wheelViewTappedButton5 {
    currentArea = @"";
    currentCategory = @"17";
    onRestaurant = YES;
    [shopListView showCategoryList:NO];
    [self rebuildShopList];
}

@end
