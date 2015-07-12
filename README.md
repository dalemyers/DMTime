# DMTime

[![CI Status](http://img.shields.io/travis/Vel0x/DMTime.svg?style=flat)](https://travis-ci.org/Vel0x/DMTime)
[![Version](https://img.shields.io/cocoapods/v/DMTime.svg?style=flat)](http://cocoapods.org/pods/DMTime)
[![License](https://img.shields.io/cocoapods/l/DMTime.svg?style=flat)](http://cocoapods.org/pods/DMTime)
[![Platform](https://img.shields.io/cocoapods/p/DMTime.svg?style=flat)](http://cocoapods.org/pods/DMTime)

A simple Objective-C timer for timing code

## Usage
    #import <DMTime.h>
    ...
    [DMTime startTimer:@"Some key"];
    // Some long running process
    DMTimeResult *result = [DMTime endTimer:@"Some key"];
    NSLog(@"Code took %f seconds", [result seconds]);

Or if you prefer blocks:

    DMTimeResult *result = [DMTime timeBlock:^{
        // Some long running process
    }];
    NSLog(@"Code took %f milliseconds", [result milliseconds]);

## Requirements

## Installation

DMTime is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DMTime"
```

## License

DMTime is available under the MIT license. See the LICENSE file for more info.
