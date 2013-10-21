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
#import "SJHMutableOrderedDictionary.h"

@interface SJHOrderedDictionaryTests : SenTestCase

@end

@implementation SJHOrderedDictionaryTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testExample{}

#pragma mark - OrderedDictionary

- (void)test_ordered_dictionary_initWithObjects{
    
    NSArray *testKeys = @[@0, @1, @2, @3];
    NSArray *testValues = @[@"Zero", @"One", @"Two", @"Three"];
    
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjects:testValues forKeys:testKeys];
    
    SJHOrderedDictionary *orderedDictionary = [[SJHOrderedDictionary alloc] initWithObjects:testValues forKeys:testKeys];
    
    STAssertTrue([orderedDictionary isEqualToDictionary:dictionary], @"Dictionary does not equal");
}

- (void)test_ordered_dictionary_dictionaryWithObjects{
    
    NSArray *testKeys = @[@0, @1, @2, @3];
    NSArray *testValues = @[@"Zero", @"One", @"Two", @"Three"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:testValues forKeys:testKeys];
    
    SJHOrderedDictionary *orderedDictionary = [SJHOrderedDictionary dictionaryWithObjects:testValues forKeys:testKeys];
    
    STAssertTrue([orderedDictionary isEqualToDictionary:dictionary], @"Dictionary does not equal");
}

- (void)test_ordered_dictionary_count{
    SJHOrderedDictionary *orderedDictionary = [[SJHOrderedDictionary alloc] initWithObjects:@[@"Zero"] forKeys:@[@0]];
    
    STAssertTrue([orderedDictionary count] == 1, @"Expected 1, Received %d", [orderedDictionary count]);
    
    orderedDictionary = [[SJHOrderedDictionary alloc] initWithObjects:@[@"Zero", @"One"] forKeys:@[@0, @1]];
    
    STAssertTrue([orderedDictionary count] == 2, @"Expected 2, Received %d", [orderedDictionary count]);
    
    orderedDictionary = [[SJHOrderedDictionary alloc] initWithObjects:@[@"Zero", @"One", @"Two"] forKeys:@[@0, @1, @2]];
    
    STAssertTrue([orderedDictionary count] == 3, @"Expected 3, Received %d", [orderedDictionary count]);
    
    orderedDictionary = [[SJHOrderedDictionary alloc] initWithObjects:@[@"Zero", @"One", @"Two", @"ThreE"] forKeys:@[@0, @1, @2, @3]];
    
    STAssertTrue([orderedDictionary count] == 4, @"Expected 4, Received %d", [orderedDictionary count]);
}

- (void)test_ordered_dictionary_objectAtIndex{
    NSArray *testKeys = @[@0, @1, @2, @3];
    NSArray *testValues = @[@"Zero", @"One", @"Two", @"Three"];
    
    SJHOrderedDictionary *orderedDictionary = [[SJHOrderedDictionary alloc] initWithObjects:testValues forKeys:testKeys];
    
    NSInteger index = 0;
    for (id key in orderedDictionary) {
        
        STAssertTrue([[orderedDictionary objectForKey:key] isEqual:testValues[index]], [NSString stringWithFormat:@"Expected %@, recieved %@", testValues[index], [orderedDictionary objectForKey:key]]);
        index++;
    }
}

#pragma mark - MutableOrderedDictionary

- (void)test_mutable_ordered_dictionary_initWithCapacity{
    //Capacity change doesn't actually cause test to fail
    STAssertTrue([[[SJHMutableOrderedDictionary alloc] initWithCapacity:5] isEqualToDictionary:[[NSMutableDictionary alloc] initWithCapacity:5]], @"Dictionary does not equal");
}

- (void)test_mutable_ordered_dictionary_initWithObjects{
    NSArray *testKeys = @[@0, @1, @2, @3];
    NSArray *testValues = @[@"Zero", @"One", @"Two", @"Three"];
    
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjects:testValues forKeys:testKeys];
    
    SJHMutableOrderedDictionary *mutableOrderedDictionary = [[SJHMutableOrderedDictionary alloc] initWithObjects:testValues forKeys:testKeys];
    
    STAssertTrue([mutableOrderedDictionary isEqualToDictionary:dictionary], @"Dictionary does not equal");
}

- (void)test_mutable_ordered_dictionary_dictionaryWithObjects{
    
    NSArray *testKeys = @[@0, @1, @2, @3];
    NSArray *testValues = @[@"Zero", @"One", @"Two", @"Three"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:testValues forKeys:testKeys];
    
    SJHMutableOrderedDictionary *mutableOrderedDictionary = [SJHMutableOrderedDictionary dictionaryWithObjects:testValues forKeys:testKeys];
    
    STAssertTrue([mutableOrderedDictionary isEqualToDictionary:dictionary], @"Dictionary does not equal");
}

- (void)test_mutable_ordered_dictionary_count{
    SJHMutableOrderedDictionary *mutableOrderedDictionary = [[SJHMutableOrderedDictionary alloc] initWithObjects:@[@"Zero"] forKeys:@[@0]];
    
    STAssertTrue([mutableOrderedDictionary count] == 1, @"Expected 1, Received %d", [mutableOrderedDictionary count]);
    
    mutableOrderedDictionary = [[SJHMutableOrderedDictionary alloc] initWithObjects:@[@"Zero", @"One"] forKeys:@[@0, @1]];
    
    STAssertTrue([mutableOrderedDictionary count] == 2, @"Expected 2, Received %d", [mutableOrderedDictionary count]);
    
    mutableOrderedDictionary = [[SJHMutableOrderedDictionary alloc] initWithObjects:@[@"Zero", @"One", @"Two"] forKeys:@[@0, @1, @2]];
    
    STAssertTrue([mutableOrderedDictionary count] == 3, @"Expected 3, Received %d", [mutableOrderedDictionary count]);
    
    mutableOrderedDictionary = [[SJHMutableOrderedDictionary alloc] initWithObjects:@[@"Zero", @"One", @"Two", @"ThreE"] forKeys:@[@0, @1, @2, @3]];
    
    STAssertTrue([mutableOrderedDictionary count] == 4, @"Expected 4, Received %d", [mutableOrderedDictionary count]);
}

- (void)test_mutable_ordered_dictionary_objectAtIndex{
    NSArray *testKeys = @[@0, @1, @2, @3];
    NSArray *testValues = @[@"Zero", @"One", @"Two", @"Three"];
    
    SJHMutableOrderedDictionary *mutableOrderedDictionary = [[SJHMutableOrderedDictionary alloc] initWithObjects:testValues forKeys:testKeys];
    
    NSInteger index = 0;
    for (id key in mutableOrderedDictionary) {
        
        STAssertTrue([[mutableOrderedDictionary objectForKey:key] isEqual:testValues[index]], [NSString stringWithFormat:@"Expected %@, recieved %@", testValues[index], [mutableOrderedDictionary objectForKey:key]]);
        index++;
    }
}

- (void)test_mutable_ordered_dictionary_setObject{
    
    SJHMutableOrderedDictionary *mutableOrderedDictionary = [[SJHMutableOrderedDictionary alloc] initWithCapacity:10];
    
    for (NSInteger i = 0; i < 10; i++) {
        [mutableOrderedDictionary setObject:[@(i) stringValue] forKey:@(i)];
        STAssertTrue([[mutableOrderedDictionary objectForKey:@(i)] isEqual:[@(i) stringValue]], @"Object not found");
    }
}

- (void)test_mutable_ordered_dictionary_removeObject{
    SJHMutableOrderedDictionary *mutableOrderedDictionary = [[SJHMutableOrderedDictionary alloc] initWithCapacity:10];
    
    for (NSInteger i = 0; i < 10; i++) {
        [mutableOrderedDictionary setObject:[@(i) stringValue] forKey:@(i)];
        STAssertTrue([[mutableOrderedDictionary objectForKey:@(i)] isEqual:[@(i) stringValue]], @"Object not found");
    }
    
    for (NSInteger i = 0; i < 10; i++) {
        [mutableOrderedDictionary removeObjectForKey:@(i)];
        STAssertNil([mutableOrderedDictionary objectForKey:@(i)], @"Object not removed");
    }
}

- (void)test_mutable_ordered_dictionary_removeAll{
    SJHMutableOrderedDictionary *mutableOrderedDictionary = [[SJHMutableOrderedDictionary alloc] initWithCapacity:10];
    
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
