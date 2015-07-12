//
//  DMTime.h
//  DMTime
//
//  Created by Dale Myers on 7/7/15.
//  Copyright (c) 2015 Dale Myers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMTimeResult.h"

/**
 *	@brief  A simple timing utility class
 */
@interface DMTime : NSObject


/**
 *	@brief  Starts a timer for the given key
 *
 *	@param key	A unique key for this block of code
 */
+ (void)startTimer:(NSString*)key;

/**
 *	@brief  Ends the timer for the given key
 *
 *	@param key	A unique key for the block of code
 *
 *	@return The time between the startTimer: and endTimer: calls in seconds
 *			The result is -1 on failure.
 */
+ (DMTimeResult*)endTimer:(NSString*)key;

/**
 *	@brief  Times a block of code
 *
 *	@param blockToTime	The block of code to time running
 *
 *	@return The time taken to execute the block of code, in seconds
 *			The result is -1 on failure.
 */
+ (DMTimeResult*)timeBlock:(void (^)())blockToTime;

/**
 *	@brief  The latest result for a previous timed block of code.
 *
 *	@param key	The key for the block of code
 *	@param unit	The time unit to format the returned result in.
 *
 *	@return The time taken to run the block of code, in the given time unit,
 *			The result is -1 on failure.
 */
+ (DMTimeResult*)lastResultForKey:(NSString*)key;

/**
 *	@brief  All the results for a given key
 *
 *	@param key	The key of the block of code
 *
 *	@return All results for a given key
 */
+ (NSArray*)allResultsForKey:(NSString*)key;

/**
 *	@brief  The mean result for a given key
 *
 *	@param key	The key of the block of code
 *
 *	@return The mean result for a given key
 */
+ (DMTimeResult*)meanResultForKey:(NSString*)key;

/**
 *	@brief  The number of results recorded for a given key
 *
 *	@param key	The key of the block of code
 *
 *	@return The number of results recorded for a given key
 */
+ (NSUInteger)numberOfResultsForKey:(NSString*)key;

/**
 *	@brief  Returns all the results in a dictionary
 *
 *	@return All results in a dictionary
 */
+ (NSDictionary*)allResults;

/**
 *	@brief  Removes a result for the given key
 *
 *	@param key	The key of the result to remove
 */
+ (void)removeResultForKey:(NSString*)key;

/**
 *	@brief  Removes all results
 */
+ (void)removeAllResults;

@end
