//
//  EventThemeViewController.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/9.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "EventThemeViewController.h"

@interface EventThemeViewController ()

@end

@implementation EventThemeViewController

#pragma mark - Init View
- (void)initFirstViewWithParameter:(NSDictionary *)parameter
{
    if (!eventThemeView) {
        eventThemeView = [[EventThemeView alloc] initWithFrame:self.view.bounds];
        [eventThemeView setDelegate:self];
        [eventThemeView setEventEntity:_eventEntity];
        [eventThemeView getInfo];
        [self.view addSubview:eventThemeView];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldRecordLog" object:[NSString stringWithFormat:@"Event: %@", _eventEntity.eventID]];
    }
}

#pragma mark - Event Views Delegate

- (void)eventThemeView:(EventThemeView *)eventThemeView didTapEventButtonWithEventEntity:(EventEntity *)eventEntity {
    NSDictionary *parameter = [NSDictionary dictionaryWithObjectsAndKeys:eventEntity, @"entity", nil];
    [self pushViewControllerWithViewControllerType:ViewControllerTypeEventInfo andParameter:parameter];
}

@end
