//
//  MessageCoreDataHelper.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/9.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "MessageCoreDataHelper.h"
#import "AppDelegate.h"

#import "FeedbackEntity.h"
#import "MessageEntity.h"

@implementation MessageCoreDataHelper

+ (BOOL)saveFeedback:(NSArray *)array {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Feedback" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    
    for (NSManagedObject *object in objects) {
        [context deleteObject:object];
    }
    
    for (FeedbackEntity *ety in array) {
        entity = [NSEntityDescription insertNewObjectForEntityForName:@"Feedback" inManagedObjectContext:context];
        
        [entity setValue:[NSString stringWithFormat:@"%@", ety.feedbackID]     forKey:@"feedbackID"];
        [entity setValue:ety.question       forKey:@"content"];
        [entity setValue:ety.questionTime   forKey:@"date"];
        [entity setValue:ety.reply          forKey:@"reply"];
        [entity setValue:ety.replyTime      forKey:@"replyDate"];
    }
    
    if (![context save:&error]) {
        return NO;
    }
    
    return YES;
}

+ (NSArray *)getFeedback {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Feedback" inManagedObjectContext:context];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray* resArray = [[NSMutableArray alloc] init];
    
    for (NSManagedObject *object in objects) {
        [context deleteObject:object];
        
        FeedbackEntity *feedbackEntity = [[FeedbackEntity alloc] init];
        feedbackEntity.feedbackID       = [object valueForKey:@"feedbackID"];
        feedbackEntity.question         = [object valueForKey:@"content"];
        feedbackEntity.questionTime     = [object valueForKey:@"date"];
        feedbackEntity.reply            = [[NSString stringWithFormat:@"%@", [object valueForKey:@"reply"]] isEqualToString:@"<null>"] ? nil : [object valueForKey:@"reply"];
        feedbackEntity.replyTime        = [[NSString stringWithFormat:@"%@", [object valueForKey:@"replyDate"]] isEqualToString:@"<null>"] ? nil : [object valueForKey:@"replyDate"];
        
        [resArray addObject:feedbackEntity];
    }
    
    return resArray;
}

+ (BOOL)saveMessage:(NSArray *)array {
    if (array.count == 0) { return YES; }
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Message" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *object in objects) {
        [context deleteObject:object];
    }
    
    for (MessageEntity *ety in array) {
        NSEntityDescription *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:context];
        
        [entity setValue:ety.messageID  forKey:@"messageID"];
        [entity setValue:![ety.content isMemberOfClass:[NSNull class]] ? ety.content : nil    forKey:@"content"];
        [entity setValue:ety.date       forKey:@"date"];
        [entity setValue:![ety.point isMemberOfClass:[NSNull class]]  ? ety.point : nil      forKey:@"point"];
        [entity setValue:ety.type       forKey:@"type"];
    }
    
    if (![context save:&error]) {
        NSLog(@"%@", error);
        return NO;
    }
    
    return YES;
}

+ (NSArray *)getMessage {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Message" inManagedObjectContext:context];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray* resArray = [[NSMutableArray alloc] init];
    
    for (NSManagedObject *object in objects) {
        
        MessageEntity *messageEntity    = [[MessageEntity alloc] init];
        messageEntity.messageID         = [object valueForKey:@"messageID"];
        messageEntity.date              = [object valueForKey:@"date"];
        messageEntity.content           = [object valueForKey:@"content"];
        messageEntity.point             = [object valueForKey:@"point"];
        messageEntity.type              = [object valueForKey:@"type"];
        
        [resArray addObject:messageEntity];
    }
    
    return resArray;
}

@end
