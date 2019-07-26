//
//  AppDelegate.h
//  finalProject
//
//  Created by Дмитрий Рощин on 13/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "SearchViewController.h"
#import "FavouritesViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) SearchViewController *searchViewController;
@property (nonatomic, strong) FavouritesViewController *favouritesViewController;
@property (nonatomic, strong) UINavigationController *searchNavigationController;
@property (nonatomic, strong) UINavigationController *favouritesNavigationController;
@property (nonatomic, strong) UITabBarController *tabBarController;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

