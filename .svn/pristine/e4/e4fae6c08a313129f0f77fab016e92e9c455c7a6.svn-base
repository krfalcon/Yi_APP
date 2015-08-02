//
//  VideoEntity.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/7.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "VideoEntity.h"

@implementation VideoEntity

@synthesize videoID;
@synthesize title;
@synthesize time;
@synthesize videoUrl;
@synthesize imageUrl;
@synthesize image;
@synthesize brandID;

#pragma mark - shop property

@synthesize shopEntity;

+ (VideoEntity *)article2VideoEntity:(NSManagedObject *)article {
    VideoEntity *videoEntity = [[VideoEntity alloc] init];
    
    [videoEntity setVideoID:[article valueForKey:@"id"]];
    
//    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//    [df setDateFormat:@"yyyy-MM-dd"];
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[[article valueForKey:@"createTime"] substringWithRange:NSMakeRange(6, 10)] intValue]];
    
    [videoEntity setTime:[[[article valueForKey:@"createTime"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] substringToIndex:10]];
    [videoEntity setTitle:[[article valueForKey:@"title"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    if ([article valueForKey:@"files"]) {
        //NSMutableArray *file = [[NSMutableArray alloc] init];
        
        NSArray *fileArray = [article valueForKey:@"files"];
        for (NSString *fileDic in fileArray) {
            //NSLog(@"%@", [[fileDic objectForKey:@"File"] objectForKey:@"FileAddr"]);
            [videoEntity setImageUrl:[NSString stringWithFormat:@"%@%@", APIAddr, fileDic]];
        }
        
    }
    
    if ([article valueForKey:@"customField"]) {
        //NSLog(@"%@", [article valueForKey:@"customField"]);
        NSError *error;
        NSString *str = [JSONHelper clearReturn:[article valueForKey:@"customField"]];
        NSDictionary *res = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
        
        [videoEntity setVideoUrl:[[res valueForKey:@"Url"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
        
        videoEntity.brandID = [[res valueForKey:@"BrandId"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    
    return videoEntity;
}

@end
