//
//  CurrentStockDataModel.h
//  FinalProject
//
//  Created by Дмитрий Рощин on 28/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkServiceDelegate.h"
#import "APIDictionaryKeysSearch.h"
#import "APIDictionaryKeysQuote.h"
#import "CoreDataService.h"
#import "CurrentStockDataModelDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface CurrentStockDataModel : NSObject <NetworkServiceDelegate>

+ (instancetype)sharedInstance;

@property (nonatomic, weak) id<CurrentStockDataModelDelegate> delegate;

@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic, strong) NSDictionary *intradayData;
@property (nonatomic, strong) NSString *lastUpdated;
@property (nonatomic, assign) NSInteger numberOfItemsInFavourites;
@property (nonatomic, strong) NSArray *favourites;


@end

NS_ASSUME_NONNULL_END
