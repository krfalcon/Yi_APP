//
//  ShopEntity.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/26.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "JSONHelper.h"
#import "WsAddrHelper.h"

@interface ShopEntity : NSObject

@property (strong, nonatomic) NSString *shopID;
@property (strong, nonatomic) NSString *chName;
@property (strong, nonatomic) NSString *enName;
@property (strong, nonatomic) NSString *telephone;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *locationArea;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *logoUrl;
@property (strong, nonatomic) NSString *introduction;
@property (strong, nonatomic) NSArray  *carouselArray;
@property (strong, nonatomic) NSData   *logoImage;
@property (assign, nonatomic) BOOL     hasCollected;
@property (assign, nonatomic) BOOL     hasEvent;
//food
@property (strong, nonatomic) NSString *remaining;
@property (strong, nonatomic) NSString *calling;
@property (strong, nonatomic) NSString *reserveNumber;
@property (strong, nonatomic) NSString *reserveTable;
@property (strong, nonatomic) NSArray  *tableSet;
@property (assign, nonatomic) NSInteger valid;
@property (assign, nonatomic) BOOL      open;

+ (ShopEntity *)article2ShopEntity:(NSManagedObject *)article;
+ (ShopEntity *)queue2ShopEntity:(NSDictionary *)dic;

@end

@interface TableType : NSObject

@property (strong, nonatomic) NSString *tableID;
@property (strong, nonatomic) NSString *tableName;
@property (strong, nonatomic) NSString *maxNumber;
@property (strong, nonatomic) NSString *minNumber;

@end