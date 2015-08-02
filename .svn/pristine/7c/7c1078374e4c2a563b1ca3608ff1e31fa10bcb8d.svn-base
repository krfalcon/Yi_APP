//
//  MessageView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/19.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"
#import "MessageEntity.h"

@protocol MessageViewDelegate;

@interface MessageView : TempletView
{
    UIScrollView *messageScrollView;
    NSArray*    messageArray;
}

@property (strong, nonatomic) id<MessageViewDelegate>     delegate;
- (void)initMessageView:(NSArray *)array;
- (void)refreshMessageView:(NSArray *)array;

@end

@protocol MessageViewDelegate <NSObject>

- (void)messageViewDidTapMessageButtonWithMessageEntity:(MessageEntity *)messageEntity;
- (void)messageViewDidRefresh;

@end
