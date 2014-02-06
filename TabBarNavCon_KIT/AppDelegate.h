//
//  AppDelegate.h
//  DrPocket
//
//  Created by frederick forte on 11/22/13.
//  Copyright (c) 2013 frederick forte. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VC_NAV1.h"
#import "VC_NAV2.h"
#import "Utility.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic,retain) IBOutlet  UINavigationController* navController;
@property (nonatomic,retain) IBOutlet  UINavigationController* navController2;

@property (nonatomic) int layoutIsPortrait;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
