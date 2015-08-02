//
//  EventEntity.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/2.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ShopEntity.h"

@interface EventEntity : NSObject

@property (strong, nonatomic) NSString *eventID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *beginTime;
@property (strong, nonatomic) NSString *endTime;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSData   *image;
@property (strong, nonatomic) NSString *brandID;

#pragma mark - shop property

@property (strong, nonatomic) ShopEntity *shopEntity;

#pragma mark - shop event

@property (strong, nonatomic) NSArray  *entityArray;

+ (EventEntity *)article2EventEntity:(NSManagedObject *)article;

@end
