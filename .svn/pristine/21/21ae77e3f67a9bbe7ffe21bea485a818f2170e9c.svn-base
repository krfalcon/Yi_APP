//
//  ReplyView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/30.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ReplyView.h"

#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>

@implementation ReplyView

- (void)initView {
    UIButton *manualButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.15f, 15.f * self.scale + self.titleHeight, self.frame.size.width * 0.7f, 30 * self.scale)];
    manualButton.layer.cornerRadius = 15.f * self.scale;
    [manualButton setBackgroundColor:ThemeYellowOrange];
    [manualButton addTarget:self action:@selector(tappedCustomerButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:manualButton];
    
    UILabel *manualLabel = [[UILabel alloc] initWithFrame:manualButton.bounds];
    [manualLabel setBackgroundColor:[UIColor clearColor]];
    [manualLabel setText:@"转接人工"];
    [manualLabel setTextColor:AbsoluteWhite];
    [manualLabel setTextAlignment:NSTextAlignmentCenter];
    [manualLabel setFont:[UIFont systemFontOfSize:19 * self.scale]];
    [manualButton addSubview:manualLabel];
    
    [self regNotification];
    
    replyScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60 * self.scale + self.titleHeight, self.frame.size.width, self.frame.size.height - 60 * self.scale - self.titleHeight)];
    [self addSubview:replyScrollView];
    
    replyView = [[UIView alloc] initWithFrame:CGRectMake(0, 60 * self.scale + self.titleHeight + replyScrollView.frame.size.height, self.frame.size.width, 130 * self.scale)];
    [self addSubview:replyView];
    
    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 2)];
    [textView setBackgroundColor:ThemeYellow];
    [replyView addSubview:textView];
    
    UIButton *replyButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 60 * self.scale, 10 * self.scale, 50 * self.scale, 30 * self.scale)];
    [replyButton setExclusiveTouch:YES];
    [replyButton addTarget:self action:@selector(sendQuestion) forControlEvents:UIControlEventTouchUpInside];
    [replyView addSubview:replyButton];
    
    UILabel *replyButtonLabel = [[UILabel alloc] initWithFrame:replyButton.bounds];
    replyButtonLabel.layer.cornerRadius = 5.f * self.scale;
    replyButtonLabel.layer.backgroundColor = ThemeYellowOrange.CGColor;
    replyButtonLabel.text = @"发送";
    replyButtonLabel.textColor = AbsoluteWhite;
    replyButtonLabel.textAlignment = NSTextAlignmentCenter;
    replyButtonLabel.font = [UIFont systemFontOfSize:18.f * self.scale];
    [replyButton addSubview:replyButtonLabel];
    
    replyTextField = [[UITextView alloc] initWithFrame:CGRectMake(10 * self.scale, 10 * self.scale, self.frame.size.width - 80 * self.scale, 50 * self.scale)];
    replyTextField.layer.cornerRadius = 5.f * self.scale;
    replyTextField.layer.borderWidth = 2.f;
    replyTextField.layer.borderColor = ThemeYellowOrange.CGColor;
    replyTextField.font = [UIFont systemFontOfSize:16.f * self.scale];
    [replyView addSubview:replyTextField];
    
    [replyTextField becomeFirstResponder];
    
    currentChatHeight = 0;
    
    [self createChatViewWithChatType:ChatTypeTangtang andContent:@"请问有什么需要问汤汤的吗？"];
    //NSLog(@"%f", keyboardHeight);
}

- (void)dealloc {
    [self unregNotification];
}

- (void)hideKeyboard {
    [replyTextField resignFirstResponder];
}

- (void)sendQuestion {
    if (replyTextField.text.length > 0) {
        if (_delegate && [_delegate respondsToSelector:@selector(replyViewDidTapCommitButtonWithQuestion:)]) {
            [_delegate replyViewDidTapCommitButtonWithQuestion:replyTextField.text];
            
            [self createChatViewWithChatType:ChatTypeCustom andContent:replyTextField.text];
            replyTextField.text = @"";
        }
    }
}

- (void)createChatViewWithChatType:(ChatType)chatType andContent:(NSString *)content {
    UIView *chatView = [[UIView alloc] initWithFrame:CGRectMake(0, currentChatHeight, replyScrollView.frame.size.width, 0)];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 * self.scale, 5 * self.scale, 100 * self.scale, 20 * self.scale)];
    nameLabel.font = [UIFont systemFontOfSize:20 * self.scale];
    [chatView addSubview:nameLabel];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(50 * self.scale, 30 * self.scale, replyScrollView.frame.size.width - 80 * self.scale, 20 * self.scale)];
    contentLabel.text = content;
    contentLabel.font = [UIFont systemFontOfSize:20 * self.scale];
    contentLabel.numberOfLines = 0;
    [chatView addSubview:contentLabel];
    
    switch (chatType) {
        case ChatTypeCustom:
            nameLabel.text = @"您：";
            nameLabel.textColor = ThemeYellowFont;
            contentLabel.textColor = ThemeYellowFont;
            break;
        case ChatTypeTangtang:
            nameLabel.text = @"汤汤：";
            nameLabel.textColor = ThemeBlue;
            contentLabel.textColor = ThemeBlue;
            if (contentLabel.text.length == 0) contentLabel.text = @"汤汤并不能理解您的问题，请转人工客服试试看吧~";
            break;
        default:
            break;
    }
    
    [contentLabel sizeToFit];
    
    [chatView setFrame:(CGRect){chatView.frame.origin, chatView.frame.size.width, 45 * self.scale + contentLabel.frame.size.height}];
    currentChatHeight += chatView.frame.size.height;
    
    [replyScrollView addSubview:chatView];
    [replyScrollView setContentSize:CGSizeMake(replyScrollView.frame.size.width, currentChatHeight)];
    if (replyScrollView.contentSize.height - replyScrollView.frame.size.height > 0) [replyScrollView setContentOffset:CGPointMake(0, replyScrollView.contentSize.height - replyScrollView.frame.size.height) animated:YES];
}

#pragma mark - Custom Function
- (void)tappedCustomerButton {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"QQ联系", @"短信联系", @"电话联系", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
        {
            //设置一个有效的号码
            NSString * qqNum = @"10000";
            
            if ([qqNum length] == 0) {
                UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"在demo代码里设置一个有效号码" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
                [msgbox show];
                return;
            }
            
            QQApiWPAObject *wpaObj = [QQApiWPAObject objectWithUin:qqNum];
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:wpaObj];
            QQApiSendResultCode sent = [QQApiInterface sendReq:req];
            
            NSLog(@"%d", sent);
            //[self handleSendResult:sent];
            break;
        }
        case 1:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(replyViewDidTapSMSButton)]) {
                [_delegate replyViewDidTapSMSButton];
            }
            
            //            UIWebView *callPhoneWebVw = [[UIWebView alloc] init];
            //            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@", @"10086"]]];
            //            [callPhoneWebVw loadRequest:request];
            //
            //            [self.superview addSubview:callPhoneWebVw];
            
            break;
        }
        case 2:
        {
            UIWebView *callPhoneWebVw = [[UIWebView alloc] init];
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", @"10086"]]];
            [callPhoneWebVw loadRequest:request];
            
            [self.superview addSubview:callPhoneWebVw];
            break;
        }
        default:
            break;
    }
    
}

#pragma mark - reg & unreg notification

- (void)regNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)unregNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - notification handler

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    //CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //CGRect beginKeyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    keyboardHeight = endKeyboardRect.size.height;
    
    //NSLog(@"%f", keyboardHeight);
    
    [replyScrollView setFrame:CGRectMake(0, 60 * self.scale + self.titleHeight, self.frame.size.width, self.frame.size.height - 130 * self.scale - self.titleHeight - keyboardHeight)];

    
    [replyView setFrame:CGRectMake(0, 60 * self.scale + self.titleHeight + replyScrollView.frame.size.height, self.frame.size.width, 130 * self.scale)];
}

@end
