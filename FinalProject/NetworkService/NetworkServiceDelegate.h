//
//  NetworkServiceDelegate.h
//  FinalProject
//
//  Created by Дмитрий Рощин on 24/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NetworkServiceDelegate <NSObject>

@optional

- (void)saveSearchResults:(NSArray *)searchResults;
- (void)saveIntradayData:(NSDictionary *)intradayData :(NSString *)lastUpdated;

@end

NS_ASSUME_NONNULL_END
