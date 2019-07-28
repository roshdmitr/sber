//
//  CoreDataController.m
//  FinalProject
//
//  Created by Дмитрий Рощин on 27/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

#import "CoreDataController.h"

@interface CoreDataController()

@end

@implementation CoreDataController

+ (instancetype)sharedInstance
{
    static CoreDataController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CoreDataController alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Core Data stack

- (instancetype)init
{
    self = [super init];
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"FinalProject"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return self;
}

#pragma mark - Core Data Saving support

- (void)saveContext
{
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


@end
