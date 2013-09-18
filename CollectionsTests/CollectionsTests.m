//
//  CollectionsUnitTests.m
//  CollectionsUnitTests
//
//  Created by James Heller on 9/18/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import "CollectionsTests.h"

#import "SJHOrderedDictionary.h"
#import "SJHMutableOrderedDictionary.h"

@implementation CollectionsTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    STFail(@"Unit tests are not implemented yet in SampleProjectTests");
}

- (void)test_ordered_dictionary{
    
    NSArray *testKeys = @[@0, @1, @2, @3];
    NSArray *testValues = @[@"Zero", @"One", @"Two", @"Three"];
    
    SJHOrderedDictionary *orderedDictionary = [[SJHOrderedDictionary alloc] initWithObjects:testValues forKeys:testKeys];
    
    NSInteger index = 0;
    for (id key in orderedDictionary) {
        STAssertTrue([[orderedDictionary objectForKey:key] isEqual:testValues[index]], [NSString stringWithFormat:@"Expected %@, recieved %@", testValues[index], [orderedDictionary objectForKey:key]]);
        index++;
    }
    
    STAssertTrue(false, @"False test");
    STAssertTrue(true, @"True test");
}

@end
