//
//  LogCoreDataHelper.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/3.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "LogCoreDataHelper.h"
#import "AppDelegate.h"

@implementation LogCoreDataHelper

+ (NSString *)addLogRecordWithModule:(NSString *)module {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Log" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *date = [df stringFromDate:[NSDate date]];
    
    [entity setValue:date forKey:@"date"];
    [entity setValue:module forKey:@"operation"];
    
    if (![context save:&error]) {
        return @"";
    }
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:[NSString stringWithFormat:@"%@ ~~ %@", date, module]];
    
    return [NSString stringWithFormat:@"%@|%@", date, module];
}

+ (NSArray *)getLogRecordArray {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Log" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *resArray = [[NSMutableArray alloc] init];
    
    
    if (objects == nil || [objects count] == 0) {
        return nil;
    } else {
        for (NSManagedObject *object in objects) {
            [resArray addObject:@[[object valueForKey:@"date"], [object valueForKey:@"operation"]]];
        }
    }
    
    return resArray;
}

+ (BOOL)clearLogRecord {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Log" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    if (objects == nil || [objects count] == 0) {
        return YES;
    } else {
        for (NSManagedObject *object in objects) {
            [context deleteObject:object];
        }
    }
    
    if (![context save:&error]) {
        return NO;
    }
    
    return YES;
}

@end
