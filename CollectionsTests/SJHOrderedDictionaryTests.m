//
//  SJHOrderedDictionaryTests.m
//  Collections
//
//  Created by James Heller on 10/2/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

#import "CollectionsTests.h"

#import "SJHOrderedDictionary.h"

@interface SJHOrderedDictionaryTests : SenTestCase

@property (strong, nonatomic) NSMutableArray *testKeys;
@property (strong, nonatomic) NSMutableArray *testValues;

@end

@implementation SJHOrderedDictionaryTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    _testKeys = [[NSMutableArray alloc] initWithCapacity:kTestSize];
    _testValues = [[NSMutableArray alloc] initWithCapacity:kTestSize];
    
    for (NSInteger i = 0; i < kTestSize; i++) {
        [_testKeys addObject:[NSNumber numberWithInteger:i]];
        [_testValues addObject:[[NSNumber numberWithInteger:i] stringValue]];
    }
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)test_dictionary{
    STAssertTrue([[SJHOrderedDictionary dictionary] isKindOfClass:[SJHOrderedDictionary class]], @"Ordered Dictionary is not of proper class");
}

- (void)test_dictionaryWithCapacity{
    STAssertTrue([[SJHOrderedDictionary dictionaryWithCapacity:kTestSize] isKindOfClass:[SJHOrderedDictionary class]], @"Ordered Dictionary is not of proper class");
}

- (void)test_dictionaryWithObjects{
    
    SJHOrderedDictionary *mutableOrderedDictionary = [SJHOrderedDictionary dictionaryWithObjects:_testValues forKeys:_testKeys];
    
    NSInteger index = 0;
    for (id key in mutableOrderedDictionary) {
        NSString *value = [mutableOrderedDictionary objectForKey:key];
        STAssertTrue([value isEqualToString: [@(index) stringValue]], [NSString stringWithFormat:@"Value is expected to be %@, instead it is %@", [@(index) stringValue], value]);
        index++;
    }
}

- (void)test_initWithCapacity{
    //Capacity change doesn't actually cause test to fail
    STAssertTrue([[[SJHOrderedDictionary alloc] initWithCapacity:5] isKindOfClass:[SJHOrderedDictionary class]], @"Dictionary does not equal");
}

- (void)test_initWithObjects{
    
    SJHOrderedDictionary *mutableOrderedDictionary = [[SJHOrderedDictionary alloc] initWithObjects:_testValues forKeys:_testKeys];
    
    NSInteger index = 0;
    for (id key in mutableOrderedDictionary) {
        NSString *value = [mutableOrderedDictionary objectForKey:key];
        STAssertTrue([value isEqualToString: [@(index) stringValue]], [NSString stringWithFormat:@"Value is expected to be %@, instead it is %@", [@(index) stringValue], value]);
        index++;
    }
}

- (void)test_initWithOrderedDictionary{
    SJHOrderedDictionary *orderedDictionary = [[SJHOrderedDictionary alloc] initWithObjects:_testValues forKeys:_testKeys];
    
    SJHOrderedDictionary *otherOrderedDictionary = [[SJHOrderedDictionary alloc] initWithOrderedDictionary:orderedDictionary];
    
    STAssertTrue([orderedDictionary isEqual: otherOrderedDictionary], @"otherOrderedDictionary does not equal orderedDictionary");
}

- (void)test_count{
    SJHOrderedDictionary *mutableOrderedDictionary = [[SJHOrderedDictionary alloc] initWithObjects:@[@"Zero"] forKeys:@[@0]];
    
    STAssertTrue([mutableOrderedDictionary count] == 1, @"Expected 1, Received %d", [mutableOrderedDictionary count]);
    
    mutableOrderedDictionary = [[SJHOrderedDictionary alloc] initWithObjects:@[@"Zero", @"One"] forKeys:@[@0, @1]];
    
    STAssertTrue([mutableOrderedDictionary count] == 2, @"Expected 2, Received %d", [mutableOrderedDictionary count]);
    
    mutableOrderedDictionary = [[SJHOrderedDictionary alloc] initWithObjects:@[@"Zero", @"One", @"Two"] forKeys:@[@0, @1, @2]];
    
    STAssertTrue([mutableOrderedDictionary count] == 3, @"Expected 3, Received %d", [mutableOrderedDictionary count]);
    
    mutableOrderedDictionary = [[SJHOrderedDictionary alloc] initWithObjects:@[@"Zero", @"One", @"Two", @"ThreE"] forKeys:@[@0, @1, @2, @3]];
    
    STAssertTrue([mutableOrderedDictionary count] == 4, @"Expected 4, Received %d", [mutableOrderedDictionary count]);
}

- (void)test_objectAtIndex{
    
    SJHOrderedDictionary *mutableOrderedDictionary = [[SJHOrderedDictionary alloc] initWithObjects:_testValues forKeys:_testKeys];
    
    NSInteger index = 0;
    for (id key in mutableOrderedDictionary) {
        
        STAssertTrue([[mutableOrderedDictionary objectForKey:key] isEqual:_testValues[index]], [NSString stringWithFormat:@"Expected %@, recieved %@", _testValues[index], [mutableOrderedDictionary objectForKey:key]]);
        index++;
    }
}

- (void)test_setObject{
    
    SJHOrderedDictionary *mutableOrderedDictionary = [[SJHOrderedDictionary alloc] initWithCapacity:10];
    
    for (NSInteger i = 0; i < 10; i++) {
        [mutableOrderedDictionary setObject:[@(i) stringValue] forKey:@(i)];
        STAssertTrue([[mutableOrderedDictionary objectForKey:@(i)] isEqual:[@(i) stringValue]], @"Object not found");
    }
}

- (void)test_removeObject{
    SJHOrderedDictionary *mutableOrderedDictionary = [[SJHOrderedDictionary alloc] initWithCapacity:10];
    
    for (NSInteger i = 0; i < 10; i++) {
        [mutableOrderedDictionary setObject:[@(i) stringValue] forKey:@(i)];
        STAssertTrue([[mutableOrderedDictionary objectForKey:@(i)] isEqual:[@(i) stringValue]], @"Object not found");
    }
    
    for (NSInteger i = 0; i < 10; i++) {
        [mutableOrderedDictionary removeObjectForKey:@(i)];
        STAssertNil([mutableOrderedDictionary objectForKey:@(i)], @"Object not removed");
    }
}

- (void)test_removeAll{
    SJHOrderedDictionary *mutableOrderedDictionary = [[SJHOrderedDictionary alloc] initWithCapacity:10];
    
    NSInteger i;
    for (i = 0; i < 10; i++) {
        [mutableOrderedDictionary setObject:[@(i) stringValue] forKey:@(i)];
        STAssertTrue([[mutableOrderedDictionary objectForKey:@(i)] isEqual:[@(i) stringValue]], @"Object not found");
    }
    
    STAssertTrue(i == [mutableOrderedDictionary count], @"Count incorrect");
    
    [mutableOrderedDictionary removeAllObjects];
    
    STAssertTrue([mutableOrderedDictionary count] == 0, @"Dictionary not empty");
}

@end
