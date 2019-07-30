//
//  CoreDataController.h
//  FinalProject
//
//  Created by Дмитрий Рощин on 27/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Stock+CoreDataProperties.h"


NS_ASSUME_NONNULL_BEGIN


@interface CoreDataService : NSObject

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

+ (instancetype)sharedInstance;
- (void)saveContext;
- (NSInteger)countItemsSavedForEntityName:(NSString *)entityName withPredicate:(nullable NSPredicate *)predicate;
- (NSArray *)loadItemsFromCoreDataForEntityName:(NSString *)entityName;
- (void)saveToCoreDataStorageForEntityName:(NSString *)entityName symbol:(NSString *)symbol lastUpdated:(NSString *)lastUpdated;
- (void)deleteFromCoreDataStorageForEntityName:(NSString *)entityName predicate:(NSPredicate *)predicate;

@end

NS_ASSUME_NONNULL_END
