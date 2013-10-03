//
//  SJHCollectionProtocolTests.m
//  Collections
//
//  Created by James Heller on 10/2/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

#import "SJHCollectionProtocol.h"
#import "SJHListQueue.h"

static NSInteger kTestSize = 1000;

@interface SJHCollectionProtocolTests : SenTestCase

@property (strong, nonatomic) id<SJHCollectionProtocol> collection;

@property (strong, nonatomic) NSArray *standardTestData;

@end

@implementation SJHCollectionProtocolTests

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

- (void)test_testAdd{
    _collection = [[SJHListQueue alloc] init];
    [self add:_collection];
}

- (void)add:(id<SJHCollectionProtocol>)collection{
    
    [collection add:@"a"];
    STAssertTrue([[collection toArray] isEqualToArray:[self makeStringArray:@"a"]], @"Add failed");
    
    [collection add:@"b"];
    STAssertTrue([[collection toArray] isEqualToArray:[self makeStringArray:@"ab"]], @"Add failed");
    
    [collection add:@"c"];
    STAssertTrue([[collection toArray] isEqualToArray:[self makeStringArray:@"abc"]], @"Add failed");
    
    [collection add:@"d"];
    STAssertTrue([[collection toArray] isEqualToArray:[self makeStringArray:@"abcd"]], @"Add failed");
    
    [collection add:@"e"];
    STAssertTrue([[collection toArray] isEqualToArray:[self makeStringArray:@"abcde"]], @"Add failed");
    
    //next should fail on unstarted iterator after add
    [collection clear];
    STAssertTrue([collection count] == 0, @"Clear failed");
    
    [_collection addAll:_standardTestData];
    NSEnumerator *enumerator = [_collection enumerator];
    [_collection add:@"X"];
    @try {
        [enumerator nextObject];
        STFail(@"Should have thrown ConcurrentModificationException");
    }
    @catch (NSException *exception) {}
    
}

- (void)test_addAll{
    _collection = [[SJHListQueue alloc] init];
    [self addAll:_collection];
}

- (void)addAll:(id<SJHCollectionProtocol>)collection{
    [_collection addAll:_standardTestData];
    
    for (id object in _standardTestData) {
        STAssertTrue([_collection contains:object], @"Contains failed");
    }
}

//Remove must be tested individually, as different structures remove differently
//- (void)test_remove{}

- (void)test_clear{
    
}

- (void)test_peak{
    
}

- (void)test_isEmpty{
    
}

- (void)test_contains{
    
}

- (void)test_size{
    
}

- (void)test_toArray{
    
}

- (void)test_toString{
    
}

- (void)test_equals{
    
}

@end
