//
//  ServiceAPITool.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/1.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceAPITool : NSObject<NSURLConnectionDelegate>
{
    NSMutableData* postFeedbackData;
    NSMutableData* getFeedbackData;
    NSMutableData* replyData;
    NSMutableData* messageData;
    NSMutableData* messageCountData;
    
    NSURLConnection* postFeedbackConnection;
    NSURLConnection* getFeedbackConnection;
    NSURLConnection* replyConnection;
    NSURLConnection* messageConnection;
    NSURLConnection* messageCountConnection;
}

#pragma mark - network
//feedback
- (void)postFeedback:(NSString *)feedback;
- (void)getAllFeedback;
- (void)autoReplay:(NSString *)question;

//message
- (void)getAllMessage;
- (void)getAllMessageCount;

#pragma mark - local
- (NSArray *)getLoaclFeedback;
- (BOOL)addFeedback:(NSArray *)feedback;
- (BOOL)updateFeedback:(NSString *)feedback;

- (NSArray *)getLoaclMessage;
- (BOOL)updateMessage:(NSArray *)message;
- (BOOL)setMessageCount:(int)count;
- (BOOL)clearMessageCount;
- (NSString *)getMessageCount;

@end
