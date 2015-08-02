//
//  OfflineDetailViewController.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/12.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "OfflineDetailViewController.h"

@interface OfflineDetailViewController ()

@end

@implementation OfflineDetailViewController

- (void)initFirstViewWithParameter:(NSDictionary *)parameter
{
    if (!offlinePointDetailView) {
        offlinePointDetailView = [[OfflinePointDetailView alloc] initWithFrame:self.view.bounds];
        //[onlinePointDetailView setDelegate:self];
        [self.view addSubview:offlinePointDetailView];
        
        self.currentView = offlinePointDetailView;
        
        [offlinePointDetailView getInfo:nil];
    }
}

@end
