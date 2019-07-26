//
//  Network Service.h
//  finalProject
//
//  Created by Дмитрий Рощин on 14/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NetworkServiceDelegate.h"
#import "APIDictionaryKeysSearch.h"
#import "APIDictionaryKeysQuote.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkService : NSObject <NSURLSessionDelegate>

@property (nonatomic, weak) id<NetworkServiceDelegate> delegate;

- (void)searchData:(NSString *)searchString;
- (void)updateIntradayData:(NSString *)symbol;
+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
