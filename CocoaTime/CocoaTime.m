//
//  CocoaTime.m
//  CocoaTime
//
//  Created by Dale Myers on 7/7/15.
//  Copyright (c) 2015 Dale Myers. All rights reserved.
//

#import "CocoaTime.h"
#import <mach/mach_time.h>
#import <stdint.h>

@implementation CocoaTime

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
	[CocoaTime initializeIfNeeded];
	
	_active[key] = [CocoaTime now];
}

+ (CocoaTimeResult*)endTimer:(NSString*)key
{
	uint64_t currentTime = [[CocoaTime now] unsignedLongLongValue];
	NSNumber *startTimeObject = _active[key];
	
	if (startTimeObject == nil)
	{
        return [CocoaTimeResult timeResultError];
	}
	
	[_active removeObjectForKey:key];
	
	uint64_t startTime = [startTimeObject unsignedLongLongValue];
	
	uint64_t diff = currentTime - startTime;
	
	mach_timebase_info_data_t info;
	
	if (mach_timebase_info(&info) != KERN_SUCCESS)
	{
		NSLog(@"Error creating mach_timebase_info");
        return [CocoaTimeResult timeResultError];
	}
	
	double diffNanoSeconds = (double)diff * ((double)info.numer / (double)info.denom);
    
    CocoaTimeResult *result = [[CocoaTimeResult alloc] initWithTimeInNanoSeconds:(long long)diffNanoSeconds];
	
    if ([_results objectForKey:key] == nil)
    {
        _results[key] = [[NSMutableArray alloc] init];
    }
    
	[_results[key] addObject:result];
    
    return result;
}

+ (CocoaTimeResult*)timeBlock:(void (^)())blockToTime
{
    if (!blockToTime)
    {
        return [CocoaTimeResult timeResultError];
    }
    
    NSString *uniqueName = [NSString stringWithFormat:@"Block: %@", [CocoaTime newGuid]];
    [CocoaTime startTimer:uniqueName];
    
    blockToTime();
    
    return [CocoaTime endTimer:uniqueName];
}

+ (CocoaTimeResult*)lastResultForKey:(NSString*)key
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

+ (CocoaTimeResult*)meanResultForKey:(NSString*)key
{
    double total = 0;
    for (CocoaTimeResult *result in [CocoaTime allResultsForKey:key])
    {
        total += [result timeInNanoSeconds];
    }
    
    return [[CocoaTimeResult alloc] initWithTimeInNanoSeconds:(total/[CocoaTime numberOfResultsForKey:key])];
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
