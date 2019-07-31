//
//  CoreDataServiceTests.m
//  FinalProjectTests
//
//  Created by Дмитрий Рощин on 30/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CoreData/CoreData.h>
#import "CoreDataService.h"
#import "OCMock/OCMock.h"

@interface CoreDataServiceTests : XCTestCase

@property (nonatomic, strong) NSManagedObjectContext *context;

@end

@implementation CoreDataServiceTests

- (void)setUp
{
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:@[NSBundle.mainBundle]];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    [coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:nil];
    _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _context.persistentStoreCoordinator = coordinator;
    [CoreDataService sharedInstance].managedObjectContext = _context;
}

- (void)tearDown
{
    
}


#pragma mark - Singleton

- (void)testSingleton
{
    XCTAssertNotNil([CoreDataService sharedInstance]);
}


#pragma mark - saveContext

- (void)testCountItemsSavedForEntityName
{
    Stock *stock1 = [NSEntityDescription insertNewObjectForEntityForName:@"Stock" inManagedObjectContext:_context];
    stock1.symbol = @"test1";
    stock1.lastUpdated = @"test1";
    Stock *stock2 = [NSEntityDescription insertNewObjectForEntityForName:@"Stock" inManagedObjectContext:_context];
    stock2.symbol = @"test2";
    stock2.lastUpdated = @"test2";
    [[CoreDataService sharedInstance] saveContext];
    XCTAssertEqual([[CoreDataService sharedInstance] countItemsSavedForEntityName:@"Stock" withPredicate:nil], 2);
    
}


#pragma mark - loadItemsFromCoreDataForEntityName

- (void)testLoadItemsFromCoreDataForEntityName
{
    Stock *stock1 = [NSEntityDescription insertNewObjectForEntityForName:@"Stock" inManagedObjectContext:_context];
    stock1.symbol = @"test1";
    stock1.lastUpdated = @"test1";
    Stock *stock2 = [NSEntityDescription insertNewObjectForEntityForName:@"Stock" inManagedObjectContext:_context];
    stock2.symbol = @"test2";
    stock2.lastUpdated = @"test2";
    [[CoreDataService sharedInstance] saveContext];
    NSArray *array = @[stock1, stock2];
    XCTAssertEqual(array.count, [[CoreDataService sharedInstance] loadItemsFromCoreDataForEntityName:@"Stock"].count);
}


#pragma mark - saveToCoreDataStorageForEntityName

- (void)testSaveToCoreDataStorageForEntityName
{
    [[CoreDataService sharedInstance] saveToCoreDataStorageForEntityName:@"Stock" symbol:@"test" lastUpdated:@"test"];
    [[CoreDataService sharedInstance] saveContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Stock"];
    NSError *error = nil;
    NSArray *fetchedResults = [_context executeFetchRequest:fetchRequest error:&error];
    XCTAssertEqual(fetchedResults.count, 1);
}


#pragma mark - deleteFromCoreDataStorageForEntityName

- (void)testDeleteFromCoreDataStorageForEntityName
{
    Stock *stock = [NSEntityDescription insertNewObjectForEntityForName:@"Stock" inManagedObjectContext:_context];
    stock.symbol = @"test";
    stock.lastUpdated = @"test";
    [[CoreDataService sharedInstance] saveContext];
    [[CoreDataService sharedInstance] deleteFromCoreDataStorageForEntityName:@"Stock" predicate:[NSPredicate predicateWithFormat:@"symbol == %@", @"test"]];
    XCTAssertEqual([[CoreDataService sharedInstance] countItemsSavedForEntityName:@"Stock" withPredicate:nil], 0);
}



@end
