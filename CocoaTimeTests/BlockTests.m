//
//  BlockTests.m
//  CocoaTime
//
//  Created by Dale Myers on 09/07/2015.
//  Copyright (c) 2015 Dale Myers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CocoaTime.h"

@interface BlockTests : XCTestCase

@end

@implementation BlockTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testStandard {
    for (int i = 0; i < 10; i++)
    {
        NSString *timername = [NSString stringWithFormat:@"Test_%d",i];
        [CocoaTime startTimer:timername];
        sleep(1.0);
        [CocoaTime endTimer:timername];
        CocoaTimeResult *result = [CocoaTime lastResultForKey:timername];
        
        // I need to find something more accurate than sleep(). It seems to be
        // really bad at these kinds of values.
        XCTAssert([result timeInSeconds] > 0.85 && [result timeInSeconds] < 1.15, @"Pass");
    }
}

- (void)testBlocks {
    for (int i = 0; i < 10; i++)
    {
        CocoaTimeResult *result = [CocoaTime timeBlock:^{
            sleep(1.0);
        }];
        XCTAssert([result timeInSeconds] > 0.9 && [result timeInSeconds] < 1.1, @"Pass");
    }
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        NSLog(@"Hello world");
//    }];
//}

@end
