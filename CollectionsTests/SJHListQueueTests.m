//
//  SJHListQueueTests.m
//  Collections
//
//  Created by James Heller on 9/27/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

#import "SJHListQueue.h"

#import "SJHCollectionProtocol.h"

@interface SJHListQueueTests : SenTestCase

@property (strong, nonatomic) id<SJHCollectionProtocol> queue;

@property (strong, nonatomic) NSArray *standardTestData;

@end

@implementation SJHListQueueTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    _standardTestData = [self makeStringArray:@"abcdefghijklmnopqrstuvwxyz"];
}

- (NSArray *)makeStringArray:(NSString *)string{
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[string length]];
    
    for (NSInteger i = 0; i < [string length]; i++) {
        [array addObject:[NSString stringWithFormat:@"%c",[string characterAtIndex:i]]];
    }
    
    return [array copy];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testExample{}

- (void)prepareQueueWithStandardData{
    _queue = [[SJHListQueue alloc] initWithIterable:_standardTestData];
}

- (void)test_SJHListQueue_initializers{
    _queue = [[SJHListQueue alloc] init];
    STAssertTrue([_queue isKindOfClass:[SJHListQueue class]], @"init: Expected SJHListQueue class");
    
    _queue = [[SJHListQueue alloc] initWithIterable:_standardTestData];
    STAssertTrue([_queue isKindOfClass:[SJHListQueue class]], @"initWithIterable: Expected SJHListQueue class");
    NSInteger i = 0;
    for (id value in [_queue enumerator]) {
        STAssertTrue([value isEqual:_standardTestData[i]], [NSString stringWithFormat:@"initWithIterable: Expected %@, Received %@", value, _standardTestData[i]]);
        i++;
    }
}

//- (void)

@end
