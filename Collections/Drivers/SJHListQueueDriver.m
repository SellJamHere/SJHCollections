//
//  SJHListQueueDriver.m
//  Collections
//
//  Created by James Heller on 9/27/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import "SJHListQueueDriver.h"

#import "SJHListQueue.h"

@implementation SJHListQueueDriver

- (void)run{
    SJHListQueue *queue = [[SJHListQueue alloc] init];
    
    NSArray *_standardTestData = [self makeStringArray:@"abcdefghijklmnopqrstuvwxyz"];
    
    queue = [[SJHListQueue alloc] initWithIterable:_standardTestData];
    NSLog(@"%c", [queue isKindOfClass:[SJHListQueue class]]);
    
    NSLog(@"%@", queue);
    
    NSInteger i = 0;
    for (id value in [queue enumerator]) {
        
        i++;
    }
}

- (NSArray *)makeStringArray:(NSString *)string{
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[string length]];
    
    for (NSInteger i = 0; i < [string length]; i++) {
        [array addObject:[NSString stringWithFormat:@"%c",[string characterAtIndex:i]]];
    }
    
    return [array copy];
}

@end
