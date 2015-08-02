//
//  BrandCoreDataHelper.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/9.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "BrandCoreDataHelper.h"
#import "AppDelegate.h"

@implementation BrandCoreDataHelper

+ (ShopEntity *)setFavoriteBrandWithBrandID:(ShopEntity *)brand {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate mainObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Shop" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"shopID = %@ ", brand.shopID];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    //[fetchRequest setFetchLimit:20];
    NSError *error;
    
    
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    if (objects == nil || [objects count] == 0) {
        return nil;
    } else {
        if (brand.hasCollected) {
            [[objects firstObject] setValue:nil forKey:@"favorite"];
        } else {
            [[objects firstObject] setValue:@"1" forKey:@"favorite"];
        }
        [[objects firstObject] setValue:nil forKey:@"favoriteSync"];
        brand.hasCollected = !brand.hasCollected;
    }
    
    if (![context save:&error]) {
        return nil;
    }
    
    return brand;
}

+ (NSString *)checkFavoriteSync {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate mainObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Shop" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"favoriteSync = nil"];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    //[fetchRequest setFetchLimit:20];
    NSError *error;
    
    NSString *brandIDs = [[NSString alloc] init];
    
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    if (objects == nil || [objects count] == 0) {
        return nil;
    } else {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"favorite != nil"];
        [fetchRequest setPredicate:predicate];
        objects = [context executeFetchRequest:fetchRequest error:&error];
        
        for (NSManagedObject *obj in objects) {
            brandIDs = [brandIDs stringByAppendingString:[obj valueForKey:@"shopID"]];
            brandIDs = [brandIDs stringByAppendingString:@","];
        }
    }
    
    if (![context save:&error]) {
        return nil;
    }
    if (brandIDs.length > 0) {
        brandIDs = [brandIDs substringToIndex:brandIDs.length -1];
    } else {
        return @"";
    }
    
    return brandIDs;
}

+ (BOOL)syncFavorite {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate mainObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Shop" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"favoriteSync = nil"];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    //[fetchRequest setFetchLimit:20];
    NSError *error;
    
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    if (objects == nil || [objects count] == 0) {
        return YES;
    } else {
        for (NSManagedObject *obj in objects) {
            [obj setValue:@"1" forKey:@"favoriteSync"];
        }
    }
    
    if (![context save:&error]) {
        return NO;
    }
    
    return YES;
}

+ (BOOL)clearFavorite {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate mainObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Shop" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    if (objects == nil || [objects count] == 0) {
        return YES;
    } else {
        for (NSManagedObject *obj in objects) {
            [obj setValue:nil forKey:@"favorite"];
        }
    }
    
    if (![context save:&error]) {
        return NO;
    }
    
    return YES;
}

+ (BOOL)setFavorite:(NSArray *)array {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate mainObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Shop" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    //[fetchRequest setFetchLimit:20];
    NSError *error;
    
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    
    if (objects == nil || [objects count] == 0) {
        return YES;
    } else {
        for (NSManagedObject *obj in objects) {
            if ([array indexOfObject:[NSNumber numberWithLong:[[obj valueForKey:@"shopID"] intValue]]] != NSNotFound)
            {
                [obj setValue:@"1" forKey:@"favoriteSync"];
                [obj setValue:@"1" forKey:@"favorite"];
            }
        }
    }
    
    if (![context save:&error]) {
        return NO;
    }
    
    return YES;
}

@end
