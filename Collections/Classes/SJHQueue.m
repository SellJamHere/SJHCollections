//
//  SJHQueue.m
//  Collections
//
//  Created by James Heller on 10/19/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import "SJHQueue.h"

@interface SJHQueue ()

@property (strong, nonatomic) NSMutableArray *array;

@end

@implementation SJHQueue

+ (id)queueWithObjects:(NSArray *)array{
    return [[SJHQueue alloc] initWithArray:array];
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

- (void)add:(id)object{
    [_array addObject:object];
}

- (id)remove{
    id object = [_array objectAtIndex:0];
    [_array removeObjectAtIndex:0];
    return object;
}

- (id)peek{
    return [_array objectAtIndex:0];
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
    [NSException raise:@"Queue Insert" format:@"Cannot insert object at index"];
}

//Always removes from rear
- (void)removeObjectAtIndex:(NSUInteger)index{
    //    [self pop];
    [NSException raise:@"Queue Remove" format:@"Cannot remove object at index"];
}

//Same functionality as push
- (void)addObject:(id)anObject{
    [self add:anObject];
}

- (void)removeLastObject{
    [NSException raise:@"Queue Remove" format:@"Use remove"];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
    [NSException raise:@"Queue Replace" format:@"Cannot replace an object in a queue"];
}

@end
