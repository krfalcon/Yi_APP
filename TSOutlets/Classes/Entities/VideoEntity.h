//
//  VideoEntity.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/7.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ShopEntity.h"

@interface VideoEntity : NSObject

@property (strong, nonatomic) NSString *videoID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *videoUrl;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSData   *image;
@property (strong, nonatomic) NSString *brandID;

#pragma mark - shop property

@property (strong, nonatomic) ShopEntity *shopEntity;

+ (VideoEntity *)article2VideoEntity:(NSManagedObject *)article;

@end
