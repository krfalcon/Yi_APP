//
//  EventViewController.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/2.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "MotherViewController.h"

#import "EventEntity.h"

#import "EventShopView.h"
#import "EventMallView.h"


@interface EventViewController : MotherViewController<EventShopViewDelegate, EventMallViewDelegate>
{
    NSArray*                                            originShopEventArray;
    
    EventMallView*                                      eventMallView;
    EventShopView*                                      eventShopView;
}

@property(assign,nonatomic) int                         currentPage;

@end
