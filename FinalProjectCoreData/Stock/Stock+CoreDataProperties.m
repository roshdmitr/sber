//
//  Stock+CoreDataProperties.m
//  FinalProject
//
//  Created by Дмитрий Рощин on 27/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//
//

#import "Stock+CoreDataProperties.h"

@implementation Stock (CoreDataProperties)

+ (NSFetchRequest<Stock *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Stock"];
}

@dynamic symbol;
@dynamic lastUpdated;

@end
