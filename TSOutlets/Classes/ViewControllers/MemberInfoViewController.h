//
//  MemberInfoViewController.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/12.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "MotherViewController.h"

#import "MemberInfoView.h"
#import "OnlinePointView.h"
#import "OfflinePointView.h"
#import "OfflinePointBindView.h"

@interface MemberInfoViewController : MotherViewController<MemberInfoViewDelegate, OnlinePointViewDelegate, OfflinePointViewDelegate, OfflinePointBindViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    MemberInfoView*                                     memberInfoView;
    OnlinePointView*                                    onlinePointView;
    OfflinePointView*                                   offlinePointView;
    OfflinePointBindView*                               offlinePointBindView;
    
    MemberAPITool*                                      memberAPI;
}

@property (strong, nonatomic) MemberEntity*                memberEntity;

@end
