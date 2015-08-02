//
//  ItemEntity.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/22.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ShopEntity.h"

@interface ItemEntity : NSObject

@property (strong, nonatomic) NSString *itemID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *sale;
@property (strong, nonatomic) NSString *rate;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSArray  *carouselArray;
@property (strong, nonatomic) NSString *brandID;
@property (strong, nonatomic) NSString *imageUrl;

#pragma mark - shop property

@property (strong, nonatomic) ShopEntity *shopEntity;

+ (ItemEntity *)article2ItemEntity:(NSManagedObject *)article;
+ (NSArray *)getItemArray;

@end
