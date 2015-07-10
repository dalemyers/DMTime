//
//  CocoaTimeResult.h
//  CocoaTime
//
//  Created by Dale Myers on 09/07/2015.
//  Copyright (c) 2015 Dale Myers. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *	@brief  A wrapper object for all time results
 */
@interface CocoaTimeResult : NSObject

/**
 *	@brief  A unit to return the results in
 */
typedef NS_ENUM(NSInteger, CocoaTimeUnit)
{
    // Nano seconds is offered, but the overhead of the timing is just too
    // much for it to be of any real use
    CocoaTimeUnitNanoSeconds,
    CocoaTimeUnitMicroSeconds, // The timer adds around 250 microseconds to each timed block
    CocoaTimeUnitMilliSeconds,
    CocoaTimeUnitSeconds
};

/**
 *	@brief  How long the code block took to run
 */
@property NSNumber *time;

/**
 *	@brief  The unit of time associated with the value
 */
@property CocoaTimeUnit timeUnit;

/**
 *	@brief  A simple constructor for generating an error value
 *
 *	@return A new CocoaTimeResult with a value of -1 nano seconds
 */
+ (instancetype)timeResultError;

/**
 *	@brief  Creates a new CocoaTimeResult
 *
 *	@param timeInNanoSeconds	The time in ns to instantiate the object with
 *
 *	@return A new CocoaTimeResult
 */
- (instancetype)initWithTimeInNanoSeconds:(double)timeInNanoSeconds;

/**
 *	@brief  The time the code block took to run in the units specified
 *
 *	@param unit	The units to return the time in
 *
 *	@return The time the code block took to run in the units specified
 *          The value will be -1 on failure
 */
- (double)timeInUnits:(CocoaTimeUnit)unit;

/**
 *	@brief  The time the code block took to run in nanoseconds
 *
 *	@return The time the code block took to run in nanoseconds
 *          The value will be -1 on failure
 */
- (double)timeInNanoSeconds;

/**
 *	@brief  The time the code block took to run in microseconds
 *
 *	@return The time the code block took to run in microseconds
 *          The value will be -1 on failure
 */
- (double)timeInMicroSeconds;

/**
 *	@brief  The time the code block took to run in milliseconds
 *
 *	@return The time the code block took to run in milliseconds
 *          The value will be -1 on failure
 */
- (double)timeInMilliSeconds;

/**
 *	@brief  The time the code block took to run in seconds
 *
 *	@return The time the code block took to run in seconds
 *          The value will be -1 on failure
 */
- (double)timeInSeconds;

@end
