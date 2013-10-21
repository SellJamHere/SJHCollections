//
//  SJHStack.m
//  Collections
//
//  Created by James Heller on 9/25/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import "SJHStack.h"

@interface SJHStack ()

@property (strong, nonatomic) NSMutableArray *array;

@end

@implementation SJHStack

+ (id)stackWithObjects:(NSArray *)array{
    return [[SJHStack alloc] initWithArray:array];
}

- (id)init{
    self = [super init];
    if (self){
        _array = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithCapacity:(NSUInteger)numItems{
    self = [super init];
    if (self){
        _array = [[NSMutableArray alloc] initWithCapacity:numItems];
    }
    return self;
}

- (id)initWithArray:(NSArray *)array{
    self = [super init];
    if (self){
        _array = [[NSMutableArray alloc] initWithCapacity:[array count]];
        
        for (id object in array) {
            [_array addObject:object];
        }
    }
    return self;
}

- (void)push:(id)object{
    [_array addObject:object];
}

- (id)pop{
    id object = [_array lastObject];
    [_array removeLastObject];
    return object;
    
}

- (id)peek{
    return [_array lastObject];
}

#pragma mark - NSArray Overrides
- (id)objectAtIndex:(NSUInteger)index{
    return [_array objectAtIndex:index];
}

- (NSUInteger)count{
    return [_array count];
}

#pragma mark - NSMutableArray Overrides

//Always inserts to rear
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index{
//    [self push:anObject];
    [NSException raise:@"Stack Insert" format:@"Cannot insert object at index"];
}

//Always removes from rear
- (void)removeObjectAtIndex:(NSUInteger)index{
//    [self pop];
    [NSException raise:@"Stack Remove" format:@"Cannot remove object at index"];
}

//Same functionality as push
- (void)addObject:(id)anObject{
    [self push:anObject];
}

- (void)removeLastObject{
    [NSException raise:@"Stack Remove" format:@"Use pop"];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
    [NSException raise:@"Stack Replace" format:@"Cannot replace an object in a stack"];
}

@end
