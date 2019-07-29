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

- (void)setUp {
    [CurrentStockDataModel sharedInstance].searchResults = nil;
    [CurrentStockDataModel sharedInstance].intradayData = nil;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


#pragma mark - Singleton

- (void)testSingleton
{
    XCTAssertNotNil([NetworkService sharedInstance]);
}


#pragma mark - updateIntradayData

- (void)testUpdateIntradayData
{
    IntradayViewController *viewController = [[IntradayViewController alloc] init];
    [viewController setSymbol:@"test"];
    [viewController viewDidLoad];
    [CurrentStockDataModel sharedInstance].delegate = viewController;
    [[NetworkService sharedInstance] updateIntradayData:@"AAPL"];
    
}
@end
