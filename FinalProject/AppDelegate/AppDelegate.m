//
//  AppDelegate.m
//  finalProject
//
//  Created by Дмитрий Рощин on 13/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (nonatomic, strong) SearchViewController *searchViewController;
@property (nonatomic, strong) FavouritesViewController *favouritesViewController;
@property (nonatomic, strong) UINavigationController *searchNavigationController;
@property (nonatomic, strong) UINavigationController *favouritesNavigationController;
@property (nonatomic, strong) UITabBarController *tabBarController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    _searchViewController = [[SearchViewController alloc] init];
    _searchViewController.view.frame = _window.frame;
    _favouritesViewController = [[FavouritesViewController alloc] init];
    _favouritesViewController.view.frame = _window.frame;
    
    _tabBarController = [[UITabBarController alloc] init];
    
    _searchNavigationController = [[UINavigationController alloc] initWithRootViewController:_searchViewController];
    _searchViewController.view.frame = _window.frame;
    _favouritesNavigationController = [[UINavigationController alloc] initWithRootViewController:_favouritesViewController];
    _favouritesViewController.view.frame = _window.frame;
    
    
    [_tabBarController setViewControllers:[NSArray arrayWithObjects:_searchNavigationController, _favouritesNavigationController, nil]];
    
    _searchViewController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:0];
    _favouritesViewController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:1];
    
    _window.rootViewController = _tabBarController;
    [_window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [[CoreDataController sharedInstance] saveContext];
}

@end