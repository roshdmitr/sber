//
//  finalProjectUITests.m
//  finalProjectUITests
//
//  Created by Дмитрий Рощин on 13/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SearchViewController.h"

@interface FinalProjectUITests : XCTestCase

@end

@implementation FinalProjectUITests

- (void)setUp
{
    self.continueAfterFailure = NO;

    [[[XCUIApplication alloc] init] launch];
}

- (void)tearDown
{
    
}

- (void)testFavourites
{

    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCTAssertTrue(app.searchFields[@"Search"].exists);
    [app.searchFields[@"Search"] tap];

    XCUIElement *aKey = app/*@START_MENU_TOKEN@*/.keys[@"A"]/*[[".keyboards.keys[@\"A\"]",".keys[@\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [aKey tap];

    XCUIElement *deleteKey = app/*@START_MENU_TOKEN@*/.keys[@"delete"]/*[[".keyboards.keys[@\"delete\"]",".keys[@\"delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [deleteKey tap];
    XCTAssertTrue(app.buttons[@"Cancel"].exists);
    [app.buttons[@"Cancel"] tap];


    XCUIElementQuery *tabBarsQuery = app.tabBars;
    XCTAssertTrue(tabBarsQuery.buttons[@"Favorites"].exists);
    [tabBarsQuery.buttons[@"Favorites"] tap];
    XCTAssertTrue(app.collectionViews.staticTexts[@"SBRCY"].exists);
    [app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts[@"SBRCY"]/*[[".cells.staticTexts[@\"SBRCY\"]",".staticTexts[@\"SBRCY\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];

    XCUIElement *intradayviewNavigationBar = app.navigationBars[@"IntradayView"];
    XCTAssertTrue(intradayviewNavigationBar.buttons[@"Add"].exists);
    XCUIElement *addButton = intradayviewNavigationBar.buttons[@"Add"];
    [addButton tap];
    XCTAssertTrue(app.alerts[@"Oops!"].exists);
    XCTAssertTrue(app.alerts[@"Oops!"].buttons[@"Delete"].exists);
    [app.alerts[@"Oops!"].buttons[@"Delete"] tap];
    [addButton tap];
    XCTAssertTrue(intradayviewNavigationBar.buttons[@"Your favourite stocks"].exists);
    [intradayviewNavigationBar.buttons[@"Your favourite stocks"] tap];
    [tabBarsQuery.buttons[@"Search"] tap];

}

- (void)testSearch
{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCTAssertTrue(app.searchFields[@"Search"].exists);
    XCUIElement *searchSearchField = app.searchFields[@"Search"];
    [searchSearchField tap];
    
    XCUIElement *shiftButton = app/*@START_MENU_TOKEN@*/.buttons[@"shift"]/*[[".keyboards.buttons[@\"shift\"]",".buttons[@\"shift\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    XCTAssertTrue(app/*@START_MENU_TOKEN@*/.buttons[@"shift"]/*[[".keyboards.buttons[@\"shift\"]",".buttons[@\"shift\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists);
    
    XCUIElement *aKey = app/*@START_MENU_TOKEN@*/.keys[@"A"]/*[[".keyboards.keys[@\"A\"]",".keys[@\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    XCTAssertTrue(app/*@START_MENU_TOKEN@*/.keys[@"A"]/*[[".keyboards.keys[@\"A\"]",".keys[@\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists);
    [aKey tap];
    [shiftButton tap];
    [aKey tap];
    
    XCUIElement *pKey = app/*@START_MENU_TOKEN@*/.keys[@"P"]/*[[".keyboards.keys[@\"P\"]",".keys[@\"P\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [shiftButton tap];
    XCTAssertTrue(app.keys[@"P"].exists);
    [pKey tap];
    
    XCUIElement *lKey = app/*@START_MENU_TOKEN@*/.keys[@"L"]/*[[".keyboards.keys[@\"L\"]",".keys[@\"L\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [shiftButton tap];
    XCTAssertTrue(app.keys[@"L"].exists);
    [lKey tap];
    
    XCUIElement *searchButton = app.keyboards.buttons[@"Search"];
    XCTAssertTrue(app.keyboards.buttons[@"Search"].exists);
    [searchButton tap];
    
    XCUIElement *cancelButton = app.buttons[@"Cancel"];
    XCTAssertTrue(app.buttons[@"Cancel"].exists);
    [cancelButton tap];
    [searchSearchField tap];
    
    XCUIElement *sKey = app/*@START_MENU_TOKEN@*/.keys[@"S"]/*[[".keyboards.keys[@\"S\"]",".keys[@\"S\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    XCTAssertTrue(app.keys[@"S"].exists);
    [sKey tap];
    
    XCUIElement *bKey = app/*@START_MENU_TOKEN@*/.keys[@"B"]/*[[".keyboards.keys[@\"B\"]",".keys[@\"B\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [shiftButton tap];
    XCTAssertTrue(app.keys[@"B"].exists);
    [bKey tap];
    [shiftButton tap];
    XCTAssertTrue(app.keys[@"E"].exists);
    [app/*@START_MENU_TOKEN@*/.keys[@"E"]/*[[".keyboards.keys[@\"E\"]",".keys[@\"E\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    
    XCUIElement *rKey = app/*@START_MENU_TOKEN@*/.keys[@"R"]/*[[".keyboards.keys[@\"R\"]",".keys[@\"R\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [shiftButton tap];
    XCTAssertTrue(app.keys[@"R"].exists);
    [rKey tap];
    [searchButton tap];
    [cancelButton tap];
    
}

- (void)testSearchTap
{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCTAssertTrue(app.searchFields[@"Search"].exists);
    [app.searchFields[@"Search"] tap];
    
    XCUIElement *aKey = app/*@START_MENU_TOKEN@*/.keys[@"A"]/*[[".keyboards.keys[@\"A\"]",".keys[@\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    XCTAssertTrue(app.keys[@"A"].exists);
    XCUIElement *shiftButton = app/*@START_MENU_TOKEN@*/.buttons[@"shift"]/*[[".keyboards.buttons[@\"shift\"]",".buttons[@\"shift\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    XCTAssertTrue(app.buttons[@"shift"].exists);
    [aKey tap];
    
    [shiftButton tap];
    [aKey tap];
    
    [shiftButton tap];
    
    XCUIElement *pKey = app/*@START_MENU_TOKEN@*/.keys[@"P"]/*[[".keyboards.keys[@\"P\"]",".keys[@\"P\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    XCTAssertTrue(app.keys[@"P"].exists);
    [pKey tap];
    
    XCUIElement *lKey = app/*@START_MENU_TOKEN@*/.keys[@"L"]/*[[".keyboards.keys[@\"L\"]",".keys[@\"L\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [shiftButton tap];
    XCTAssertTrue(app.keys[@"L"].exists);
    [lKey tap];
    
    XCTAssertTrue(app.keyboards.buttons[@"Search"].exists);
    [app.keyboards.buttons[@"Search"] tap];
    [app.tables/*@START_MENU_TOKEN@*/.staticTexts[@"AAPL - Apple Inc."]/*[[".cells.staticTexts[@\"AAPL - Apple Inc.\"]",".staticTexts[@\"AAPL - Apple Inc.\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    XCTAssertTrue(app.navigationBars[@"IntradayView"].buttons[@"Back to search"].exists);
    [app.navigationBars[@"IntradayView"].buttons[@"Back to search"] tap];
    XCTAssertTrue(app.buttons[@"Cancel"].exists);
    [app.buttons[@"Cancel"] tap];
    
}
@end
