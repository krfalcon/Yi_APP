//
//  FeedbackEntity.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/30.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "FeedbackEntity.h"

@implementation FeedbackEntity

@synthesize feedbackID;
@synthesize question;
@synthesize questionTime;
@synthesize reply;
@synthesize replyTime;

+ (NSArray *)QA2Array:(NSArray *)QA {
    NSMutableArray *resArray = [[NSMutableArray alloc] init];
    if ([[NSString stringWithFormat:@"%@", QA] isEqualToString:@"<null>"]) return resArray;
    
    for (NSDictionary *dictionary in QA) {
        FeedbackEntity *feedbackEntity = [[FeedbackEntity alloc] init];
        feedbackEntity.feedbackID       = [NSString stringWithFormat:@"%@", dictionary[@"Id"]];
        feedbackEntity.question         = dictionary[@"Content"];
        feedbackEntity.questionTime     = dictionary[@"CreateTime"];
        feedbackEntity.reply            = [[NSString stringWithFormat:@"%@", dictionary[@"Reply"]] isEqualToString:@"<null>"] ? nil : dictionary[@"Reply"];
        feedbackEntity.replyTime        = [[NSString stringWithFormat:@"%@", dictionary[@"ReplyTime"]] isEqualToString:@"<null>"] ? nil : dictionary[@"ReplyTime"];
        
        [resArray addObject:feedbackEntity];
    }
    
    return resArray;
}

@end
