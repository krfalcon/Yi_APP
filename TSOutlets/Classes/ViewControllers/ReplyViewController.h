//
//  ReplyViewController.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/30.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "MotherViewController.h"

#import "ReplyView.h"
#import "ServiceAPITool.h"
#import <MessageUI/MessageUI.h>

@interface ReplyViewController : MotherViewController <MFMessageComposeViewControllerDelegate, ReplyViewDelegate>
{
    ReplyView *replyView;
}

@end
