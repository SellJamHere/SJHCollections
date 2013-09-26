//
//  SJHStackTests.m
//  Collections
//
//  Created by James Heller on 9/25/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

#import "SJHStack.h"

static NSInteger kTestSize = 1000;

@interface SJHStackTests : SenTestCase

@property (strong, nonatomic) NSMutableArray *testValues;

@end

@implementation SJHStackTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    _testValues = [[NSMutableArray alloc] init];
    
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
    SJHStack *stack = [[SJHStack alloc] init];
    
    STAssertTrue([stack isKindOfClass:[SJHStack class]], @"Stack is not proper class");
}

- (void)test_initWithCapacity{
    SJHStack *stack = [[SJHStack alloc] initWithCapacity:kTestSize];
    
    STAssertTrue([stack isKindOfClass:[SJHStack class]], @"Stack is not proper class");
}

- (void)test_initWithArray{
    
    SJHStack *stack = [[SJHStack alloc] initWithArray:_testValues];

    for (NSInteger i = 0; i < [_testValues count]; i++) {
        NSInteger value = [[stack pop] integerValue];
        STAssertTrue(value == i, [NSString stringWithFormat:@"Expected %ld, recieved %ld", (long)i, value]);
    }
    
    STAssertTrue([stack count] == 0, [NSString stringWithFormat:@"Stack should be empty. However, count is %ld", [stack count]]);
}

- (void)test_stackWithObjects{
    SJHStack *stack = [SJHStack stackWithObjects:_testValues];
    
    for (NSInteger i = 0; i < [_testValues count]; i++) {
        NSInteger value = [[stack pop] integerValue];
        STAssertTrue(value == i, [NSString stringWithFormat:@"Expected %ld, recieved %ld", (long)i, value]);
    }
    
    STAssertTrue([stack count] == 0, [NSString stringWithFormat:@"Stack should be empty. However, count is %ld", [stack count]]);
}


- (void)test_push{
    SJHStack *stack = [[SJHStack alloc] init];
    
    NSInteger i;
    for (i = 0; i < kTestSize; i++) {
        [stack push:[NSNumber numberWithInteger:i]];
        
        STAssertTrue([stack count] == i + 1, [NSString stringWithFormat:@"Stack count should be %ld. However, count is %ld", i + 1, [stack count]]);
    }
}

- (void)test_pop{
    SJHStack *stack = [[SJHStack alloc] initWithArray:_testValues];
    
    for (NSInteger i = 0; i < [_testValues count]; i++) {
        NSInteger value = [[stack pop] integerValue];
        
        STAssertTrue(value == i, [NSString stringWithFormat:@"Stack pop should be %ld. However, value is %ld", value, i]);
    }
}

- (void)test_peak{
    SJHStack *stack = [[SJHStack alloc] init];
    
    NSInteger i;
    for (i = 0; i < kTestSize; i++) {
        [stack push:[NSNumber numberWithInteger:i]];
        
        STAssertTrue([stack peak] == [NSNumber numberWithInteger:i], [NSString stringWithFormat:@"Stack peak should be %ld. However, value is %ld", i, [stack count]]);
    }
}

- (void)test_objectAtIndex{
    SJHStack *stack = [[SJHStack alloc] initWithArray:_testValues];
    
    NSInteger index = 123;
    
    STAssertTrue([[stack objectAtIndex:index] integerValue] == index, @"Expected 74, received %ld", [stack objectAtIndex:index]);
}

- (void)test_count{
    SJHStack *stack = [[SJHStack alloc] initWithArray:_testValues];
    
    STAssertTrue([stack count] == [_testValues count], [NSString stringWithFormat:@"Expected count %ld, received count %ld", [stack count], [_testValues count]]);
}


@end
