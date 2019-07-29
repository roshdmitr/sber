//
//  CurrentStockDataModelTest.m
//  FinalProjectTests
//
//  Created by Дмитрий Рощин on 29/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CurrentStockDataModel.h"
#import "IntradayViewController.h"
#import "SearchViewController.h"
#import "OCMock/OCMock.h"

@interface CurrentStockDataModelTests : XCTestCase

@end

@implementation CurrentStockDataModelTests

- (void)setUp
{
    [CurrentStockDataModel sharedInstance].searchResults = nil;
    [CurrentStockDataModel sharedInstance].intradayData = nil;
}

- (void)tearDown
{
    
}


#pragma mark - Singleton

- (void)testSingleton
{
    XCTAssertNotNil([CurrentStockDataModel sharedInstance]);
}


#pragma mark - saveSearchResults

- (void)testSaveSearchResultsNil
{
    NSDictionary *testDictionary = nil;
    [[CurrentStockDataModel sharedInstance] saveSearchResults:testDictionary];
    XCTAssertNil([CurrentStockDataModel sharedInstance].searchResults);
}

- (void)testSaveSearchResultsWrong
{
    NSDictionary *testDictionary = @{ @"test" : @"check" };
    [[CurrentStockDataModel sharedInstance] saveSearchResults:testDictionary];
    XCTAssertNil([CurrentStockDataModel sharedInstance].searchResults);
}

- (void)testSaveSearchResultsNormal
{
    id viewController = OCMProtocolMock(@protocol(CurrentStockDataModelDelegate));
    [CurrentStockDataModel sharedInstance].delegate = viewController;
    NSDictionary *testDictionary = @{ APIDictionaryKeyMain : @[ @{ APIDictionaryKeySymbol : @"BA", APIDictionaryKeyName : @"The Boeing Company", APIDictionaryKeyRegion : @"United States" }, @{ APIDictionaryKeySymbol : @"BABA", APIDictionaryKeyName : @"Alibaba Group Holding Limited", APIDictionaryKeyRegion : @"United States" } ] };
    [[CurrentStockDataModel sharedInstance] saveSearchResults:testDictionary];
    XCTAssertEqual([CurrentStockDataModel sharedInstance].searchResults, testDictionary[APIDictionaryKeyMain]);
}


#pragma mark - saveIntradayData

- (void)testSaveIntradayDataNormal
{
    id viewController = OCMProtocolMock(@protocol(CurrentStockDataModelDelegate));
    [CurrentStockDataModel sharedInstance].delegate = viewController;
    NSDictionary *testDictionary = @{ APIDictionaryKeyMetaData : @{ APIDictionaryKeySymbol : @"MSFT", APIDictionaryKeyLastRefreshed : @"2019-07-26 16:00:00" }, APIDictionaryKeyTimeSeries : @{ @"2019-07-26 16:00:00" : @{ APIDictionaryKeyLow : @"141.3000", APIDictionaryKeyHigh : @"141.6500", APIDictionaryKeyOpen : @"141.6000", APIDictionaryKeyClose : @"141.3300" } } };
    [[CurrentStockDataModel sharedInstance] saveIntradayData:testDictionary];
    XCTAssertEqual([CurrentStockDataModel sharedInstance].intradayData, testDictionary[APIDictionaryKeyTimeSeries][@"2019-07-26 16:00:00"]);
}

- (void)testSaveIntradayDataNil
{
    NSDictionary *testDictionary = nil;
    [[CurrentStockDataModel sharedInstance] saveIntradayData:testDictionary];
    XCTAssertNil([CurrentStockDataModel sharedInstance].intradayData);
}

- (void)testSaveIntradayDataWrong
{
    NSDictionary *testDictionary = @{ @"test" : @"check" };
    [[CurrentStockDataModel sharedInstance] saveIntradayData:testDictionary];
    XCTAssertNil([CurrentStockDataModel sharedInstance].intradayData);
}

@end
