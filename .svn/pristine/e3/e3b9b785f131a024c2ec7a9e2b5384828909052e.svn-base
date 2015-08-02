//
//  MessageEntity.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/7/2.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "MessageEntity.h"

@implementation MessageEntity

@synthesize messageID;
@synthesize date;
@synthesize content;
@synthesize point;
@synthesize type;
@synthesize entity;

+ (NSArray *)information2MessageArray:(NSArray *)information {
    NSMutableArray *resArray = [[NSMutableArray alloc] init];
    if ([[NSString stringWithFormat:@"%@", information] isEqualToString:@"<null>"]) return resArray;
    
    for (NSDictionary *dictionary in information) {
        MessageEntity *messageEntity    = [[MessageEntity alloc] init];
        messageEntity.messageID         = [NSString stringWithFormat:@"%@", dictionary[@"Id"]];
        messageEntity.content           = [NSString stringWithFormat:@"%@", dictionary[@"Content"]];
        messageEntity.date              = [NSString stringWithFormat:@"%@", dictionary[@"CreateTime"]];
        messageEntity.point             = [NSString stringWithFormat:@"%@", dictionary[@"Fields"]];
        messageEntity.type              = [NSString stringWithFormat:@"%@", dictionary[@"Type"]];
        
        [resArray addObject:messageEntity];
    }
    
    return resArray;
}

@end
