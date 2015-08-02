//
//  ParentViewController.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/1.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

//#import <UIKit/UIKit.h>

#import "TSOutlets-Swift.h"
#import "AppDelegate.h"

#import "NavigationView.h"
#import "WheelView.h"
#import "AlertView.h"
#import "TipView.h"

#import "GuideViewController.h"
#import "MemberViewController.h"

#import "IndexViewController.h"
#import "ShopViewController.h"
#import "ShopInfoViewController.h"
#import "EventViewController.h"
#import "EventInfoViewController.h"
#import "EventThemeViewController.h"
#import "VideoViewController.h"
#import "ServiceViewController.h"
#import "ItemViewController.h"
#import "ItemInfoViewController.h"
#import "CollectionViewController.h"
#import "MessageViewController.h"
#import "MemberInfoViewController.h"
#import "MemberRegisterViewController.h"
#import "OnlineDetailViewController.h"
#import "OfflineDetailViewController.h"
#import "LocationViewController.h"
#import "ReplyViewController.h"
#import "BrowserViewController.h"

@interface ParentViewController : UIViewController
<
    BasicInfoAPIToolDelegate,

    MotherViewControllerDelegate,
    NavigationViewDelegate,
    WheelViewDelegate,
    MemberViewControllerDelegate
>
{
    NavigationView          *navi;
    WheelView               *wheel;
    TipView                 *tip;
    
    UIButton                *hideButton;
    TempletView             *viewControllerContainer;
    
    MotherViewController    *currentViewController;
    MotherViewController    *nextViewController;
    NSMutableArray          *viewControllerArray;
    
    NSDictionary            *apiDictionary;
    
    BOOL                    loginStatus;
    BOOL                    animating;
}

- (void)handleLog;
- (void)lookForMessageCount;

@end
