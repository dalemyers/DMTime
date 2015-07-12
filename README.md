#CocoaTime

A simple Objective-C timer for timing code.

##Examples

    [CocoaTime startTimer:@"Some key"];
    // Some long running process
    CocoaTimeResult *result = [CocoaTime endTimer:@"Some key"];
    NSLog(@"Code took %f seconds", [result seconds]);

Or if you prefer blocks:

    CocoaTimeResult *result = [CocoaTime timeBlock:^{
        // Some long running process
    }];
    NSLog(@"Code took %f milliseconds", [result milliseconds]);
