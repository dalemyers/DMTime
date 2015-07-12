//
//  CocoaTimeResult.m
//  CocoaTime
//
//  Created by Dale Myers on 09/07/2015.
//  Copyright (c) 2015 Dale Myers. All rights reserved.
//

#import "CocoaTimeResult.h"

@implementation CocoaTimeResult

+ (int)timeDivisionFactorForUnit:(CocoaTimeUnit)unit
{
    switch (unit) {
        case CocoaTimeUnitMicroSeconds:
            return NSEC_PER_USEC;
        case CocoaTimeUnitMilliSeconds:
            return NSEC_PER_MSEC;
        case CocoaTimeUnitSeconds:
            return NSEC_PER_SEC;
        default:
            return 1;
    }
}

+ (instancetype)timeResultError
{
    return [[CocoaTimeResult alloc] initWithTimeInNanoSeconds:-1];
}

- (instancetype)initWithTimeInNanoSeconds:(double)timeInNanoSeconds
{
    if (self = [super init])
    {
        _time = [NSNumber numberWithDouble:timeInNanoSeconds];
        _timeUnit = CocoaTimeUnitNanoSeconds;
    }
    
    return self;
}


- (double)timeInUnits:(CocoaTimeUnit)unit
{
    if ([[self time] integerValue] == -1)
    {
        return -1.0;
    }
    
    if ([self timeUnit] == unit)
    {
        return [[self time] doubleValue];
    }
    
    double timeInNanoSeconds = [[self time] doubleValue] * [CocoaTimeResult timeDivisionFactorForUnit:[self timeUnit]];
    
    return timeInNanoSeconds / [CocoaTimeResult timeDivisionFactorForUnit:unit];
}

- (double)nanoseconds
{
    return [self timeInUnits:CocoaTimeUnitNanoSeconds];
}

- (double)microseconds
{
    return [self timeInUnits:CocoaTimeUnitMicroSeconds];
}

- (double)milliseconds
{
    return [self timeInUnits:CocoaTimeUnitMilliSeconds];
}

- (double)seconds
{
    return [self timeInUnits:CocoaTimeUnitSeconds];
}

@end
