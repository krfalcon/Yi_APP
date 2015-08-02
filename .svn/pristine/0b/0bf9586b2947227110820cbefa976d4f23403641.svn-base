//
//  CollectionViewController.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/12.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "CollectionViewController.h"

#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "pinyin.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

#pragma mark - InitView

- (void)initFirstViewWithParameter:(NSDictionary *)parameter
{
    if (!collectionView) {
        collectionView = [[CollectionView alloc] initWithFrame:self.view.bounds];
        [collectionView setDelegate:self];
        [self.view addSubview:collectionView];
    }
    [collectionView showLoadingView];
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
        originArray = [ArticleCoreDataHelper getFavoriteShopList];
        collectionView.shopListArray = originArray;
    }];
    
    [operation setCompletionBlock:^(){
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [collectionView addListButton];
            [collectionView hideLoadingView];
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
                collectionView.shopListArray = [originArray sortedArrayUsingComparator:^NSComparisonResult(ShopEntity *obj1, ShopEntity *obj2) {
                    // 排序
                    NSComparisonResult result = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([obj1.chName characterAtIndex:0])] compare:[NSString stringWithFormat:@"%c",pinyinFirstLetter([obj2.chName characterAtIndex:0])]];
                    if(NSOrderedSame==result){
                        result=[obj1.chName compare:obj2.chName options:NSCaseInsensitiveSearch];
                    }
                    return result;
                }];
                //collectionView.shopListArray = originArray;
                break;
            }
            case SortTypeENNameAsc:
            {
                collectionView.shopListArray = [originArray sortedArrayUsingComparator:^NSComparisonResult(ShopEntity *obj1, ShopEntity *obj2) {
                    // 先按照姓排序
                    NSComparisonResult result = [obj1.enName compare:obj2.enName];
                    return result;
                }];
                break;
            }
            case SortTypeLocation:
            {
                collectionView.shopListArray = [originArray sortedArrayUsingComparator:^NSComparisonResult(ShopEntity *obj1, ShopEntity *obj2) {
                    // 先按照姓排序
                    NSComparisonResult result = [obj1.locationArea compare:obj2.locationArea];
                    return result;
                }];
                break;
            }
            default:
                collectionView.shopListArray = originArray;
                break;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [collectionView resetListScrollView];
        });
    }];
    
    [[SingleCase singleCase].coredataOperationQueue addOperation:operation];
}

- (void)addSearchList {
    [collectionView addSearchList];
}

- (void)removeSearchList {
    if (currentString.length == 0) {
        [collectionView removeSearchList];
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
                        if (titleResult.length>0) {
                            [tempArray addObject:ety];
                        } else {
                            NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:ety.chName];
                            NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:currentString options:NSCaseInsensitiveSearch];
                            if (titleHeadResult.length>0) {
                                [tempArray addObject:ety];
                            }
                        }
                    }
                    else {
                        NSRange titleResult=[ety.chName rangeOfString:currentString options:NSCaseInsensitiveSearch];
                        if (titleResult.length>0) {
                            [tempArray addObject:ety];
                        }
                    }
                }
            } else if ([ChineseInclude isIncludeChineseInString:currentString]) {
                for (ShopEntity *ety in originArray) {
                    NSRange titleResult=[ety.chName rangeOfString:currentString options:NSCaseInsensitiveSearch];
                    if (titleResult.length>0) {
                        [tempArray addObject:ety];
                    }
                }
            }
        } else {
            //[tempArray addObjectsFromArray:originArray];
        }
        
        collectionView.shopSearchArray = tempArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [collectionView didSearch];
        });
    });
}

#pragma mark - Shop List View Delegate

- (void)collectionView:(CollectionView *)collectionView didTapShopButtonWithShopEntity:(ShopEntity *)shopEntity {
    NSDictionary *parameter = [NSDictionary dictionaryWithObjectsAndKeys:shopEntity, @"entity", nil];
    [self pushViewControllerWithViewControllerType:ViewControllerTypeShopInfo andParameter:parameter];
}
- (void)collectionView:(CollectionView *)collectionView didStartDragScrollView:(UIScrollView *)scrollView {
    [self wheelViewShouldHide];
}

- (void)collectionView:(CollectionView *)collectionView didTapDropDownListOption:(SortType)option {
    currentType = option;
    [self rebuildShopList];
}

- (void)collectionView:(CollectionView *)collectionView didSearch:(NSString *)string {
    currentString = string;
    [self rebuildSearchList];
}

- (void)collectionView:(CollectionView *)collectionView didStartTexting:(NSString *)string {
    [self addSearchList];
}

- (void)collectionView:(CollectionView *)collectionView didEndTexting:(NSString *)string {
    [self removeSearchList];
}

@end
