//
//  Network Service.m
//  finalProject
//
//  Created by Дмитрий Рощин on 14/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

#import "NetworkService.h"

static NSString *const APIKey = @"&apikey=BGS27VRZ3W3Z0ILR";
static NSString *const searchURL = @"https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=";
static NSString *const intradayURL = @"https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=";
static NSString *const timeIntervalURLPart = @"&interval=1min";
static NSString *const APIDictionaryKeyTooMuchRequests = @"Note";

@interface NetworkService ()

@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration;
@property (nonatomic, strong) NSURLSession *session;

@end

@implementation NetworkService

- (instancetype)init
{
    self = [super init];
    _sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration;
    _session = [NSURLSession sessionWithConfiguration:_sessionConfiguration];
    _delegate = [CurrentStockDataModel sharedInstance];
    return self;
}

+ (instancetype)sharedInstance
{
    static NetworkService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkService alloc] init];
    });
    return sharedInstance;
}

- (void)updateIntradayData:(NSString *)symbol
{
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@", intradayURL, symbol, timeIntervalURLPart, APIKey]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:requestURL];
    NSURLSessionDataTask *dataTask = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *intradayData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (error == nil)
        {
            if (intradayData[APIDictionaryKeyTooMuchRequests] == nil)
            {
                [self.delegate saveIntradayData:intradayData];
            }
            else
            {
                NSLog(@"Too many requests");
            }
        }
        else
        {
            NSLog(@"%@", error);
        }
    }];
    [dataTask resume];
}

- (void)searchData:(NSString *)searchString
{
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", searchURL, searchString, APIKey]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:requestURL];
    NSURLSessionDataTask *dataTask = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *searchResults = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (error == nil)
        {
            if (searchResults[APIDictionaryKeyTooMuchRequests] == nil)
            {
                [self.delegate saveSearchResults:searchResults];
            }
            else
            {
                NSLog(@"Too many requests");
            }
        }
        else
        {
            NSLog(@"%@", error);
        }
    }];
    [dataTask resume];
}

@end
