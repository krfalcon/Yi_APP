//
//  FeedbackEntity.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/30.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedbackEntity : NSObject

@property (strong, nonatomic) NSString *feedbackID;
@property (strong, nonatomic) NSString *question;
@property (strong, nonatomic) NSString *questionTime;
@property (strong, nonatomic) NSString *reply;
@property (strong, nonatomic) NSString *replyTime;

+ (NSArray *)QA2Array:(NSArray *)QA;

@end
