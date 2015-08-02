//
//  ShopEntity.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/26.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ShopEntity.h"

@implementation ShopEntity

@synthesize shopID;
@synthesize chName;
@synthesize enName;
@synthesize telephone;
@synthesize location;
@synthesize locationArea;
@synthesize category;
@synthesize logoUrl;
@synthesize introduction;
@synthesize carouselArray;
@synthesize logoImage;
@synthesize hasCollected;
@synthesize hasEvent;
//food
@synthesize remaining;
@synthesize calling;
@synthesize reserveNumber;
@synthesize reserveTable;
@synthesize tableSet;
@synthesize open;
@synthesize valid;

+ (ShopEntity *)article2ShopEntity:(NSManagedObject *)article {
    ShopEntity *shopEntity = [[ShopEntity alloc] init];
    
    [shopEntity setIntroduction:[article valueForKey:@"introduction"]];
    [shopEntity setShopID:[article valueForKey:@"shopID"]];
    [shopEntity setLogoUrl:[NSString stringWithFormat:@"%@%@", APIAddr ,[article valueForKey:@"logoUrl"]]];
    [shopEntity setChName:[[article valueForKey:@"chName"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    [shopEntity setEnName:[[article valueForKey:@"enName"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    [shopEntity setLocation:[[article valueForKey:@"location"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    [shopEntity setLocationArea:[[article valueForKey:@"locationArea"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    [shopEntity setTelephone:[[article valueForKey:@"telephone"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    [shopEntity setCategory:[[article valueForKey:@"category"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    [article valueForKey:@"favorite"] ? [shopEntity setHasCollected:YES] : [shopEntity setHasCollected:NO];
    
    NSMutableArray *tableArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in [article valueForKey:@"tableSet"]) {
        TableType *tableType = [[TableType alloc] init];
        tableType.tableID = dic[@"Id"];
        tableType.tableName = dic[@"Name"];
        tableType.maxNumber = dic[@"Max"];
        tableType.minNumber = dic[@"Min"];
        [tableArray addObject:tableType];
    }
    tableArray.count > 0 ? [shopEntity setTableSet:tableArray] : [shopEntity setTableSet:nil];
    
    NSMutableArray *carousel = [[NSMutableArray alloc] init];
    for (NSString *url in [article valueForKey:@"carouselArray"]) {
        [carousel addObject:[NSString stringWithFormat:@"%@%@", APIAddr, url]];
    }
    [shopEntity setCarouselArray:carousel];
    
    return shopEntity;
}

+ (ShopEntity *)queue2ShopEntity:(NSDictionary *)dic {
    ShopEntity *shopEntity = [[ShopEntity alloc] init];
    
    shopEntity.introduction     = dic[@"brand"][@"Content"];
    shopEntity.shopID           = dic[@"brand"][@"Id"];
    shopEntity.logoUrl          = [NSString stringWithFormat:@"%@%@", APIAddr ,dic[@"brand"][@"LogoUrl"]];
    shopEntity.chName           = dic[@"brand"][@"Name"];
    shopEntity.enName           = dic[@"brand"][@"EnName"];;
    shopEntity.location         = dic[@"brand"][@"Area"];
    shopEntity.locationArea     = dic[@"brand"][@"Postion"];
    shopEntity.telephone        = dic[@"brand"][@"Tele"];
    shopEntity.category         = dic[@"brand"][@"BrandType"];
    
    //[article valueForKey:@"favorite"] ? [shopEntity setHasCollected:YES] : [shopEntity setHasCollected:NO];
    
    NSMutableArray *tableArray = [[NSMutableArray alloc] init];
    for (NSDictionary *d in dic[@"brand"][@"Table"]) {
        TableType *tableType = [[TableType alloc] init];
        tableType.tableID = d[@"Id"];
        tableType.tableName = d[@"Name"];
        tableType.maxNumber = d[@"Max"];
        tableType.minNumber = d[@"Min"];
        [tableArray addObject:tableType];
    }
    tableArray.count > 0 ? [shopEntity setTableSet:tableArray] : [shopEntity setTableSet:nil];
    
    NSMutableArray *carousel = [[NSMutableArray alloc] init];
    for (NSString *url in dic[@"FilesPath"]) {
        [carousel addObject:[NSString stringWithFormat:@"%@%@", APIAddr, url]];
    }
    [shopEntity setCarouselArray:carousel];
    
    shopEntity.hasCollected = [[NSString stringWithFormat:@"%@", dic[@"IsAttention"]] isEqualToString:@"1"];
    
    //food
    
    shopEntity.open             = [[NSString stringWithFormat:@"%@", dic[@"brand"][@"IsBusiness"]] isEqualToString:@"1"];
    shopEntity.remaining        = [NSString stringWithFormat:@"%@", dic[@"leftWaitNo"]];
    shopEntity.calling          = [NSString stringWithFormat:@"%@", dic[@"callNo"]];
    if (dic[@"queue"] != nil && ![[NSString stringWithFormat:@"%@", dic[@"queue"]] isEqualToString:@"<null>"]) {
        shopEntity.valid            = [dic[@"queue"][@"Type"] integerValue];
        shopEntity.reserveNumber    = [NSString stringWithFormat:@"%@", dic[@"queue"][@"QueueCode"]];
        shopEntity.reserveTable     = [NSString stringWithFormat:@"%@", dic[@"queue"][@"Table"][@"Name"]];
    } else {
        shopEntity.valid = 4;
    }
        
    return shopEntity;
}

@end

@implementation TableType

@synthesize tableID;
@synthesize tableName;
@synthesize maxNumber;
@synthesize minNumber;

@end
