//
//  BlockTests.m
//  DMTime
//
//  Created by Dale Myers on 09/07/2015.
//  Copyright (c) 2015 Dale Myers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <DMTime/DMTime.h>

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

- (void)testStandard
{
	double sleepTime = 2.0;
    for (int i = 0; i < 10; i++)
    {
        NSString *timername = [NSString stringWithFormat:@"Test_%d",i];
        [DMTime startTimer:timername];
        sleep(sleepTime);
        [DMTime endTimer:timername];
        DMTimeResult *result = [DMTime lastResultForKey:timername];
        
        // I need to find something more accurate than sleep(). It seems to be
        // really bad at these kinds of values.
		NSLog(@"Checking result. Expected: %.2f seconds. Actual: %.2f", sleepTime, [result seconds]);
        XCTAssert([result seconds] > (sleepTime - 0.15) && [result seconds] < (sleepTime + 0.15), @"Pass");
    }
}

- (void)testBlocks
{
	double sleepTime = 2.0;
    for (int i = 0; i < 10; i++)
    {
        DMTimeResult *result = [DMTime timeBlock:^{
            sleep(sleepTime);
        }];
		NSLog(@"Checking result. Expected: %.2f seconds. Actual: %.2f", sleepTime, [result seconds]);
		XCTAssert([result seconds] > (sleepTime - 0.15) && [result seconds] < (sleepTime + 0.15), @"Pass");
    }
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        NSLog(@"Hello world");
//    }];
//}

@end
