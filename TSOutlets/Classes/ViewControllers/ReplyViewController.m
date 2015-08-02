//
//  ReplyViewController.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/30.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ReplyViewController.h"

@interface ReplyViewController ()

@end

@implementation ReplyViewController

- (void)initFirstViewWithParameter:(NSDictionary *)parameter
{
    replyView = [[ReplyView alloc] initWithFrame:self.view.bounds];
    [replyView setDelegate:self];
    [self.view addSubview:replyView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getIntelligentReply:) name:@"getIntelligentReply" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboard) name:@"shouldHideKeyboard" object:nil];
}

#pragma mark - Notification
- (void)getIntelligentReply:(NSNotification *)noti {
    [replyView createChatViewWithChatType:1 andContent:noti.object];
}

- (void)hideKeyboard {
    [replyView hideKeyboard];
}

#pragma mark - Delegate
- (void)replyViewDidTapSMSButton {
    if( [MFMessageComposeViewController canSendText] ){
        
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init]; //autorelease];
        
        controller.recipients = [NSArray arrayWithObject:@"10086"];
        controller.body = @"测试发短信";
        controller.messageComposeDelegate = self;
        
        [replyView showLoadingView];
        
        [self presentViewController:controller animated:YES completion:^{[replyView hideLoadingView];}];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"该设备没有短信功能" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)replyViewDidTapCommitButtonWithQuestion:(NSString *)question {
    ServiceAPITool *sat = [[ServiceAPITool alloc] init];
    [sat autoReplay:question];
}

#pragma mark - MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
    [controller dismissViewControllerAnimated:YES completion:nil];//关键的一句   不能为YES
    
    switch (result) {
            
        case MessageComposeResultCancelled:
            break;
        case MessageComposeResultFailed:// send failed
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"发送失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            break;
        }
        case MessageComposeResultSent:
            break;
        default:
            break;
    }
}

@end
