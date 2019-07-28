//
//  Stock+CoreDataProperties.h
//  FinalProject
//
//  Created by Дмитрий Рощин on 27/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//
//

#import "Stock+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Stock (CoreDataProperties)

+ (NSFetchRequest<Stock *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *symbol;
@property (nullable, nonatomic, copy) NSString *lastUpdated;

@end

NS_ASSUME_NONNULL_END
