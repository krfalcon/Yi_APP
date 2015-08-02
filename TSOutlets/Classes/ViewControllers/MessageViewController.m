//
//  MessageViewController.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/12.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "MessageViewController.h"
#import "ServiceAPITool.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)initFirstViewWithParameter:(NSDictionary *)parameter {
    messageView = [[MessageView alloc] initWithFrame:self.view.frame];
    [messageView setDelegate:self];
    [self.view addSubview:messageView];
    
    ServiceAPITool *sat = [[ServiceAPITool alloc] init];
    
    [messageView initMessageView:[sat getLoaclMessage]];
    
    //[sat getALLMessage];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMessageView) name:@"getMessageList" object:nil];
}

- (void)refreshMessageView {
    ServiceAPITool *sat = [[ServiceAPITool alloc] init];
    [messageView refreshMessageView:[sat getLoaclMessage]];
}

- (void)messageViewDidRefresh {
    ServiceAPITool *sat = [[ServiceAPITool alloc] init];
    [sat getAllMessage];
}

- (void)messageViewDidTapMessageButtonWithMessageEntity:(MessageEntity *)messageEntity {
    switch ([messageEntity.type intValue]) {
        case 0:
            break;
        case 1:
            [self pushViewControllerWithViewControllerType:ViewControllerTypeEventTheme andParameter:[NSDictionary dictionaryWithObject:[ArticleCoreDataHelper getEventEntityByID:messageEntity.point] forKey:@"entity"]];
            break;
        case 2:
            [self pushViewControllerWithViewControllerType:ViewControllerTypeEventInfo andParameter:[NSDictionary dictionaryWithObject:[ArticleCoreDataHelper getEventEntityByID:messageEntity.point] forKey:@"entity"]];
            break;
        case 3:
            [self pushViewControllerWithViewControllerType:ViewControllerTypeService andParameter:[NSDictionary dictionaryWithObject:@"1" forKey:@"feedback"]];
            break;
        case 4:
            [self pushViewControllerWithViewControllerType:ViewControllerTypeFoodReserve andParameter:[NSDictionary dictionaryWithObject:[ArticleCoreDataHelper getShopEntityByID:messageEntity.point] forKey:@"entity"]];
            break;
            break;
        default:
            break;
    }
}

@end
