//
//  CoreDataController.m
//  FinalProject
//
//  Created by Дмитрий Рощин on 27/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//


#import "CoreDataService.h"


@interface CoreDataService()

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@end


@implementation CoreDataService

#pragma mark - Singleton

+ (instancetype)sharedInstance
{
    static CoreDataService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CoreDataService alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Core Data stack

- (instancetype)init
{
    self = [super init];
    @synchronized (self) {
        if (!_persistentContainer)
        {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"FinalProject"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
        if (!_managedObjectContext)
        {
            _managedObjectContext = _persistentContainer.viewContext;
        }
    }
    
    return self;
}

#pragma mark - Core Data Saving support

- (void)saveContext
{
    NSError *error = nil;
    if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
    }
}

#pragma mark - Core Data operations with persistent store

- (NSInteger)countItemsSavedForEntityName:(NSString *)entityName withPredicate:(nullable NSPredicate *)predicate
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityName];
    fetchRequest.predicate = predicate;
    NSError *error = nil;
    NSArray *fetchedResults = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedResults)
    {
        return fetchedResults.count;
    }
    else
    {
        NSLog(@"Unable to proceed fetchRequest to CoreData storage");
        return -1;
    }
}


- (NSArray *)loadItemsFromCoreDataForEntityName:(NSString *)entityName
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityName];
    NSError *error = nil;
    NSArray *fetchedResults = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedResults)
    {
        return fetchedResults;
    }
    else
    {
        NSLog(@"Unable to proceed fetchRequest to CoreData storage");
        return nil;
    }
}

- (void)saveToCoreDataStorageForEntityName:(NSString *)entityName symbol:(NSString *)symbol lastUpdated:(NSString *)lastUpdated
{
    Stock *stock = [NSEntityDescription insertNewObjectForEntityForName:@"Stock" inManagedObjectContext:_managedObjectContext];
    stock.symbol = symbol;
    stock.lastUpdated = lastUpdated;
    [self saveContext];
}

- (void)deleteFromCoreDataStorageForEntityName:(NSString *)entityName predicate:(NSPredicate *)predicate
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityName];
    fetchRequest.predicate = predicate;
    NSError *error = nil;
    NSArray *fetchedResults = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedResults)
    {
        for (Stock *i in fetchedResults)
        {
            [_managedObjectContext deleteObject:i];
        }
    }
    else
    {
        NSLog(@"Error fetching");
    }
    [self saveContext];
}

@end
