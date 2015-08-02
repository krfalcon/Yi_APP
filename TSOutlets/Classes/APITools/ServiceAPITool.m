//
//  ServiceAPITool.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/1.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ServiceAPITool.h"
#import "JSONHelper.h"
#import "WsAddrHelper.h"
#import "HTTPPostDataGenerator.h"

#import "MemberCoreDataHelper.h"
#import "MessageCoreDataHelper.h"
#import "FeedbackEntity.h"
#import "MessageEntity.h"

@implementation ServiceAPITool

#pragma mark - network
//feedback
- (void)postFeedback:(NSString *)feedback {
    NSString *wsAddress = [NSString stringWithFormat:@"%@Event/Question?token=%@&question=%@", APIAddr, [MemberCoreDataHelper getMemberToken], feedback];
    wsAddress = [wsAddress stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:wsAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    postFeedbackConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (postFeedbackConnection) {
    }
}

- (void)getAllFeedback {
    NSString *wsAddress = [NSString stringWithFormat:@"%@Event/GetAnswers?token=%@", APIAddr, [MemberCoreDataHelper getMemberToken]];
    wsAddress = [wsAddress stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:wsAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    getFeedbackConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (getFeedbackConnection) {
    }
}

- (void)autoReplay:(NSString *)question {
    NSString *wsAddress = [NSString stringWithFormat:@"%@Event/IntelligentReply?token=%@&question=%@", APIAddr, [MemberCoreDataHelper getMemberToken], question];
    wsAddress = [wsAddress stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:wsAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    replyConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (replyConnection) {
    }
}


//message
- (void)getAllMessage {
    NSString *wsAddress = [NSString stringWithFormat:@"%@Event/GetMessage?token=%@", APIAddr, [MemberCoreDataHelper getMemberToken]];
    wsAddress = [wsAddress stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:wsAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    messageConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (messageConnection) {
    }
}

- (void)getAllMessageCount {
    NSString *wsAddress = [NSString stringWithFormat:@"%@Event/GetUnreadCount?token=%@", APIAddr, [MemberCoreDataHelper getMemberToken]];
    wsAddress = [wsAddress stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:wsAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    messageCountConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (messageCountConnection) {
    }
}

#pragma mark - Connection Delegate Method

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if ([connection isEqual:postFeedbackConnection]) { postFeedbackData = [NSMutableData data]; }
    
    if ([connection isEqual:getFeedbackConnection]) { getFeedbackData = [NSMutableData data]; }
    
    if ([connection isEqual:replyConnection]) { replyData = [NSMutableData data]; }
    
    if ([connection isEqual:messageConnection]) { messageData = [NSMutableData data]; }
    
    if ([connection isEqual:messageCountConnection]) { messageCountData = [NSMutableData data]; }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if ([connection isEqual:postFeedbackConnection]) { [postFeedbackData appendData:data]; }
    
    if ([connection isEqual:getFeedbackConnection]) { [getFeedbackData appendData:data]; }
    
    if ([connection isEqual:replyConnection]) { [replyData appendData:data]; }
    
    if ([connection isEqual:messageConnection]) { [messageData appendData:data]; }
    
    if ([connection isEqual:messageCountConnection]) { [messageCountData appendData:data]; }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if ([connection isEqual:postFeedbackConnection]) {
        NSDictionary *resDic = [JSONHelper dataToDictionary:postFeedbackData];
        if (resDic) {
            [self getAllFeedback];
        }
    }
    
    if ([connection isEqual:getFeedbackConnection]) {
        NSDictionary *resDic = [JSONHelper dataToDictionary:getFeedbackData];
        if (resDic) {
            [self addFeedback:[FeedbackEntity QA2Array:resDic[@"QA"]]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getFeedbackList" object:[FeedbackEntity QA2Array:resDic[@"QA"]]];
        }
    }
    
    if ([connection isEqual:replyConnection]) {
        NSDictionary *resDic = [JSONHelper dataToDictionary:replyData];
        if (resDic) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getIntelligentReply" object:resDic[@"reply"]];
        }
    }
    
    if ([connection isEqual:messageConnection]) {
        NSDictionary *resDic = [JSONHelper dataToDictionary:messageData];
        if (resDic) {
            if ([self updateMessage:[MessageEntity information2MessageArray:resDic[@"information"]]]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"getMessageList" object:0];
            }
        }
    }
    
    if ([connection isEqual:messageCountConnection]) {
        NSDictionary *resDic = [JSONHelper dataToDictionary:messageCountData];
        if (resDic) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getMessageList" object:resDic[@"unread"]];
        }
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^(){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"网络异常！请检查网络连接状况！"];
    }];
}

#pragma mark - local
- (NSArray *)getLoaclFeedback {
    return [MessageCoreDataHelper getFeedback];
}

- (BOOL)addFeedback:(NSArray *)feedback {
    return [MessageCoreDataHelper saveFeedback:feedback];
}

- (BOOL)updateFeedback:(NSString *)feedback {
    return YES;
}


- (NSArray *)getLoaclMessage {
    return [MessageCoreDataHelper getMessage];
}

- (BOOL)updateMessage:(NSArray *)message {
    return [MessageCoreDataHelper saveMessage:message];
}

- (BOOL)setMessageCount:(int)count {
    return YES;
}

- (BOOL)clearMessageCount {
    return YES;
}

- (NSString *)getMessageCount {
    return @"";
}

@end
