//
//  EventInfoViewController.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/8.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "EventInfoViewController.h"

@interface EventInfoViewController ()

@end

@implementation EventInfoViewController

#pragma mark - Init View
- (void)initFirstViewWithParameter:(NSDictionary *)parameter
{
    if (!eventInfoView) {
        eventInfoView = [[EventInfoView alloc] initWithFrame:self.view.bounds];
        [eventInfoView setDelegate:self];
        [eventInfoView setEventEntity:_eventEntity];
        [eventInfoView getInfo];
        [self.view addSubview:eventInfoView];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldRecordLog" object:[NSString stringWithFormat:@"Event: %@", _eventEntity.eventID]];
    }
}

#pragma mark - Delegate
- (void)eventInfoViewDidTapShopEntity:(ShopEntity *)shopEntity {
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_eventEntity.shopEntity, @"entity", nil];
    [self pushViewControllerWithViewControllerType:ViewControllerTypeShopInfo andParameter:dic];
}

@end
