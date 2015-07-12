//
//  DMTimeResult.m
//  DMTime
//
//  Created by Dale Myers on 09/07/2015.
//  Copyright (c) 2015 Dale Myers. All rights reserved.
//

#import "DMTimeResult.h"

@implementation DMTimeResult

+ (int)timeDivisionFactorForUnit:(DMTimeUnit)unit
{
	switch (unit) {
		case DMTimeUnitMicroSeconds:
			return NSEC_PER_USEC;
		case DMTimeUnitMilliSeconds:
			return NSEC_PER_MSEC;
		case DMTimeUnitSeconds:
			return NSEC_PER_SEC;
		default:
			return 1;
	}
}

+ (instancetype)timeResultError
{
	return [[DMTimeResult alloc] initWithTimeInNanoSeconds:-1];
}

- (instancetype)initWithTimeInNanoSeconds:(double)timeInNanoSeconds
{
	if (self = [super init])
	{
		_time = [NSNumber numberWithDouble:timeInNanoSeconds];
		_timeUnit = DMTimeUnitNanoSeconds;
	}
	
	return self;
}


- (double)timeInUnits:(DMTimeUnit)unit
{
	if ([[self time] integerValue] == -1)
	{
		return -1.0;
	}
	
	if ([self timeUnit] == unit)
	{
		return [[self time] doubleValue];
	}
	
	double timeInNanoSeconds = [[self time] doubleValue] * [DMTimeResult timeDivisionFactorForUnit:[self timeUnit]];
	
	return timeInNanoSeconds / [DMTimeResult timeDivisionFactorForUnit:unit];
}

- (double)nanoseconds
{
	return [self timeInUnits:DMTimeUnitNanoSeconds];
}

- (double)microseconds
{
	return [self timeInUnits:DMTimeUnitMicroSeconds];
}

- (double)milliseconds
{
	return [self timeInUnits:DMTimeUnitMilliSeconds];
}

- (double)seconds
{
	return [self timeInUnits:DMTimeUnitSeconds];
}

@end
