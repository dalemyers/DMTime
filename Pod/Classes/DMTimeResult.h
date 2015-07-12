//
//  DMTimeResult.h
//  DMTime
//
//  Created by Dale Myers on 09/07/2015.
//  Copyright (c) 2015 Dale Myers. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *	@brief  A wrapper object for all time results
 */
@interface DMTimeResult : NSObject

/**
 *	@brief  A unit to return the results in
 */
typedef NS_ENUM(NSInteger, DMTimeUnit)
{
	// Nano seconds is offered, but the overhead of the timing is just too
	// much for it to be of any real use
	DMTimeUnitNanoSeconds,
	DMTimeUnitMicroSeconds, // The timer adds around 250 microseconds to each timed block
	DMTimeUnitMilliSeconds,
	DMTimeUnitSeconds
};

/**
 *	@brief  How long the code block took to run
 */
@property NSNumber *time;

/**
 *	@brief  The unit of time associated with the value
 */
@property DMTimeUnit timeUnit;

/**
 *	@brief  A simple constructor for generating an error value
 *
 *	@return A new DMTimeResult with a value of -1 nano seconds
 */
+ (instancetype)timeResultError;

/**
 *	@brief  Creates a new DMTimeResult
 *
 *	@param timeInNanoSeconds	The time in ns to instantiate the object with
 *
 *	@return A new DMTimeResult
 */
- (instancetype)initWithTimeInNanoSeconds:(double)timeInNanoSeconds;

/**
 *	@brief  The time the code block took to run in the units specified
 *
 *	@param unit	The units to return the time in
 *
 *	@return The time the code block took to run in the units specified
 *			The value will be -1 on failure
 */
- (double)timeInUnits:(DMTimeUnit)unit;

/**
 *	@brief  The time the code block took to run in nanoseconds
 *
 *	@return The time the code block took to run in nanoseconds
 *			The value will be -1 on failure
 */
- (double)nanoseconds;

/**
 *	@brief  The time the code block took to run in microseconds
 *
 *	@return The time the code block took to run in microseconds
 *			The value will be -1 on failure
 */
- (double)microseconds;

/**
 *	@brief  The time the code block took to run in milliseconds
 *
 *	@return The time the code block took to run in milliseconds
 *			The value will be -1 on failure
 */
- (double)milliseconds;

/**
 *	@brief  The time the code block took to run in seconds
 *
 *	@return The time the code block took to run in seconds
 *			The value will be -1 on failure
 */
- (double)seconds;

@end
