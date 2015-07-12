//
//  DMTime.m
//  DMTime
//
//  Created by Dale Myers on 7/7/15.
//  Copyright (c) 2015 Dale Myers. All rights reserved.
//

#import "DMTime.h"
#import <mach/mach_time.h>
#import <stdint.h>

@implementation DMTime

static NSMutableDictionary *_results;
static NSMutableDictionary *_active;
static BOOL _initialized = NO;

+ (void)initializeIfNeeded
{
	if (!_initialized)
	{
		_results = [[NSMutableDictionary alloc] init];
		_active = [[NSMutableDictionary alloc] init];
		_initialized = YES;
	}
}

+ (NSNumber*)now
{
	return [NSNumber numberWithUnsignedLongLong:mach_absolute_time()];
}

+ (NSString*)newGuid
{
	CFUUIDRef newUUID = CFUUIDCreate(NULL);
	CFStringRef newUUIDStrRef = CFUUIDCreateString(NULL, newUUID);
	CFRelease(newUUID);
	return (__bridge NSString*)newUUIDStrRef;
}

+ (void)startTimer:(NSString*)key
{
	[DMTime initializeIfNeeded];
	
	_active[key] = [DMTime now];
}

+ (DMTimeResult*)endTimer:(NSString*)key
{
	uint64_t currentTime = [[DMTime now] unsignedLongLongValue];
	NSNumber *startTimeObject = _active[key];
	
	if (startTimeObject == nil)
	{
		return [DMTimeResult timeResultError];
	}
	
	[_active removeObjectForKey:key];
	
	uint64_t startTime = [startTimeObject unsignedLongLongValue];
	
	uint64_t diff = currentTime - startTime;
	
	mach_timebase_info_data_t info;
	
	if (mach_timebase_info(&info) != KERN_SUCCESS)
	{
		NSLog(@"Error creating mach_timebase_info");
		return [DMTimeResult timeResultError];
	}
	
	double diffNanoSeconds = (double)diff * ((double)info.numer / (double)info.denom);
	
	DMTimeResult *result = [[DMTimeResult alloc] initWithTimeInNanoSeconds:(long long)diffNanoSeconds];
	
	if ([_results objectForKey:key] == nil)
	{
		_results[key] = [[NSMutableArray alloc] init];
	}
	
	[_results[key] addObject:result];
	
	return result;
}

+ (DMTimeResult*)timeBlock:(void (^)())blockToTime
{
	if (!blockToTime)
	{
		return [DMTimeResult timeResultError];
	}
	
	NSString *uniqueName = [NSString stringWithFormat:@"Block: %@", [DMTime newGuid]];
	[DMTime startTimer:uniqueName];
	
	blockToTime();
	
	return [DMTime endTimer:uniqueName];
}

+ (DMTimeResult*)lastResultForKey:(NSString*)key
{
	return [_results[key] lastObject];
}

+ (NSArray*)allResultsForKey:(NSString*)key
{
	return _results[key];
}

+ (NSDictionary*)allResults
{
	return [_results copy];
}

+ (DMTimeResult*)meanResultForKey:(NSString*)key
{
	double total = 0;
	for (DMTimeResult *result in [DMTime allResultsForKey:key])
	{
		total += [result nanoseconds];
	}
	
	return [[DMTimeResult alloc] initWithTimeInNanoSeconds:(total/[DMTime numberOfResultsForKey:key])];
}

+ (NSUInteger)numberOfResultsForKey:(NSString*)key
{
	return [_results[key] count];
}

+ (void)removeResultForKey:(NSString*)key
{
	[_results removeObjectForKey:key];
}

+ (void)removeAllResults
{
	[_results removeAllObjects];
}

@end
