//
//  SJHQueueTests.m
//  Collections
//
//  Created by James Heller on 10/19/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

#import "CollectionsTests.h"

#import "SJHQueue.h"

@interface SJHQueueTests : SenTestCase

@property (strong, nonatomic) NSMutableArray *testValues;

@end

@implementation SJHQueueTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    _testValues = [[NSMutableArray alloc] initWithCapacity:kTestSize];
    
    for (NSInteger i = 0; i < kTestSize; i++) {
        [_testValues addObject:[NSNumber numberWithInteger:i]];
    }
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)test_init{
    SJHQueue *queue = [[SJHQueue alloc] init];
    
    STAssertTrue([queue isKindOfClass:[SJHQueue class]], @"Stack is not proper class");
}

- (void)test_initWithCapacity{
    SJHQueue *queue = [[SJHQueue alloc] initWithCapacity:kTestSize];
    
    STAssertTrue([queue isKindOfClass:[SJHQueue class]], @"Stack is not proper class");
}

- (void)test_initWithArray{
    
    SJHQueue *queue = [[SJHQueue alloc] initWithArray:_testValues];
    
    for (NSInteger i = 0 ; i < [_testValues count] ; i++) {
        NSInteger value = [[queue remove] integerValue];
        STAssertTrue(value == i, [NSString stringWithFormat:@"Expected %ld, recieved %ld", (long)i, value]);
    }
    
    STAssertTrue([queue count] == 0, [NSString stringWithFormat:@"Stack should be empty. However, count is %ld", [queue count]]);
}

- (void)test_stackWithObjects{
    SJHQueue *queue = [SJHQueue queueWithObjects:_testValues];
    
    for (NSInteger i = 0; i < [_testValues count]; i++) {
        NSInteger value = [[queue remove] integerValue];
        STAssertTrue(value == i, [NSString stringWithFormat:@"Expected %ld, recieved %ld", (long)i, value]);
    }
    
    STAssertTrue([queue count] == 0, [NSString stringWithFormat:@"Stack should be empty. However, count is %ld", [queue count]]);
}


- (void)test_push{
    SJHQueue *queue = [[SJHQueue alloc] init];
    
    NSInteger i;
    for (i = 0; i < kTestSize; i++) {
        [queue add:[NSNumber numberWithInteger:i]];
        
        STAssertTrue([queue count] == i + 1, [NSString stringWithFormat:@"Stack count should be %ld. However, count is %ld", i + 1, [queue count]]);
    }
}

- (void)test_pop{
    SJHQueue *queue = [[SJHQueue alloc] initWithArray:_testValues];
    
    for (NSInteger i = 0; i < [_testValues count]; i++) {
        NSInteger value = [[queue remove] integerValue];
        
        STAssertTrue(value == i, [NSString stringWithFormat:@"Stack pop should be %ld. However, value is %ld", value, i]);
    }
}

- (void)test_peek{
    SJHQueue *queue = [[SJHQueue alloc] initWithArray:_testValues];
    
    for (NSInteger i = 0; i < [_testValues count]; i++) {
        STAssertTrue([queue peek] == [NSNumber numberWithInteger:i], [NSString stringWithFormat:@"Stack peak should be %ld. However, value is %ld", i, i]);
        [queue remove];
    }
}

- (void)test_objectAtIndex{
    SJHQueue *queue = [[SJHQueue alloc] initWithArray:_testValues];
    
    NSInteger index = arc4random_uniform((uint)kTestSize);
    
    STAssertTrue([[queue objectAtIndex:index] integerValue] == index, @"Expected %ld, received %ld", index, [queue objectAtIndex:index]);
}

- (void)test_count{
    SJHQueue *queue = [[SJHQueue alloc] initWithArray:_testValues];
    
    STAssertTrue([queue count] == [_testValues count], [NSString stringWithFormat:@"Expected count %ld, received count %ld", [queue count], [_testValues count]]);
}

@end
