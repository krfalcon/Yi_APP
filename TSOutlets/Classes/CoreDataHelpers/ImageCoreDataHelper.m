//
//  ImageCoreDataHelper.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/26.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ImageCoreDataHelper.h"
#import "AppDelegate.h"

@implementation ImageCoreDataHelper

+ (BOOL)addImage:(NSData *)image WithUrl:(NSString *)url {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Image" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url = %@", url];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *images = [context executeFetchRequest:fetchRequest error:&error];
    if (images.count > 0) {
        entity = [images firstObject];
        
        [entity setValue:image forKey:@"image"];
    } else {
        entity = [NSEntityDescription insertNewObjectForEntityForName:@"Image" inManagedObjectContext:context];
        [entity setValue:image forKey:@"image"];
        [entity setValue:url forKey:@"url"];
    }
    
    if (![context save:&error]) {
        return NO;
    }
    //NSLog(@"%@", [entity valueForKey:@"url"]);
    return YES;
}

+ (NSDictionary *)getAllImages {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Image" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSArray *images = [context executeFetchRequest:fetchRequest error:&error];
    if (images.count > 0) {
        for (NSManagedObject *image in images) {
            [dic setObject:[image valueForKey:@"image"] forKey:[image valueForKey:@"url"]];
        }
    }
    
    //NSLog(@"%@", [entity valueForKey:@"url"]);
    return dic;
}

+ (NSData *)getOneImageByUrl:(NSString *)url {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Image" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url = %@", url];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *images = [context executeFetchRequest:fetchRequest error:&error];
    if (images.count > 0) {
        return [[images firstObject] valueForKey:@"image"];
    }
    
    //NSLog(@"%@", [entity valueForKey:@"url"]);
    return nil;
}

@end
