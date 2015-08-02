//
//  AppDelegate.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/16.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ParentViewController.h"
#import "WXApi.h"
#import "GexinSdk.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, GexinSdkDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectContext *mainContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) UINavigationController *navController;  

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (NSManagedObjectContext *)mainObjectContext;

@end

