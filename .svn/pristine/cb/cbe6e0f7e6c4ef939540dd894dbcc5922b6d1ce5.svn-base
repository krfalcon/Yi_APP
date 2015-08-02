//
//  OnlineDetailViewController.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/12.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "OnlineDetailViewController.h"

@interface OnlineDetailViewController ()

@end

@implementation OnlineDetailViewController

#pragma mark - InitView

- (void)initFirstViewWithParameter:(NSDictionary *)parameter
{
    if (!onlinePointDetailView) {
        onlinePointDetailView = [[OnlinePointDetailView alloc] initWithFrame:self.view.bounds];
        //[onlinePointDetailView setDelegate:self];
        [self.view addSubview:onlinePointDetailView];
        
        self.currentView = onlinePointDetailView;
        
        [onlinePointDetailView getInfo:nil];
    }
}

@end
