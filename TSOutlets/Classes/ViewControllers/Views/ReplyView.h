//
//  ReplyView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/30.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"

typedef NS_ENUM(NSInteger, ChatType) {
    ChatTypeCustom = 0,
    ChatTypeTangtang
};

@protocol ReplyViewDelegate;

@interface ReplyView : TempletView <UIActionSheetDelegate>
{
    float keyboardHeight;
    float currentChatHeight;
    
    UIScrollView *replyScrollView;
    UITextView *replyTextField;
    UIView *replyView;
}

@property (weak,nonatomic)   id<ReplyViewDelegate>          delegate;

- (void)createChatViewWithChatType:(ChatType)chatType andContent:(NSString *)content;
- (void)hideKeyboard;

@end

@protocol ReplyViewDelegate <NSObject>

- (void)replyViewDidTapSMSButton;
- (void)replyViewDidTapCommitButtonWithQuestion:(NSString *)question;

@end