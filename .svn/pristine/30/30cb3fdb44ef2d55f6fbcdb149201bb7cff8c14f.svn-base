//
//  ItemViewController.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/10.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ItemViewController.h"

#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "pinyin.h"

@interface ItemViewController ()

@end

@implementation ItemViewController

- (void)initFirstViewWithParameter:(NSDictionary *)parameter
{
    itemListView = [[ItemListView alloc] initWithFrame:self.view.bounds];
    itemListView.delegate = self;
    [self.view addSubview:itemListView];
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
        originArray = [ArticleCoreDataHelper getItemList];
        itemListView.itemListArray = originArray;
    }];
    
    [operation setCompletionBlock:^{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [itemListView resetListScrollView];
        }];
    }];
    if ([SingleCase singleCase].coredataOperationQueue.operations.count > 0) {
        [operation addDependency:[[SingleCase singleCase].coredataOperationQueue.operations lastObject]];
    }
    
    [[SingleCase singleCase].coredataOperationQueue addOperation:operation];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldRecordLog" object:@"Product List"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBasicInfo) name:@"updateInfo" object:nil];
}

- (void)rebuildShopList {
    //    NSMutableArray *tempArray = originArray;
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
        
        switch (currentType) {
            case SortTypeCHNameAsc:
            {
                itemListView.itemListArray = [originArray sortedArrayUsingComparator:^NSComparisonResult(ItemEntity *obj1, ItemEntity *obj2) {
                    // 排序
                    NSComparisonResult result = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([obj1.shopEntity.chName characterAtIndex:0])] compare:[NSString stringWithFormat:@"%c",pinyinFirstLetter([obj2.shopEntity.chName characterAtIndex:0])]];
                    if(NSOrderedSame==result){
                        result=[obj1.shopEntity.chName compare:obj2.shopEntity.chName options:NSCaseInsensitiveSearch];
                    }
                    return result;
                }];
                //shopListView.shopListArray = originArray;
                break;
            }
            case SortTypeENNameAsc:
            {
                itemListView.itemListArray = [originArray sortedArrayUsingComparator:^NSComparisonResult(ItemEntity *obj1, ItemEntity *obj2) {
                    // 先按照姓排序
                    NSComparisonResult result = [obj1.shopEntity.enName compare:obj2.shopEntity.enName];
                    return result;
                }];
                break;
            }
            case SortTypeDiscountAsc:
            {
                itemListView.itemListArray = [originArray sortedArrayUsingComparator:^NSComparisonResult(ItemEntity *obj1, ItemEntity *obj2) {
                    // 先按照姓排序
                    NSComparisonResult result = [obj1.sale compare:obj2.sale];
                    return result;
                }];
                break;
            }
            default:
                itemListView.itemListArray = originArray;
                break;
        }
        if (currentArea.length > 0) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"location = %@",currentArea];
            itemListView.itemListArray = [itemListView.itemListArray filteredArrayUsingPredicate: predicate];
        }
        if (currentCategory.length > 0) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category = %@",currentCategory];
            itemListView.itemListArray = [itemListView.itemListArray filteredArrayUsingPredicate: predicate];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [itemListView resetListScrollView];
        });
    }];
    
    [[SingleCase singleCase].coredataOperationQueue addOperation:operation];
}

- (void)addSearchList {
    [itemListView addSearchList];
}

- (void)removeSearchList {
    if (currentString.length == 0) {
        [itemListView removeSearchList];
    }
}

- (void)rebuildSearchList {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (currentString && currentString.length > 0) {
            if (![ChineseInclude isIncludeChineseInString:currentString]) {
                for (ItemEntity *ety in originArray) {
                    if ([ChineseInclude isIncludeChineseInString:ety.title]) {
                        NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:ety.title];
                        NSRange titleResult=[tempPinYinStr rangeOfString:currentString options:NSCaseInsensitiveSearch];
                        if (titleResult.length>0) {
                            [tempArray addObject:ety];
                        } else {
                            NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:ety.title];
                            NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:currentString options:NSCaseInsensitiveSearch];
                            if (titleHeadResult.length>0) {
                                [tempArray addObject:ety];
                            }
                        }
                    }
                    else {
                        NSRange titleResult=[ety.title rangeOfString:currentString options:NSCaseInsensitiveSearch];
                        if (titleResult.length>0) {
                            [tempArray addObject:ety];
                        }
                    }
                }
            } else if ([ChineseInclude isIncludeChineseInString:currentString]) {
                for (ItemEntity *ety in originArray) {
                    NSRange titleResult=[ety.title rangeOfString:currentString options:NSCaseInsensitiveSearch];
                    if (titleResult.length>0) {
                        [tempArray addObject:ety];
                    }
                }
            }
        } else {
            //[tempArray addObjectsFromArray:originArray];
        }
        
        itemListView.itemSearchArray = tempArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [itemListView didSearch];
        });
    });
}

#pragma mark - Notification

- (void)updateBasicInfo {
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
        originArray = [ArticleCoreDataHelper getItemList];
        itemListView.itemListArray = originArray;
        
        switch (currentType) {
            case SortTypeCHNameAsc:
            {
                itemListView.itemListArray = [originArray sortedArrayUsingComparator:^NSComparisonResult(ItemEntity *obj1, ItemEntity *obj2) {
                    // 排序
                    NSComparisonResult result = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([obj1.shopEntity.chName characterAtIndex:0])] compare:[NSString stringWithFormat:@"%c",pinyinFirstLetter([obj2.shopEntity.chName characterAtIndex:0])]];
                    if(NSOrderedSame==result){
                        result=[obj1.shopEntity.chName compare:obj2.shopEntity.chName options:NSCaseInsensitiveSearch];
                    }
                    return result;
                }];
                //shopListView.shopListArray = originArray;
                break;
            }
            case SortTypeENNameAsc:
            {
                itemListView.itemListArray = [originArray sortedArrayUsingComparator:^NSComparisonResult(ItemEntity *obj1, ItemEntity *obj2) {
                    NSComparisonResult result = [obj1.shopEntity.enName compare:obj2.shopEntity.enName];
                    return result;
                }];
                break;
            }
            case SortTypeDiscountAsc:
            {
                itemListView.itemListArray = [originArray sortedArrayUsingComparator:^NSComparisonResult(ItemEntity *obj1, ItemEntity *obj2) {
                    NSComparisonResult result = [obj1.sale compare:obj2.sale];
                    return result;
                }];
                break;
            }
            case SortTypeDiscountRateAsc:
            {
                itemListView.itemListArray = [originArray sortedArrayUsingComparator:^NSComparisonResult(ItemEntity *obj1, ItemEntity *obj2) {
                    NSComparisonResult result = [obj1.rate compare:obj2.rate];
                    return result;
                }];
                break;
            }
            default:
                itemListView.itemListArray = originArray;
                break;
        }
        if (currentArea.length > 0) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"location = %@",currentArea];
            itemListView.itemListArray = [itemListView.itemListArray filteredArrayUsingPredicate: predicate];
        }
        if (currentCategory.length > 0) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category = %@",currentCategory];
            itemListView.itemListArray = [itemListView.itemListArray filteredArrayUsingPredicate: predicate];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [itemListView refreshSelf];
        });
    }];
    
    [[SingleCase singleCase].coredataOperationQueue addOperation:operation];
}

#pragma mark - Shop List View Delegate

- (void)itemListView:(ItemListView *)itemListView didTapItemButtonWithItemEntity:(ItemEntity *)itemEntity {
    NSDictionary *parameter = [NSDictionary dictionaryWithObjectsAndKeys:itemEntity, @"entity", nil];
    [self pushViewControllerWithViewControllerType:ViewControllerTypeItemInfo andParameter:parameter];
}

- (void)itemListView:(ItemListView *)itemListView didTapCategoryButtonWithCategory:(NSString *)category {
    [self wheelViewShouldHide];
    currentCategory = category;
    [self rebuildShopList];
}

- (void)itemListView:(ItemListView *)itemListView didStartDragScrollView:(UIScrollView *)scrollView {
    [self wheelViewShouldHide];
}

- (void)itemListView:(ItemListView *)itemListView didTapDropDownListOption:(SortType)option {
    currentType = option;
    [self rebuildShopList];
}

- (void)itemListView:(ItemListView *)itemListView didSearch:(NSString *)string {
    currentString = string;
    [self rebuildSearchList];
}

- (void)itemListView:(ItemListView *)itemListView didStartTexting:(NSString *)string {
    [self addSearchList];
}

- (void)itemListView:(ItemListView *)itemListView didEndTexting:(NSString *)string {
    [self removeSearchList];
}

- (void)itemListViewDidRefresh {
    MemberAPITool *mat = [[MemberAPITool alloc] init];
    NSString *dateTime = [mat getLastUpdateDate];
    BasicInfoAPITool *bat = [[BasicInfoAPITool alloc] init];
    [bat updateBasicInfoByDate:dateTime];
}

@end
