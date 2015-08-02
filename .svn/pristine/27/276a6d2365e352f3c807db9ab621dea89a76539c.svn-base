//
//  EventEntity.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/2.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "EventEntity.h"

@implementation EventEntity

@synthesize eventID;
@synthesize title;
@synthesize beginTime;
@synthesize endTime;
@synthesize content;
@synthesize imageUrl;
@synthesize image;
@synthesize brandID;

#pragma mark - shop property

@synthesize shopEntity;

#pragma mark - shop event

@synthesize entityArray;

+ (EventEntity *)article2EventEntity:(NSManagedObject *)article {
    EventEntity *eventEntity = [[EventEntity alloc] init];
    
    [eventEntity setContent:[article valueForKey:@"content"]];
    [eventEntity setEventID:[article valueForKey:@"id"]];
    [eventEntity setTitle:[[article valueForKey:@"title"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    if ([article valueForKey:@"files"]) {
        //NSLog(@"%@", [article valueForKey:@"files"]);
        //NSMutableArray *file = [[NSMutableArray alloc] init];
        
        NSArray *fileArray = [article valueForKey:@"files"];
        for (NSString *fileDic in fileArray) {
            [eventEntity setImageUrl:[NSString stringWithFormat:@"%@%@", APIAddr, fileDic]];
        }
        
    }
    
    if ([article valueForKey:@"customField"]) {
        //NSLog(@"%@", [article valueForKey:@"customField"]);
        
        NSError *error;
        NSString *str = [JSONHelper clearReturn:[article valueForKey:@"customField"]];
        NSDictionary *res = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
        [eventEntity setBeginTime:[[res valueForKey:@"BeginTime"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
        [eventEntity setEndTime:[[res valueForKey:@"EndTime"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
        
        eventEntity.brandID = [[res valueForKey:@"BrandId"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    
    return eventEntity;
}

@end
