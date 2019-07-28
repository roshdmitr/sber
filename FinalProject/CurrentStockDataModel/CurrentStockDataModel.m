//
//  CurrentStockDataModel.m
//  FinalProject
//
//  Created by Дмитрий Рощин on 28/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

#import "CurrentStockDataModel.h"

@interface CurrentStockDataModel ()



@end

@implementation CurrentStockDataModel

#pragma mark Singleton method

+ (instancetype)sharedInstance
{
    static CurrentStockDataModel *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CurrentStockDataModel alloc] init];
    });
    return sharedInstance;
}


- (void)saveSearchResults:(NSDictionary *)searchResults
{
    if (searchResults[APIDictionaryKeyMain] != nil)
    {
        NSArray *resultsAsAnArray = [[NSArray alloc] initWithArray:searchResults[APIDictionaryKeyMain]];
        _searchResults = resultsAsAnArray;
        if ([self.delegate respondsToSelector:@selector(updateTableView)])
        {
            [self.delegate updateTableView];
        }
        else
        {
            NSLog(@"updateTableView wasn't implemented!)");
        }
    }
    else
    {
        NSLog(@"Search results can't be parsed");
    }
    
}

- (void)saveIntradayData:(nonnull NSDictionary *)intradayData
{
    if (intradayData[APIDictionaryKeyTimeSeries] != nil)
    {
        _lastUpdated = [NSString stringWithString:intradayData[APIDictionaryKeyMetaData][APIDictionaryKeyLastRefreshed]];
        _intradayData = _intradayData = [NSDictionary dictionaryWithDictionary:intradayData[APIDictionaryKeyTimeSeries][_lastUpdated]];
        if ([self.delegate respondsToSelector:@selector(updateView)])
        {
            [self.delegate updateView];
        }
        else
        {
            NSLog(@"updateView wasn't implemented!");
        }
    }
    else
    {
        NSLog(@"Intraday data can't be parsed)");
    }
}

- (void)saveNumberOfItemsInFavourites
{
    _numberOfItemsInFavourites = [[CoreDataService sharedInstance] countItemsSavedForEntityName:@"Stock"];
}

- (void)saveFavourites
{
    _favourites = [[CoreDataService sharedInstance] loadItemsFromCoreDataForEntityName:@"Stock"];
}

@end
