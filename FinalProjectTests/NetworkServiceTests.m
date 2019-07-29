//
//  NetworkServiceTests.m
//  FinalProjectTests
//
//  Created by Дмитрий Рощин on 29/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NetworkService.h"
#import "CurrentStockDataModel.h"
#import "IntradayViewController.h"
#import "OCMock/OCMock.h"

@interface NetworkServiceTests : XCTestCase

@end

@implementation NetworkServiceTests

- (void)setUp
{
    
}

- (void)tearDown
{
    
}


#pragma mark - Singleton

- (void)testSingleton
{
    XCTAssertNotNil([NetworkService sharedInstance]);
}


#pragma mark - updateIntradayData

- (void)testUpdateIntradayData
{
    id mock = OCMClassMock([CurrentStockDataModel class]);
    [NetworkService sharedInstance].delegate = mock;
    [[NetworkService sharedInstance] updateIntradayData:@"AAPL"];
    [NSThread sleepForTimeInterval:2.0f];
    OCMVerify([mock saveIntradayData:OCMArg.any]);
}


#pragma mark - searchData

- (void)testSearchData
{
    id mock = OCMClassMock([CurrentStockDataModel class]);
    [NetworkService sharedInstance].delegate = mock;
    [[NetworkService sharedInstance] searchData:@"AAPL"];
    [NSThread sleepForTimeInterval:2.0f];
    OCMVerify([mock saveSearchResults:OCMArg.any]);
}

@end
