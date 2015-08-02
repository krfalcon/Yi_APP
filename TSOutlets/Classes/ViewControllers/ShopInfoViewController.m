//
//  ShopInfoViewController.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/23.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ShopInfoViewController.h"

@implementation ShopInfoViewController

#pragma mark - Init View
- (void)initFirstViewWithParameter:(NSDictionary *)parameter {
    if (!shopInfoView) {
        shopInfoView = [[ShopInfoView alloc] initWithFrame:self.view.bounds];
        [shopInfoView setDelegate:self];
        [shopInfoView setShopEntity:_shopEntity];
        [shopInfoView getInfo];
        [self.view addSubview:shopInfoView];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldRecordLog" object:[NSString stringWithFormat:@"Brand: %@", _shopEntity.shopID]];
    }
    
    self.currentView = shopInfoView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getReserveInfo:) name:@"getReserveInfo" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memberLogin) name:@"memberLogin" object:nil];
}

#pragma mark - View Opration

- (void)switchToFoodReserveView {
    if (!shopFoodView) {
        shopFoodView = [[ShopFoodView alloc] initWithFrame:self.view.bounds];
        shopFoodView.shopEntity = _shopEntity;
        shopFoodView.delegate = self;
        [shopFoodView getInfo];
        [self.view addSubview:shopFoodView];
        
        FoodAPITool *fat = [[FoodAPITool alloc] init];
        [fat getQueueDetail:_shopEntity.shopID];
    }
    
    self.currentView = shopFoodView;
}

- (void)getReserveInfo:(NSNotification *)noti {
    shopFoodView.shopEntity = [noti object];
    [shopFoodView refreshInfo];
}

- (void)memberLogin {
    
}

#pragma mark - Shop Views Delegate

- (void)shopInfoView:(ShopInfoView *)shopInfoView didStartDragScrollView:(UIScrollView *)scrollView {
    [self wheelViewShouldHide];
}

- (void)shopEventView:(ShopEventView *)shopEventView didStartDragScrollView:(UIScrollView *)scrollView {
    [self wheelViewShouldHide];
}

- (void)shopEventView:(ShopEventView *)shopEventView didTapEventButtonWithEventEntity:(EventEntity *)eventEntity {
    NSDictionary *parameter = [NSDictionary dictionaryWithObjectsAndKeys:eventEntity, @"entity", nil];
    [self pushViewControllerWithViewControllerType:ViewControllerTypeEventInfo andParameter:parameter];
}

- (void)shopVideoView:(ShopVideoView *)shopVideoView didStartDragScrollView:(UIScrollView *)scrollView {
    [self wheelViewShouldHide];
}

- (void)shopVideoView:(ShopVideoView *)shopVideoView didPlayerVideo:(NSString *)url {
    [self didTappedVideoWithVideoUrl:url];
}

- (void)shopFoodViewDidTapReserveButtonWithNumber:(NSString *)number andShopID:(NSString *)shopID {
    FoodAPITool *fat = [[FoodAPITool alloc] init];
    [fat reserveForBrand:shopID andNumber:number];
}

- (void)shopFoodViewDidTapCancelButtonWithShopID:(NSString *)shopID {
    FoodAPITool *fat = [[FoodAPITool alloc] init];
    [fat cancelForBran:shopID];
}

- (void)shopFoodView:(ShopFoodView *)shopFoodView didStartDragScrollView:(UIScrollView *)scrollView {
    [self wheelViewShouldHide];
}

- (void)shopItemView:(ShopItemView *)shopItemView didStartDragScrollView:(UIScrollView *)scrollView {
    [self wheelViewShouldHide];
}

- (void)shopItemView:(ShopItemView *)itemListView didTapItemButtonWithItemEntity:(ItemEntity *)itemEntity {
    NSDictionary *parameter = [NSDictionary dictionaryWithObjectsAndKeys:itemEntity, @"entity", nil];
    [self pushViewControllerWithViewControllerType:ViewControllerTypeItemInfo andParameter:parameter];
}

#pragma mark - Wheel View 

- (void)wheelViewTappedButton1 {
    [self popToIndexViewController];
}

- (void)wheelViewTappedButton2 {
    if (!shopInfoView) {
        shopInfoView = [[ShopInfoView alloc] initWithFrame:self.view.bounds];
        [shopInfoView setDelegate:self];
        [shopInfoView setShopEntity:_shopEntity];
        [shopInfoView getInfo];
        [self.view addSubview:shopInfoView];
    }
    
    self.nextView = shopInfoView;
    [self showNextView];
}

- (void)wheelViewTappedButton3 {
    if (!shopEventView) {
        shopEventView = [[ShopEventView alloc] initWithFrame:self.view.bounds];
        [shopEventView setDelegate:self];
        [shopEventView setShopEntity:_shopEntity];
        [shopEventView getInfo];
        [shopEventView setAlpha:0];
        [self.view addSubview:shopEventView];
        
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
            [shopEventView setEventListArray:[ArticleCoreDataHelper getEventArrayWithShopID:_shopEntity.shopID]];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [shopEventView createEventList];
            }];
        }];
        if ([SingleCase singleCase].coredataOperationQueue.operations.count > 0) {
            [operation addDependency:[[SingleCase singleCase].coredataOperationQueue.operations lastObject]];
        }
        
        [[SingleCase singleCase].coredataOperationQueue addOperation:operation];
    }
    
    self.nextView = shopEventView;
    [self showNextView];
}

- (void)wheelViewTappedButton4 {
    if (_shopEntity.tableSet) {
        FoodAPITool *fat = [[FoodAPITool alloc] init];
        [fat getQueueDetail:_shopEntity.shopID];
        
        if (!shopFoodView) {
            shopFoodView = [[ShopFoodView alloc] initWithFrame:self.view.bounds];
            shopFoodView.shopEntity = _shopEntity;
            shopFoodView.delegate = self;
            [shopFoodView getInfo];
            [self.view addSubview:shopFoodView];
        }
        
        self.nextView = shopFoodView;
    } else {
        if (!shopItemView) {
            shopItemView = [[ShopItemView alloc] initWithFrame:self.view.bounds];
            [shopItemView setDelegate:self];
            [shopItemView setItemListArray:[ArticleCoreDataHelper getItemArrayWithShopID:_shopEntity.shopID]];
            [shopItemView getInfo];
            [shopItemView setAlpha:0];
            [self.view addSubview:shopItemView];
        }
        
        self.nextView = shopItemView;
    }
    
    [self showNextView];
}

- (void)wheelViewTappedButton5 {
    if (!shopVideoView) {
        shopVideoView = [[ShopVideoView alloc] initWithFrame:self.view.bounds];
        [shopVideoView setDelegate:self];
        [shopVideoView setAlpha:0];
        [self.view addSubview:shopVideoView];
        
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [shopVideoView createEventListWithEventEntityArray:[ArticleCoreDataHelper getVideoArrayWithShopID:_shopEntity.shopID]];
            }];
        }];
        if ([SingleCase singleCase].coredataOperationQueue.operations.count > 0) {
            [operation addDependency:[[SingleCase singleCase].coredataOperationQueue.operations lastObject]];
        }
        
        [[SingleCase singleCase].coredataOperationQueue addOperation:operation];
    }
    
    self.nextView = shopVideoView;
    [self showNextView];
}

@end
