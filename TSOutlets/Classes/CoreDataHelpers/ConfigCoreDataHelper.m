//
//  ConfigCoreDataHelper.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/27.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ConfigCoreDataHelper.h"

#import "AppDelegate.h"

@implementation ConfigCoreDataHelper

+ (NSString *)getUpdateDate {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Config" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    //NSLog(@"%d",objects.count);
    
    if (objects == nil || [objects count] == 0) {
        return nil;
    } else {
        return [[objects lastObject] valueForKey:@"updateDate"];
    }
    
    return nil;
}

+ (BOOL)setUpdateDate:(NSString *)datetime {
    if (!datetime || [datetime isEqualToString:@"(null)"]) { return NO; }
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Config" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    //NSLog(@"%d",objects.count);
    
//    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    if (objects == nil || [objects count] == 0) {
        entity = [NSEntityDescription insertNewObjectForEntityForName:@"Config" inManagedObjectContext:context];
        [entity setValue:datetime forKey:@"updateDate"];
    } else {
        [[objects lastObject] setValue:datetime forKey:@"updateDate"];
    }
    
    if (![context save:&error]) {
        return NO;
    }
    
    return YES;
}

+ (BOOL)checkAppGuideSign:(NSString *)guideSign {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Config" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    BOOL    res = YES;
    NSError *error;
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    if (objects == nil || [objects count] == 0) {
        entity = [NSEntityDescription insertNewObjectForEntityForName:@"Config" inManagedObjectContext:context];
        [entity setValue:guideSign forKey:@"guideSign"];
        res = NO;
    } else {
        if ([[[objects firstObject] valueForKey:@"guideSign"] isEqualToString:guideSign]) {
            res = YES;
        } else {
            res = NO;
        }
        
        [[objects lastObject] setValue:guideSign forKey:@"guideSign"];
    }
    
    [context save:&error];
    
    return res;
}

@end
