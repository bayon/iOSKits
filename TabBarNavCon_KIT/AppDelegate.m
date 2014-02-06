//
//  AppDelegate.m
//  DrPocket
//
//  Created by frederick forte on 11/22/13.
//  Copyright (c) 2013 frederick forte. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

@synthesize tabBarController,navController,navController2,layoutIsPortrait;



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

#pragma mark -  Tab Bar With Navigation Controller
// NavigationController inside a TabBarController: straight from apple
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.tabBarController = [[UITabBarController alloc] init];
    //Create the VC you want to be the Rootview for the NavigationCOntroller
    VC_NAV1 *viewController1 = [[VC_NAV1 alloc] initWithNibName:@"VC_NAV1" bundle:nil];
    navController = [[UINavigationController alloc]
                     initWithRootViewController:viewController1];
    //create the normal tab views
    VC_NAV2 *viewController2 = [[VC_NAV2 alloc] initWithNibName:@"VC_NAV2" bundle:nil];
    navController2 = [[UINavigationController alloc]
                      initWithRootViewController:viewController2];
    
    // VC3 *viewController3 = [[VC3 alloc] initWithNibName:@"VC3" bundle:nil];
    //insert NavigationCOntroller and Normal Tab Views into the tab bar controller
    self.tabBarController.viewControllers = [NSArray arrayWithObjects: navController, navController2,  nil];
    //set the WINDOWS rootview controller to the tab bar controller
    self.window.rootViewController = self.tabBarController;
    [self.tabBarController setSelectedIndex:0];
    [self.window makeKeyAndVisible];
    
    //nav bar customize
    //navController.navigationBar.barTintColor = [UIColor lightGrayColor];
    navController.navigationBar.tintColor = [UIColor lightGrayColor];
    navController.navigationBar.translucent = NO;
    
    //navController2.navigationBar.barTintColor = [UIColor lightGrayColor];
    navController2.navigationBar.tintColor = [UIColor lightGrayColor];
    navController2.navigationBar.translucent = NO;
    
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:11.0],NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    
    //TAB BAR CUSTOMIZATION
    [[UITabBar appearance]  setBarTintColor:[UIColor blackColor]];
    [self tabBarCustomizations];
    //STATUS BAR
    [self setStatusBarBackground];
    //detect device orientation change
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectOrientation) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    
    return YES;
}
//tabbar: tabBarCustomizations
-(void)tabBarCustomizations{
    
    
     Utility *utility = [Utility sharedUtility];
    //Utility *sharedUtility = [Utility sharedUtility];
    
    // Assign tab bar item with titles
    tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    //[tabBar setBackgroundColor: [UIColor blueColor]];
    [tabBar setAlpha:1];
    
    UITabBarItem * tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    
    //Button Item Properties
    NSDictionary *tBarItems_norm = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor blackColor], UITextAttributeTextColor,
                                    [UIColor darkGrayColor], UITextAttributeTextShadowColor,
                                    [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset,
                                    utility.mainFontBig, UITextAttributeFont,
                                    nil];
    
    NSDictionary *tBarItems_sel = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIColor whiteColor], UITextAttributeTextColor,
                                   [UIColor darkGrayColor], UITextAttributeTextShadowColor,
                                   [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset,
                                   utility.mainFontBig, UITextAttributeFont,
                                   nil];
    
    // Button States
    [tabBarItem1 setTitleTextAttributes: tBarItems_norm forState:UIControlStateNormal];
    [tabBarItem2 setTitleTextAttributes: tBarItems_norm forState:UIControlStateNormal];
    [tabBarItem1 setTitleTextAttributes: tBarItems_sel forState:UIControlStateSelected];
    [tabBarItem2 setTitleTextAttributes: tBarItems_sel forState:UIControlStateSelected];
    //Button Text
    [tabBarItem1 setTitle:@"VC1"];
    [tabBarItem2 setTitle:@"VC2"];
    tabBar.frame = CGRectMake(0, self.window.rootViewController.view.bounds.size.height - 58, self.window.rootViewController.view.bounds.size.width,58 );
    
    //Navigation Bar
    
    // NavigationController Background Image
    
    if(layoutIsPortrait == 1){
        [navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"clipboard_head_44X320.png"] forBarMetrics:UIBarMetricsDefault];
        [navController2.navigationBar setBackgroundImage:[UIImage imageNamed:@"clipboard_head_44X320.png"] forBarMetrics:UIBarMetricsDefault];
    }else{
        [navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"clipboard_head_44X480.png"] forBarMetrics:UIBarMetricsDefault];
        [navController2.navigationBar setBackgroundImage:[UIImage imageNamed:@"clipboard_head_44X480.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
    
}

-(void)setStatusBarBackground{
    
    //BACKGROUND IMAGE
    UIImageView *statusBarBackgroundColorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    statusBarBackgroundColorImage.backgroundColor = [UIColor blueColor];
    [self.window.rootViewController.view  addSubview:statusBarBackgroundColorImage];
    statusBarBackgroundColorImage.frame = CGRectMake(0, 0, self.window.rootViewController.view.bounds.size.width, 20);
    [self.window.rootViewController.view  bringSubviewToFront: statusBarBackgroundColorImage];
    [self.window.rootViewController setNeedsStatusBarAppearanceUpdate];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    //[self.window.rootViewController setNeedsStatusBarAppearanceUpdate];
    return UIStatusBarStyleLightContent;
}

-(void) detectOrientation
{
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft)
    {
        //Set up left
        layoutIsPortrait = 0;
        [self setStatusBarBackground];
        [self tabBarCustomizations];
    } else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)
    {
        //Set up Right
        layoutIsPortrait = 0;
        [self setStatusBarBackground];
        [self tabBarCustomizations];
    } else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait  )
    {
        //portrait
        layoutIsPortrait = 1;
        [self setStatusBarBackground];
        [self tabBarCustomizations];
    }else if([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown){
        //portrait upside down
        layoutIsPortrait = 1;
        [self setStatusBarBackground];
        [self tabBarCustomizations];
    }
}

#pragma mark -



- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DrPocket" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"DrPocket.sqlite"];
    
    
    
    //CORE DATA MIGRATION CLAUSE
NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES],NSInferMappingModelAutomaticallyOption, nil];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
