//
//  EventViewController.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/2.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "EventViewController.h"
#import "pinyin.h"

@interface EventViewController ()

@end

@implementation EventViewController

- (void)initFirstViewWithParameter:(NSDictionary *)parameter
{
    switch (_currentPage) {
        case 1:
        {
            if (!eventMallView) {
                eventMallView = [[EventMallView alloc] initWithFrame:self.view.bounds];
            }
            [eventMallView setDelegate:self];
            [self.view addSubview:eventMallView];
            
            self.currentView = eventMallView;
            [eventMallView showLoadingView];
            
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
                eventMallView.eventListArray = [[ArticleCoreDataHelper getEventMallList] sortedArrayUsingComparator:^NSComparisonResult(EventEntity *obj1, EventEntity *obj2) {
                    // 排序
                    NSComparisonResult result = [obj2.endTime compare:obj1.endTime];
                    return result;
                }];
            }];
            
            [operation setCompletionBlock:^{
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [eventMallView createEventListWithEventEntityArray];
                    [eventMallView hideLoadingView];
                }];
            }];
            if ([SingleCase singleCase].coredataOperationQueue.operations.count > 0) {
                [operation addDependency:[[SingleCase singleCase].coredataOperationQueue.operations lastObject]];
            }
            
            [[SingleCase singleCase].coredataOperationQueue addOperation:operation];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldRecordLog" object:@"Event Mall List"];
            
            break;
        }
        case 2:
        {
            if (!eventShopView) {
                eventShopView = [[EventShopView alloc] initWithFrame:self.view.bounds];
            }
            [eventShopView setDelegate:self];
            [self.view addSubview:eventShopView];
            
            self.currentView = eventShopView;
            [eventShopView showLoadingView];
            
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
                originShopEventArray = [ArticleCoreDataHelper getEventShopList];
                originShopEventArray = [originShopEventArray sortedArrayUsingComparator:^NSComparisonResult(EventEntity *obj1, EventEntity *obj2) {
                    // 排序
                    NSComparisonResult result = [obj1.endTime compare:obj2.endTime];
                    return result;
                }];
                
                eventShopView.eventListArray = originShopEventArray;
            }];
            [operation setCompletionBlock:^{
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [eventShopView createEventListWithEventEntityArray];
                    [eventShopView hideLoadingView];
                }];
            }];
            if ([SingleCase singleCase].coredataOperationQueue.operations.count > 0) {
                [operation addDependency:[[SingleCase singleCase].coredataOperationQueue.operations lastObject]];
            }
            
            [[SingleCase singleCase].coredataOperationQueue addOperation:operation];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldRecordLog" object:@"Event Brand List"];
            
            break;
        }
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBasicInfo) name:@"updateInfo" object:nil];
}

#pragma mark - Sort Operation 

- (void)sortEventShopViewWithSortOption:(SortType)option {
    switch (option) {
        case SortTypeCHNameAsc:
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                originShopEventArray = [originShopEventArray sortedArrayUsingComparator:^NSComparisonResult(EventEntity *obj1, EventEntity *obj2) {
                    // 排序
                    NSComparisonResult result = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([obj1.shopEntity.chName characterAtIndex:0])] compare:[NSString stringWithFormat:@"%c",pinyinFirstLetter([obj2.shopEntity.chName characterAtIndex:0])]];
                    return result;
                }];
                
                eventShopView.eventListArray = originShopEventArray;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [eventShopView createEventListWithEventEntityArray];
                });
            });
            break;
        }
        case SortTypeENNameAsc:
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                originShopEventArray = [originShopEventArray sortedArrayUsingComparator:^NSComparisonResult(EventEntity *obj1, EventEntity *obj2) {
                    // 排序
                    NSComparisonResult result = [obj1.shopEntity.enName compare:obj2.shopEntity.enName];
                    return result;
                }];
                
                eventShopView.eventListArray = originShopEventArray;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [eventShopView createEventListWithEventEntityArray];
                });
            });
            break;
        }
        case SortTypeEndDateAsc:
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                originShopEventArray = [originShopEventArray sortedArrayUsingComparator:^NSComparisonResult(EventEntity *obj1, EventEntity *obj2) {
                    // 排序
                    NSComparisonResult result = [obj1.endTime compare:obj2.endTime];
                    return result;
                }];
                
                eventShopView.eventListArray = originShopEventArray;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [eventShopView createEventListWithEventEntityArray];
                });
            });
            break;
        }
        default:
            break;
    }
}

#pragma mark - Event Views Delegate

- (void)eventShopView:(EventShopView *)eventShopView didStartDragScrollView:(UIScrollView *)scrollView {
    [self wheelViewShouldHide];
}

- (void)eventShopView:(EventShopView *)eventShopView didTapEventButtonWithEventEntity:(EventEntity *)eventEntity {
    NSDictionary *parameter = [NSDictionary dictionaryWithObjectsAndKeys:eventEntity, @"entity", nil];
    [self pushViewControllerWithViewControllerType:ViewControllerTypeEventInfo andParameter:parameter];
}

- (void)eventShopView:(EventShopView *)eventShopView didTapDropDownListOption:(SortType)option {
    [self sortEventShopViewWithSortOption:option];
}

- (void)eventMallView:(EventMallView *)eventMallView didStartDragScrollView:(UIScrollView *)scrollView {
    [self wheelViewShouldHide];
}

- (void)eventMallView:(EventMallView *)eventMallView didTapEventButtonWithEventEntity:(EventEntity *)eventEntity {
    NSDictionary *parameter = [NSDictionary dictionaryWithObjectsAndKeys:eventEntity, @"entity", nil];
    [self pushViewControllerWithViewControllerType:ViewControllerTypeEventTheme andParameter:parameter];
}

- (void)eventShopViewDidRefresh {
    MemberAPITool *mat = [[MemberAPITool alloc] init];
    NSString *dateTime = [mat getLastUpdateDate];
    BasicInfoAPITool *bat = [[BasicInfoAPITool alloc] init];
    [bat updateBasicInfoByDate:dateTime];
}

- (void)eventMallViewDidRefresh {
    MemberAPITool *mat = [[MemberAPITool alloc] init];
    NSString *dateTime = [mat getLastUpdateDate];
    BasicInfoAPITool *bat = [[BasicInfoAPITool alloc] init];
    [bat updateBasicInfoByDate:dateTime];
}

#pragma mark - Notification

- (void)updateBasicInfo {
    if ([self.currentView isEqual:eventShopView]) {
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
            originShopEventArray = [ArticleCoreDataHelper getEventShopList];
            originShopEventArray = [originShopEventArray sortedArrayUsingComparator:^NSComparisonResult(EventEntity *obj1, EventEntity *obj2) {
                // 排序
                NSComparisonResult result = [obj1.endTime compare:obj2.endTime];
                return result;
            }];
            
            eventShopView.eventListArray = originShopEventArray;
        }];
        
        [operation setCompletionBlock:^{
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [eventShopView refreshSelf];
            }];
        }];
        
        [[SingleCase singleCase].coredataOperationQueue addOperation:operation];
    } else {
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
            eventMallView.eventListArray = [[ArticleCoreDataHelper getEventMallList] sortedArrayUsingComparator:^NSComparisonResult(EventEntity *obj1, EventEntity *obj2) {
                // 排序
                NSComparisonResult result = [obj2.endTime compare:obj1.endTime];
                return result;
            }];
        }];
        
        [operation setCompletionBlock:^{
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [eventMallView refreshSelf];
            }];
        }];
        
        [[SingleCase singleCase].coredataOperationQueue addOperation:operation];
    }
}

#pragma mark - Wheel View

- (void)wheelViewTappedButton2 {
    [self popToIndexViewController];
}

- (void)wheelViewTappedButton3 {
    if (!eventMallView) {
        eventMallView = [[EventMallView alloc] initWithFrame:self.view.bounds];
        eventMallView.eventListArray = [ArticleCoreDataHelper getEventMallList];
        [eventMallView setAlpha:0];
        [eventMallView setDelegate:self];
        [self.view addSubview:eventMallView];
        
        [eventMallView showLoadingView];
        
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
            eventMallView.eventListArray = [[ArticleCoreDataHelper getEventMallList] sortedArrayUsingComparator:^NSComparisonResult(EventEntity *obj1, EventEntity *obj2) {
                // 排序
                NSComparisonResult result = [obj2.endTime compare:obj1.endTime];
                return result;
            }];
        }];
        
        [operation setCompletionBlock:^{
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [eventMallView createEventListWithEventEntityArray];
                [eventMallView hideLoadingView];
            }];
        }];
        if ([SingleCase singleCase].coredataOperationQueue.operations.count > 0) {
            [operation addDependency:[[SingleCase singleCase].coredataOperationQueue.operations lastObject]];
        }
        
        [[SingleCase singleCase].coredataOperationQueue addOperation:operation];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldRecordLog" object:@"Event Mall List"];
    }
    
    self.nextView = eventMallView;
    [self showNextView];
}

- (void)wheelViewTappedButton4 {
    if (!eventShopView) {
        eventShopView = [[EventShopView alloc] initWithFrame:self.view.bounds];
        [eventShopView setAlpha:0];
        [eventShopView setDelegate:self];
        [self.view addSubview:eventShopView];
        
        [eventShopView showLoadingView];
        
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
            originShopEventArray = [ArticleCoreDataHelper getEventShopList];
            originShopEventArray = [originShopEventArray sortedArrayUsingComparator:^NSComparisonResult(EventEntity *obj1, EventEntity *obj2) {
                // 排序
                NSComparisonResult result = [obj1.endTime compare:obj2.endTime];
                return result;
            }];
            
            eventShopView.eventListArray = originShopEventArray;
        }];
        
        [operation setCompletionBlock:^{
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [eventShopView createEventListWithEventEntityArray];
                [eventShopView hideLoadingView];
            }];
        }];
        if ([SingleCase singleCase].coredataOperationQueue.operations.count > 0) {
            [operation addDependency:[[SingleCase singleCase].coredataOperationQueue.operations lastObject]];
        }
        
        [[SingleCase singleCase].coredataOperationQueue addOperation:operation];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldRecordLog" object:@"Event Brand List"];
    }
    
    self.nextView = eventShopView;
    [self showNextView];
}

@end
