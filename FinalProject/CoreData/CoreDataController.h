//
//  CoreDataController.h
//  FinalProject
//
//  Created by Дмитрий Рощин on 27/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataController : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
