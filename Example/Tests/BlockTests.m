//
//  BlockTests.m
//  DMTime
//
//  Created by Dale Myers on 09/07/2015.
//  Copyright (c) 2015 Dale Myers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <DMTime.h>

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
        [DMTime startTimer:timername];
        sleep(1.0);
        [DMTime endTimer:timername];
        DMTimeResult *result = [DMTime lastResultForKey:timername];
        
        // I need to find something more accurate than sleep(). It seems to be
        // really bad at these kinds of values.
        XCTAssert([result seconds] > 0.85 && [result seconds] < 1.15, @"Pass");
    }
}

- (void)testBlocks {
    for (int i = 0; i < 10; i++)
    {
        DMTimeResult *result = [DMTime timeBlock:^{
            sleep(1.0);
        }];
        XCTAssert([result seconds] > 0.9 && [result seconds] < 1.1, @"Pass");
    }
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        NSLog(@"Hello world");
//    }];
//}

@end
