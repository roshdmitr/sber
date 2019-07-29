//
//  CurrentStockDataModel.h
//  FinalProject
//
//  Created by Дмитрий Рощин on 28/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "NetworkServiceDelegate.h"
#import "CurrentStockDataModelDelegate.h"
#import "APIDictionaryKeysSearch.h"
#import "APIDictionaryKeysQuote.h"
#import "CoreDataService.h"


NS_ASSUME_NONNULL_BEGIN


@interface CurrentStockDataModel : NSObject <NetworkServiceDelegate>

+ (instancetype)sharedInstance;

@property (nonatomic, weak) id<CurrentStockDataModelDelegate> delegate;

@property (nonatomic, strong, nullable) NSArray<NSDictionary<NSString *, NSString *> *> *searchResults;
@property (nonatomic, strong, nullable) NSDictionary<NSString *, NSString *> *intradayData;
@property (nonatomic, strong) NSString *lastUpdated;

@end

NS_ASSUME_NONNULL_END
