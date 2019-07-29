//
//  NetworkServiceDelegate.h
//  FinalProject
//
//  Created by Дмитрий Рощин on 29/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NetworkServiceDelegate <NSObject>

@required

- (void)saveSearchResults:(NSDictionary *)searchResults;
- (void)saveIntradayData:(NSDictionary *)intradayData;

@end

NS_ASSUME_NONNULL_END
