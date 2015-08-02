//
//  VideoViewController.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/9.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "VideoViewController.h"

#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "pinyin.h"

@interface VideoViewController ()

@end

@implementation VideoViewController

- (void)initFirstViewWithParameter:(NSDictionary *)parameter
{
    if (!videoMallView) {
        videoMallView = [[VideoMallView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:videoMallView];
    }
    [videoMallView setDelegate:self];
    
//    [ArticleCoreDataHelper getVideoShopList];
//    [ArticleCoreDataHelper getVideoMallList];
    
    [videoMallView showLoadingView];
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
        videoMallView.videoListArray = [[ArticleCoreDataHelper getVideoMallList] sortedArrayUsingComparator:^NSComparisonResult(VideoEntity *obj1, VideoEntity *obj2) {
            // 排序
            NSComparisonResult result = [obj2.time compare:obj1.time];
            return result;
        }];
    }];
    
    [operation setCompletionBlock:^{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [videoMallView createVideoListWithVideoEntityArray];
            [videoMallView hideLoadingView];
        }];
    }];
    if ([SingleCase singleCase].coredataOperationQueue.operations.count > 0) {
        [operation addDependency:[[SingleCase singleCase].coredataOperationQueue.operations lastObject]];
    }
    
    [[SingleCase singleCase].coredataOperationQueue addOperation:operation];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldRecordLog" object:@"Video List"];
    
    self.currentView = videoMallView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBasicInfo) name:@"updateInfo" object:nil];
}

#pragma mark - Sort Operation

- (void)sortEventShopViewWithSortOption:(SortType)option {
    switch (option) {
        case SortTypeCHNameAsc:
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                originShopVideoArray = [originShopVideoArray sortedArrayUsingComparator:^NSComparisonResult(VideoEntity *obj1, VideoEntity *obj2) {
                    // 排序
                    NSComparisonResult result = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([obj1.title characterAtIndex:0])] compare:[NSString stringWithFormat:@"%c",pinyinFirstLetter([obj2.title characterAtIndex:0])]];
                    return result;
                }];
                
                videoBrandView.videoListArray = originShopVideoArray;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [videoBrandView createVideoListWithVideoEntityArray];
                });
            });
            break;
        }
        case SortTypeENNameAsc:
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                originShopVideoArray = [originShopVideoArray sortedArrayUsingComparator:^NSComparisonResult(VideoEntity *obj1, VideoEntity *obj2) {
                    // 排序
                    NSComparisonResult result = [obj1.shopEntity.enName compare:obj2.shopEntity.enName];
                    return result;
                }];
                
                videoBrandView.videoListArray = originShopVideoArray;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [videoBrandView createVideoListWithVideoEntityArray];
                });
            });
            break;
        }
        case SortTypeUploadDateDesc:
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                originShopVideoArray = [originShopVideoArray sortedArrayUsingComparator:^NSComparisonResult(VideoEntity *obj1, VideoEntity *obj2) {
                    // 排序
                    NSComparisonResult result = [obj2.time compare:obj1.time];
                    return result;
                }];
                
                videoBrandView.videoListArray = originShopVideoArray;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [videoBrandView createVideoListWithVideoEntityArray];
                });
            });
            break;
        }
        default:
            break;
    }
}

/*- (void)addSearchList {
    [videoShopView addSearchList];
}

- (void)removeSearchList {
    if (currentString.length == 0) {
        [videoShopView removeSearchList];
    }
}

- (void)rebuildSearchList {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (currentString && currentString.length > 0) {
            if (![ChineseInclude isIncludeChineseInString:currentString]) {
                for (VideoEntity *ety in originShopVideoArray) {
                    if ([ChineseInclude isIncludeChineseInString:ety.shopEntity.chName]) {
                        NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:ety.shopEntity.chName];
                        NSRange titleResult=[tempPinYinStr rangeOfString:currentString options:NSCaseInsensitiveSearch];
                        if (titleResult.length>0) {
                            [tempArray addObject:ety];
                        } else {
                            NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:ety.shopEntity.chName];
                            NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:currentString options:NSCaseInsensitiveSearch];
                            if (titleHeadResult.length>0) {
                                [tempArray addObject:ety];
                            }
                        }
                    }
                    else {
                        NSRange titleResult=[ety.shopEntity.chName rangeOfString:currentString options:NSCaseInsensitiveSearch];
                        if (titleResult.length>0) {
                            [tempArray addObject:ety];
                        }
                    }
                }
            } else if ([ChineseInclude isIncludeChineseInString:currentString]) {
                for (VideoEntity *ety in originShopVideoArray) {
                    NSRange titleResult=[ety.shopEntity.chName rangeOfString:currentString options:NSCaseInsensitiveSearch];
                    if (titleResult.length>0) {
                        [tempArray addObject:ety];
                    }
                }
            }
        } else {
            //[tempArray addObjectsFromArray:originArray];
        }
        
        videoShopView.videoSearchArray = tempArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [videoShopView didSearch];
        });
    });
}
*/
#pragma mark - Notification

- (void)updateBasicInfo {
    if ([self.currentView isEqual:videoBrandView]) {
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
            originShopVideoArray = [ArticleCoreDataHelper getVideoShopList];
            
            videoBrandView.videoListArray = originShopVideoArray;
        }];
        
        [operation setCompletionBlock:^{
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [videoBrandView refreshSelf];
            }];
        }];
        if ([SingleCase singleCase].coredataOperationQueue.operations.count > 0) {
            [operation addDependency:[[SingleCase singleCase].coredataOperationQueue.operations lastObject]];
        }
        
        [[SingleCase singleCase].coredataOperationQueue addOperation:operation];
    } else {
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
            videoMallView.videoListArray = [[ArticleCoreDataHelper getVideoMallList] sortedArrayUsingComparator:^NSComparisonResult(VideoEntity *obj1, VideoEntity *obj2) {
                // 排序
                NSComparisonResult result = [obj2.time compare:obj1.time];
                return result;
            }];
        }];
        
        [operation setCompletionBlock:^{
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [videoMallView refreshSelf];
            }];
        }];
        
        if ([SingleCase singleCase].coredataOperationQueue.operations.count > 0) {
            [operation addDependency:[[SingleCase singleCase].coredataOperationQueue.operations lastObject]];
        }
        
        [[SingleCase singleCase].coredataOperationQueue addOperation:operation];
    }
}

#pragma mark - Event Views Delegate

- (void)videoBrandView:(VideoBrandView *)videoBrandView didStartDragScrollView:(UIScrollView *)scrollView {
    [self wheelViewShouldHide];
}
/*
- (void)videoBrandView:(VideoShopView *)videoBrandView didTapDropDownListOption:(SortType)option {
    [self sortEventShopViewWithSortOption:option];
}

- (void)videoBrandView:(VideoShopView *)videoShopView didSearch:(NSString *)string {
    currentString = string;
    [self rebuildSearchList];
}

- (void)videoShopView:(VideoShopView *)videoShopView didStartTexting:(NSString *)string {
    [self addSearchList];
}

- (void)videoShopView:(VideoShopView *)videoShopView didEndTexting:(NSString *)string {
    [self removeSearchList];
}
*/
- (void)videoBrandView:(VideoBrandView *)videoBrandView didPlayerVideo:(NSString *)url {
    [self didTappedVideoWithVideoUrl:url];
}


- (void)videoMallView:(VideoMallView *)videoMallView didStartDragScrollView:(UIScrollView *)scrollView {
    [self wheelViewShouldHide];
}

- (void)videoMallView:(VideoMallView *)videoMallView didPlayerVideo:(NSString *)url {
    [self didTappedVideoWithVideoUrl:url];
}

- (void)videoBrandViewDidRefresh {
    MemberAPITool *mat = [[MemberAPITool alloc] init];
    NSString *dateTime = [mat getLastUpdateDate];
    BasicInfoAPITool *bat = [[BasicInfoAPITool alloc] init];
    [bat updateBasicInfoByDate:dateTime];
}

- (void)videoMallViewDidRefresh {
    MemberAPITool *mat = [[MemberAPITool alloc] init];
    NSString *dateTime = [mat getLastUpdateDate];
    BasicInfoAPITool *bat = [[BasicInfoAPITool alloc] init];
    [bat updateBasicInfoByDate:dateTime];
}

#pragma mark - Wheel View

- (void)wheelViewTappedButton2 {
    [self popToIndexViewController];
}
- (void)wheelViewTappedButton3 {
    self.nextView = videoMallView;
    [self showNextView];
}

- (void)wheelViewTappedButton4 {
    if (!videoBrandView) {
        videoBrandView = [[VideoBrandView alloc] initWithFrame:self.view.bounds];
        [videoBrandView setAlpha:0];
        [videoBrandView setDelegate:self];
        [self.view addSubview:videoBrandView];
        
        [videoBrandView showLoadingView];
        
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
            originShopVideoArray = [ArticleCoreDataHelper getVideoShopList];
            
            videoBrandView.videoListArray = originShopVideoArray;
        }];
        
        [operation setCompletionBlock:^{
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [videoBrandView createVideoListWithVideoEntityArray];
                [videoBrandView hideLoadingView];
            }];
        }];
        if ([SingleCase singleCase].coredataOperationQueue.operations.count > 0) {
            [operation addDependency:[[SingleCase singleCase].coredataOperationQueue.operations lastObject]];
        }
        
        [[SingleCase singleCase].coredataOperationQueue addOperation:operation];
    }
    
    self.nextView = videoBrandView;
    [self showNextView];
}

@end
