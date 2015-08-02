//
//  ArticleCoreDataHelper.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/26.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ArticleCoreDataHelper.h"
#import "ConfigCoreDataHelper.h"
#import "AppDelegate.h"

@implementation ArticleCoreDataHelper

+ (BOOL)addBasicInfoWithInfoArray:(NSDictionary *)jsonDic
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSError *error;
    NSArray *articleArray = jsonDic[@"Article"];
    
    for (NSDictionary *dic in articleArray) {
        NSEntityDescription *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Article" inManagedObjectContext:context];
        
        //NSLog(@"%@",[dic valueForKey:@"Files"]);
        
        [entity setValue:[dic valueForKey:@"CustomField"] forKey:@"customField"];
        //[entity setValue:[dic valueForKey:@"Dir"] forKey:@"dir"];
        [entity setValue:[dic valueForKey:@"FilesPath"] forKey:@"files"];
        [entity setValue:[dic valueForKey:@"Title"] forKey:@"title"];
        
        //NSLog(@"%@", [NSString stringWithFormat:@"%@", [dic valueForKey:@"Recommend"]]);
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"Recommend"]] forKey:@"recommend"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"IsDelete"]] forKey:@"display"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"DirId"]] forKey:@"dirID"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"Content"]] forKey:@"content"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"Checked"]] forKey:@"checked"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"Sortcode"]] forKey:@"sortcode"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"Click"]] forKey:@"click"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"Applaud"]] forKey:@"applaud"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"RelatedArticle"]] forKey:@"relatedArticle"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"Id"]] forKey:@"id"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"CreateTime"]] forKey:@"createTime"];
        
    }
    
    NSArray *brandArray = jsonDic[@"Brand"];
    
    for (NSDictionary *dic in brandArray) {
        NSEntityDescription *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Shop" inManagedObjectContext:context];
        
        //NSLog(@"%@",[dic valueForKey:@"Files"]);
        
        //[entity setValue:[dic valueForKey:@"CustomField"] forKey:@"customField"];
        //[entity setValue:[dic valueForKey:@"Dir"] forKey:@"dir"];
        [entity setValue:[dic valueForKey:@"Name"] forKey:@"chName"];
        [entity setValue:[dic valueForKey:@"EnName"] forKey:@"enName"];
        [entity setValue:[dic valueForKey:@"Table"] forKey:@"tableSet"];
        [entity setValue:[dic valueForKey:@"Area"] forKey:@"location"];
        [entity setValue:[dic valueForKey:@"BrandType"] forKey:@"category"];
        [entity setValue:[dic valueForKey:@"LogoUrl"] forKey:@"logoUrl"];
        [entity setValue:[dic valueForKey:@"Postion"] forKey:@"locationArea"];
        [entity setValue:[dic valueForKey:@"Tele"] forKey:@"telephone"];
        [entity setValue:[dic valueForKey:@"FilesPath"] forKey:@"carouselArray"];
        [entity setValue:[dic valueForKey:@"1"] forKey:@"favoriteSync"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"IsDelete"]] forKey:@"display"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"Sortcode"]] forKey:@"sortCode"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"Content"]] forKey:@"introduction"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"Id"]] forKey:@"shopID"];
        
    }
    
    if (![context save:&error]) {
        return NO;
    }
        
    return YES;
}

+ (BOOL)updateBasicInfoWithInfoArray:(NSDictionary *)jsonDic {
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSArray *articleArray = jsonDic[@"Article"];
    NSArray *brandArray = jsonDic[@"Brand"];
    
    NSFetchRequest *fetchArticle = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:context];
    [fetchArticle setEntity:entity];
    NSError *error;
    NSArray *objects;
    
    if (articleArray.count == 0 && brandArray.count == 0) {
        //[ConfigCoreDataHelper setUpdateDate];
        return YES;
    }
    
    for (NSDictionary *dic in articleArray) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id = %@", [dic valueForKey:@"Id"]];
        [fetchArticle setPredicate:predicate];
        
        @try {
             objects = [context executeFetchRequest:fetchArticle error:&error];
        }
        @catch (NSException* e) {
            NSLog(@"Exception: %@", e);
        }
        @finally {  
            //NSLog(@"finally");
        }
        
        //NSLog(@"%@",[dic valueForKey:@"Files"]);
        if (objects == nil || [objects count] == 0) {
            entity = [NSEntityDescription insertNewObjectForEntityForName:@"Article" inManagedObjectContext:context];
        } else if (objects.count > 1) {
            entity = [objects firstObject];
            for (int i = 1; i < objects.count; i ++) {
                [context deleteObject:objects[i]];
            }
        } else {
            entity = [objects firstObject];
        }
        
        [entity setValue:[dic valueForKey:@"CustomField"] forKey:@"customField"];
        [entity setValue:[dic valueForKey:@"FilesPath"] forKey:@"files"];
        [entity setValue:[dic valueForKey:@"Title"] forKey:@"title"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"Recommend"]] forKey:@"recommend"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"IsDelete"]] forKey:@"display"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"DirId"]] forKey:@"dirID"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"Content"]] forKey:@"content"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"Checked"]] forKey:@"checked"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"Sortcode"]] forKey:@"sortcode"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"Click"]] forKey:@"click"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"Applaud"]] forKey:@"applaud"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"RelatedArticle"]] forKey:@"relatedArticle"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"Id"]] forKey:@"id"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"CreateTime"]] forKey:@"createTime"];
    }
    
    NSFetchRequest *fetchBrand = [[NSFetchRequest alloc] init];
    entity = [NSEntityDescription entityForName:@"Shop" inManagedObjectContext:context];
    [fetchBrand setEntity:entity];
    
    for (NSDictionary *dic in brandArray) {
        NSPredicate *brandPredicate = [NSPredicate predicateWithFormat:@"shopID = %@", [dic valueForKey:@"Id"]];
        [fetchBrand setPredicate:brandPredicate];
        
        @try {
            objects = [context executeFetchRequest:fetchBrand error:&error];
        }
        @catch (NSException* e) {
            NSLog(@"Exception: %@", e);
        }
        @finally {
            //NSLog(@"finally");
        }
        
        //NSLog(@"%@",[dic valueForKey:@"Files"]);
        if (objects == nil || [objects count] == 0) {
            entity = [NSEntityDescription insertNewObjectForEntityForName:@"Shop" inManagedObjectContext:context];
        } else if (objects.count > 1) {
            entity = [objects firstObject];
            for (int i = 1; i < objects.count; i ++) {
                [context deleteObject:objects[i]];
            }
        } else {
            entity = [objects firstObject];
        }
        
        [entity setValue:[dic valueForKey:@"Name"] forKey:@"chName"];
        [entity setValue:[dic valueForKey:@"EnName"] forKey:@"enName"];
        [entity setValue:[dic valueForKey:@"Table"] forKey:@"tableSet"];
        [entity setValue:[dic valueForKey:@"Area"] forKey:@"location"];
        [entity setValue:[dic valueForKey:@"BrandType"] forKey:@"category"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"LogoUrl"]] forKey:@"logoUrl"];
        [entity setValue:[dic valueForKey:@"Postion"] forKey:@"locationArea"];
        [entity setValue:[dic valueForKey:@"Tele"] forKey:@"telephone"];
        [entity setValue:[dic valueForKey:@"FilesPath"] forKey:@"carouselArray"];
        [entity setValue:[dic valueForKey:@"1"] forKey:@"favoriteSync"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"IsDelete"]] forKey:@"display"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"Sortcode"]] forKey:@"sortCode"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"Content"]] forKey:@"introduction"];
        [entity setValue:[NSString stringWithFormat:@"%@", [dic valueForKey:@"Id"]] forKey:@"shopID"];
    }
    
    if (![context save:&error]) {
        return NO;
    }
    
    return YES;
}

#pragma mark - Index View

+ (IndexEntity *)getIndexList {
    IndexEntity *indexEntity = [[IndexEntity alloc] init];
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate mainObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"recommend != 0 and display != 1"];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"sortcode" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    //[fetchRequest setFetchLimit:20];
    NSError *error;
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray *itemList = [NSMutableArray array];
    
    for (NSManagedObject *obj in objects) {
        if ([[obj valueForKey:@"dirID"] isEqualToString:@"9"]) {
            ItemEntity *itemEntity = [ItemEntity article2ItemEntity:obj];
            
            NSFetchRequest *shopFetch = [[NSFetchRequest alloc] init];
            NSEntityDescription *shopEntity = [NSEntityDescription entityForName:@"Shop" inManagedObjectContext:context];
            NSPredicate *shopPredicate = [NSPredicate predicateWithFormat:@"shopID = %@", itemEntity.brandID];
            [shopFetch setEntity:shopEntity];
            [shopFetch setPredicate:shopPredicate];
            
            NSArray *shops = [context executeFetchRequest:shopFetch error:&error];
            
            if (shops.count > 0) {
                NSManagedObject *shop = [shops firstObject];
                
                [itemEntity setShopEntity:[ShopEntity article2ShopEntity:shop]];
            }
            
            [itemList addObject:itemEntity];
        }
        
        if ([[obj valueForKey:@"dirID"] isEqualToString:@"11"]) {
            EventEntity *eventEntity = [EventEntity article2EventEntity:obj];
            
            NSFetchRequest *shopFetch = [[NSFetchRequest alloc] init];
            NSEntityDescription *shopEntity = [NSEntityDescription entityForName:@"Shop" inManagedObjectContext:context];
            NSPredicate *shopPredicate = [NSPredicate predicateWithFormat:@"shopID = %@", eventEntity.brandID];
            [shopFetch setEntity:shopEntity];
            [shopFetch setPredicate:shopPredicate];
            
            NSArray *shops = [context executeFetchRequest:shopFetch error:&error];
            
            if (shops.count > 0) {
                NSManagedObject *shop = [shops firstObject];
                eventEntity.shopEntity = [ShopEntity article2ShopEntity:shop];
            }
            
            [indexEntity setMallEvent:eventEntity];
        }
        
        if ([[obj valueForKey:@"dirID"] isEqualToString:@"10"]) {
            EventEntity *eventEntity = [EventEntity article2EventEntity:obj];
            
            NSFetchRequest *shopFetch = [[NSFetchRequest alloc] init];
            NSEntityDescription *shopEntity = [NSEntityDescription entityForName:@"Shop" inManagedObjectContext:context];
            NSPredicate *shopPredicate = [NSPredicate predicateWithFormat:@"shopID = %@", eventEntity.brandID];
            [shopFetch setEntity:shopEntity];
            [shopFetch setPredicate:shopPredicate];
            
            NSArray *shops = [context executeFetchRequest:shopFetch error:&error];
            
            if (shops.count > 0) {
                NSManagedObject *shop = [shops firstObject];
                eventEntity.shopEntity = [ShopEntity article2ShopEntity:shop];
            }
            
            if (indexEntity.shopEvent) {
                indexEntity.shopEventTwo = eventEntity;
            } else {
                indexEntity.shopEvent = eventEntity;
            }
        }
    }
    
    indexEntity.itemArray = itemList;
    
    return indexEntity;
}

#pragma mark - Shop View

+ (NSArray *)getShopList {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate mainObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Shop" inManagedObjectContext:context];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"sortCode" ascending:YES];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"display != 1"];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entity];
    [fetchRequest setReturnsDistinctResults:YES];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray *shopList = [NSMutableArray array];
    
    NSFetchRequest *fetchEvent = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityEvent = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:context];
    NSPredicate *predicateEvent = [NSPredicate predicateWithFormat:@"dirID = 10"];
    [fetchEvent setEntity:entityEvent];
    [fetchEvent setPredicate:predicateEvent];
    NSArray *events = [context executeFetchRequest:fetchEvent error:&error];
    NSMutableArray *eventShopID = [[NSMutableArray alloc] init];
    
    for (NSManagedObject *obj in events) {
        NSError *error;
        NSString *str = [JSONHelper clearReturn:[obj valueForKey:@"customField"]];
        NSDictionary *res = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
        
        [eventShopID addObject:[[res valueForKey:@"BrandId"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    }
    
    for (NSManagedObject *obj in objects) {
        ShopEntity *shopEntity = [ShopEntity article2ShopEntity:obj];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains %@",shopEntity.shopID];
        if ([eventShopID filteredArrayUsingPredicate: predicate].count > 0) {
            shopEntity.hasEvent = YES;
        }
        
        [shopList addObject:shopEntity];
    }
       
    return shopList;
}

+ (NSArray *)getFavoriteShopList {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate mainObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Shop" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"favorite != nil and display != 1"];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"sortCode" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray *shopList = [NSMutableArray array];
    
    NSFetchRequest *fetchEvent = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityEvent = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:context];
    NSPredicate *predicateEvent = [NSPredicate predicateWithFormat:@"dirID = 10"];
    [fetchEvent setEntity:entityEvent];
    [fetchEvent setPredicate:predicateEvent];
    NSArray *events = [context executeFetchRequest:fetchEvent error:&error];
    NSMutableArray *eventShopID = [[NSMutableArray alloc] init];
    
    for (NSManagedObject *obj in events) {
        NSError *error;
        NSString *str = [JSONHelper clearReturn:[obj valueForKey:@"customField"]];
        NSDictionary *res = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
        
        [eventShopID addObject:[[res valueForKey:@"BrandId"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    }
    
    for (NSManagedObject *obj in objects) {
        ShopEntity *shopEntity = [ShopEntity article2ShopEntity:obj];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains %@",shopEntity.shopID];
        if ([eventShopID filteredArrayUsingPredicate: predicate].count > 0) {
            shopEntity.hasEvent = YES;
        }
        
        [shopList addObject:shopEntity];
    }
    
    return shopList;
}

+ (NSArray *)getItemArrayWithShopID:(NSString *)shopID {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate mainObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dirID = 9 and display != 1 and customField CONTAINS %@", [NSString stringWithFormat:@"\"BrandId\":\"%@\"",shopID]];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"sortcode" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    //[fetchRequest setFetchLimit:20];
    NSError *error;
    
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray *shopList = [NSMutableArray array];
    
    for (NSManagedObject *obj in objects) {
        ItemEntity *itemEntity = [ItemEntity article2ItemEntity:obj];
        
        NSFetchRequest *shopFetch = [[NSFetchRequest alloc] init];
        NSEntityDescription *shopEntity = [NSEntityDescription entityForName:@"Shop" inManagedObjectContext:context];
        NSPredicate *shopPredicate = [NSPredicate predicateWithFormat:@"shopID = %@", itemEntity.brandID];
        [shopFetch setEntity:shopEntity];
        [shopFetch setPredicate:shopPredicate];
        
        NSArray *shops = [context executeFetchRequest:shopFetch error:&error];
        
        if (shops.count > 0) {
            NSManagedObject *shop = [shops firstObject];
            
            [itemEntity setShopEntity:[ShopEntity article2ShopEntity:shop]];
        }
        
        [shopList addObject:itemEntity];
    }
    return shopList;
}


+ (NSArray *)getEventArrayWithShopID:(NSString *)shopID {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate mainObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dirID = 10 and display != 1 and customField CONTAINS %@", [NSString stringWithFormat:@"\"BrandId\":\"%@\"",shopID]];
    NSLog(@"\"BrandId\":\"%@\"",shopID);
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"sortcode" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    //[fetchRequest setFetchLimit:20];
    NSError *error;
    
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray *shopList = [NSMutableArray array];
    
    for (NSManagedObject *obj in objects) {
        EventEntity *eventEntity = [EventEntity article2EventEntity:obj];
        
        NSFetchRequest *shopFetch = [[NSFetchRequest alloc] init];
        NSEntityDescription *shopEntity = [NSEntityDescription entityForName:@"Shop" inManagedObjectContext:context];
        NSPredicate *shopPredicate = [NSPredicate predicateWithFormat:@"shopID = %@", eventEntity.brandID];
        [shopFetch setEntity:shopEntity];
        [shopFetch setPredicate:shopPredicate];
        
        NSArray *shops = [context executeFetchRequest:shopFetch error:&error];
        
        if (shops.count > 0) {
            NSManagedObject *shop = [shops firstObject];
            eventEntity.shopEntity = [ShopEntity article2ShopEntity:shop];
        }
        
        [shopList addObject:eventEntity];
    }
    
    return shopList;
}

+ (NSArray *)getVideoArrayWithShopID:(NSString *)shopID {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate mainObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dirID = 13 and display != 1 and customField CONTAINS %@", [NSString stringWithFormat:@"\"BrandId\":\"%@\"",shopID]];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"sortcode" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    //[fetchRequest setFetchLimit:20];
    NSError *error;
    
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray *shopList = [NSMutableArray array];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    
    for (NSManagedObject *obj in objects) {
        VideoEntity *videoEntity = [VideoEntity article2VideoEntity:obj];
        
        NSFetchRequest *shopFetch = [[NSFetchRequest alloc] init];
        NSEntityDescription *shopEntity = [NSEntityDescription entityForName:@"Shop" inManagedObjectContext:context];
        NSPredicate *shopPredicate = [NSPredicate predicateWithFormat:@"shopID = %@", videoEntity.brandID];
        [shopFetch setEntity:shopEntity];
        [shopFetch setPredicate:shopPredicate];
        
        NSArray *shops = [context executeFetchRequest:shopFetch error:&error];
        
        if (shops.count > 0) {
            NSManagedObject *shop = [shops firstObject];
            
            [videoEntity setShopEntity:[ShopEntity article2ShopEntity:shop]];
            
        }
        
        [shopList addObject:videoEntity];
    }
    return shopList;
}

+ (ShopEntity *)getShopEntityByID:(NSString *)shopID {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate mainObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Shop" inManagedObjectContext:context];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"sortCode" ascending:YES];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"display != 1 and shopID = %@", shopID];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    ShopEntity *shopEntity;
    
    for (NSManagedObject *obj in objects) {
        shopEntity = [ShopEntity article2ShopEntity:obj];
    }
    
    return shopEntity;
}

#pragma mark - Event View

+ (NSArray *)getEventShopList {
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate mainObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dirID = 10 and display != 1"];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"sortcode" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    //[fetchRequest setFetchLimit:20];
    NSError *error;
    
    NSMutableArray *eventList = [NSMutableArray array];
    
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *obj in objects) {
        EventEntity *eventEntity = [EventEntity article2EventEntity:obj];
        
        NSFetchRequest *shopFetch = [[NSFetchRequest alloc] init];
        NSEntityDescription *shopEntity = [NSEntityDescription entityForName:@"Shop" inManagedObjectContext:context];
        NSPredicate *shopPredicate = [NSPredicate predicateWithFormat:@"shopID = %@", eventEntity.brandID];
        [shopFetch setEntity:shopEntity];
        [shopFetch setPredicate:shopPredicate];
        
        NSArray *shops = [context executeFetchRequest:shopFetch error:&error];
        
        if (shops.count > 0) {
            NSManagedObject *shop = [shops firstObject];
            eventEntity.shopEntity = [ShopEntity article2ShopEntity:shop];
        }
        
        [eventList addObject:eventEntity];
    }
    
    return eventList;
}

+ (NSArray *)getEventMallList {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate mainObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dirID = 11 and display != 1"];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"sortcode" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    //[fetchRequest setFetchLimit:20];
    NSError *error;
    
    NSMutableArray *eventList = [NSMutableArray array];
    
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *obj in objects) {
        EventEntity *eventEntity = [EventEntity article2EventEntity:obj];
        
        if (eventEntity.brandID.length == 0) {
            [eventEntity setEntityArray:nil];
        } else {
            NSMutableArray *eventShopArray = [[NSMutableArray alloc] init];
            
            NSPredicate *shopPredicate = [NSPredicate predicateWithFormat:@"dirID = 10 and display != 0 and id = %@", eventEntity.brandID];
            [fetchRequest setPredicate:shopPredicate];
            [fetchRequest setSortDescriptors:nil];
            NSArray *shops = [context executeFetchRequest:fetchRequest error:&error];
            
            if (shops.count > 0) {
                NSManagedObject *event = [shops firstObject];
                
                EventEntity *eventShopEntity = [EventEntity article2EventEntity:event];
                
                NSFetchRequest *shopFetch = [[NSFetchRequest alloc] init];
                NSEntityDescription *shopEntity = [NSEntityDescription entityForName:@"Shop" inManagedObjectContext:context];
                NSPredicate *shopPredicate = [NSPredicate predicateWithFormat:@"shopID = %@", eventEntity.brandID];
                [shopFetch setEntity:shopEntity];
                [shopFetch setPredicate:shopPredicate];
                
                NSArray *shops = [context executeFetchRequest:shopFetch error:&error];
                
                if (shops.count > 0) {
                    NSManagedObject *shop = [shops firstObject];
                    eventShopEntity.shopEntity = [ShopEntity article2ShopEntity:shop];
                }
                
                [eventShopArray addObject:eventShopEntity];
                
                [eventEntity setEntityArray:eventShopArray];
            }
        }
        
        [eventList addObject:eventEntity];
    }
    
    return eventList;
}

+ (EventEntity *)getEventEntityByID:(NSString *)eventID {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate mainObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id = %@ and display != 1", eventID];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"sortcode" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    //[fetchRequest setFetchLimit:20];
    NSError *error;
    
    EventEntity *eventEntity;
    
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *obj in objects) {
        eventEntity = [EventEntity article2EventEntity:obj];
        
        NSFetchRequest *shopFetch = [[NSFetchRequest alloc] init];
        NSEntityDescription *shopEntity = [NSEntityDescription entityForName:@"Shop" inManagedObjectContext:context];
        NSPredicate *shopPredicate = [NSPredicate predicateWithFormat:@"shopID = %@", eventEntity.brandID];
        [shopFetch setEntity:shopEntity];
        [shopFetch setPredicate:shopPredicate];
        
        NSArray *shops = [context executeFetchRequest:shopFetch error:&error];
        
        if (shops.count > 0) {
            NSManagedObject *shop = [shops firstObject];
            eventEntity.shopEntity = [ShopEntity article2ShopEntity:shop];
        }
        
        if (eventEntity.brandID.length == 0) {
            [eventEntity setEntityArray:nil];
        } else {
            NSMutableArray *eventShopArray = [[NSMutableArray alloc] init];
            
            NSPredicate *shopPredicate = [NSPredicate predicateWithFormat:@"dirID = 10 and display != 0 and id = %@", eventEntity.brandID];
            [fetchRequest setPredicate:shopPredicate];
            [fetchRequest setSortDescriptors:nil];
            NSArray *shops = [context executeFetchRequest:fetchRequest error:&error];
            
            if (shops.count > 0) {
                NSManagedObject *event = [shops firstObject];
                
                EventEntity *eventShopEntity = [EventEntity article2EventEntity:event];
                
                NSFetchRequest *shopFetch = [[NSFetchRequest alloc] init];
                NSEntityDescription *shopEntity = [NSEntityDescription entityForName:@"Shop" inManagedObjectContext:context];
                NSPredicate *shopPredicate = [NSPredicate predicateWithFormat:@"shopID = %@", eventEntity.brandID];
                [shopFetch setEntity:shopEntity];
                [shopFetch setPredicate:shopPredicate];
                
                NSArray *shops = [context executeFetchRequest:shopFetch error:&error];
                
                if (shops.count > 0) {
                    NSManagedObject *shop = [shops firstObject];
                    eventShopEntity.shopEntity = [ShopEntity article2ShopEntity:shop];
                }
                
                [eventShopArray addObject:eventShopEntity];
                
                [eventEntity setEntityArray:eventShopArray];
            }
        }
    }
    
    return eventEntity;
}

#pragma mark - Video View

+ (NSArray *)getVideoShopList {
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate mainObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dirID = 13 and display != 1"];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"createTime" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    //[fetchRequest setFetchLimit:20];
    NSError *error;
    
    NSMutableArray *videoList = [NSMutableArray array];
    
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *obj in objects) {
        VideoEntity *videoEntity = [VideoEntity article2VideoEntity:obj];
        
        NSFetchRequest *shopFetch = [[NSFetchRequest alloc] init];
        NSEntityDescription *shopEntity = [NSEntityDescription entityForName:@"Shop" inManagedObjectContext:context];
        NSPredicate *shopPredicate = [NSPredicate predicateWithFormat:@"shopID = %@", videoEntity.brandID];
        [shopFetch setEntity:shopEntity];
        [shopFetch setPredicate:shopPredicate];
        
        NSArray *shops = [context executeFetchRequest:shopFetch error:&error];
        
        if (shops.count > 0) {
            NSManagedObject *shop = [shops firstObject];
            
            [videoEntity setShopEntity:[ShopEntity article2ShopEntity:shop]];
            
        }
        
        [videoList addObject:videoEntity];
    }
    
    return videoList;
}

+ (NSArray *)getVideoMallList {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate mainObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dirID = 12 and display != 1"];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"sortcode" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    //[fetchRequest setFetchLimit:20];
    NSError *error;
    
    NSMutableArray *videoList = [NSMutableArray array];
    
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *obj in objects) {
        VideoEntity *videoEntity = [VideoEntity article2VideoEntity:obj];
        
        [videoList addObject:videoEntity];
    }
    
    return videoList;
}

#pragma mark - Item View

+ (NSArray *)getItemList {
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate mainObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dirID = 9 and display != 1"];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"sortcode" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    //[fetchRequest setFetchLimit:20];
    NSError *error;
    
    NSMutableArray *eventList = [NSMutableArray array];
    
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *obj in objects) {
        ItemEntity *itemEntity = [ItemEntity article2ItemEntity:obj];
        
        NSFetchRequest *shopFetch = [[NSFetchRequest alloc] init];
        NSEntityDescription *shopEntity = [NSEntityDescription entityForName:@"Shop" inManagedObjectContext:context];
        NSPredicate *shopPredicate = [NSPredicate predicateWithFormat:@"shopID = %@", itemEntity.brandID];
        [shopFetch setEntity:shopEntity];
        [shopFetch setPredicate:shopPredicate];
        
        NSArray *shops = [context executeFetchRequest:shopFetch error:&error];
        
        if (shops.count > 0) {
            NSManagedObject *shop = [shops firstObject];
            
            [itemEntity setShopEntity:[ShopEntity article2ShopEntity:shop]];
            
        }
        
        [eventList addObject:itemEntity];
    }
    
    return eventList;
}

#pragma mark - Service View

+ (NSString *)getServiceTraffic {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate mainObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dirID = 15 and display != 1"];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"sortcode" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    //[fetchRequest setFetchLimit:20];
    NSError *error;
    
    
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    //NSLog(@"%@", objects);
 
    
    for (NSManagedObject *obj in objects) {
        
        if ([obj valueForKey:@"customField"]) {
//            NSLog(@"%@", [obj valueForKey:@"customField"]);
//            NSLog(@"%@", [obj valueForKey:@"content"]);
        }
        
        return [obj valueForKey:@"content"];
    }
    
    return nil;
}

+ (NSString *)getServiceInfo {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate mainObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dirID = 14 and display != 1"];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"sortcode" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    //[fetchRequest setFetchLimit:20];
    NSError *error;
    
    
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    
    for (NSManagedObject *obj in objects) {
        
        if ([obj valueForKey:@"customField"]) {
//            NSLog(@"%@", [obj valueForKey:@"files"]);
//            NSLog(@"%@", [obj valueForKey:@"content"]);
        }
        
        return [obj valueForKey:@"content"];
    }
    
    return nil;
}

+ (NSString *)getServiceQA {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate mainObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dirID = 16"];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"sortcode" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    //[fetchRequest setFetchLimit:20];
    NSError *error;
    
    
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    
    for (NSManagedObject *obj in objects) {
        
        if ([obj valueForKey:@"customField"]) {
            //            NSLog(@"%@", [obj valueForKey:@"files"]);
            //            NSLog(@"%@", [obj valueForKey:@"content"]);
        }
        
        return [obj valueForKey:@"content"];
    }
    
    return nil;
}

#pragma mark - Food View

+ (NSArray *)getFoodList {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate mainObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Shop" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tableSet != nil"];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"sortCode" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray *shopList = [NSMutableArray array];
    
    for (NSManagedObject *obj in objects) {
        ShopEntity *shopEntity = [ShopEntity article2ShopEntity:obj];
        if (shopEntity.tableSet) {
            [shopList addObject:shopEntity];
        }
    }
    
    return shopList;
}

@end
