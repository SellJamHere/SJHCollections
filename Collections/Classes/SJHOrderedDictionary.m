//
//  SJHMutableOrderedDictionary.m
//  Collections
//
//  Created by James Heller on 9/17/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import "SJHOrderedDictionary.h"

@interface SJHOrderedDictionary ()

@property (strong, nonatomic) NSMutableArray *keys;
@property (strong, nonatomic) NSMutableDictionary *dictionary;

@end

@implementation SJHOrderedDictionary

#pragma mark Creating
+ (id)dictionary{
    return [[self alloc] init];
}

+ (id)dictionaryWithCapacity:(NSUInteger)numItems{
    return [[self alloc] initWithCapacity:numItems];
}

+ (id)dictionaryWithObjects:(NSArray *)objects forKeys:(NSArray *)keys{
    return [[SJHOrderedDictionary alloc] initWithObjects:objects forKeys:keys];
}

#pragma mark Initializing
- (id)init{
    self = [super init];
    if (self){
        _dictionary = [[NSMutableDictionary alloc] init];
        _keys = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithCapacity:(NSUInteger)capacity
{
    self = [super init];
    if (self){
        _dictionary = [[NSMutableDictionary alloc] initWithCapacity:capacity];
        _keys = [[NSMutableArray alloc] initWithCapacity:capacity];
    }
    return self;
}

- (id)initWithObjects:(NSArray *)objects forKeys:(NSArray *)keys{
    
    if ([objects count] != [keys count]){
        [NSException raise:@"SJHMutableOrderedDictionary initWithObjects" format:@"objects and keys are not the same size"];
    }
    
    self = [super init];
    if (self){
//        NSMutableArray *tempKeys = [[NSMutableArray alloc] initWithCapacity:[keys count]];
//        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] initWithCapacity:[objects count]];
//        
//        for (int i = 0; i < [keys count]; i++) {
//            [tempKeys addObject:keys[i]];
//            [tempDict setObject:objects[i] forKey:keys[i]];
//        }
        
        _keys = [keys mutableCopy];
        _dictionary = [[NSMutableDictionary alloc] initWithObjects:objects forKeys:_keys];
    }
    return self;
}

- (id)initWithOrderedDictionary:(SJHOrderedDictionary *)orderedDictionary{
    
    self = [super init];
    
    if (self){
        _keys = [orderedDictionary.keys mutableCopy];
        _dictionary = [orderedDictionary.dictionary mutableCopy];
    }
    return self;
}

#pragma mark Adding and Removing
//Duplicate keys are allowed, stored in order. Duplicate keys reference the same value in _dictionary
- (void)setObject:(id)anObject forKey:(id <NSCopying>)aKey{

    [_keys addObject:aKey];
    [_dictionary setObject:anObject forKey:aKey];
}

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey afterKey:(id<NSCopying>)searchKey{
    
    NSInteger index = [_keys indexOfObject:searchKey];
    [_keys insertObject:aKey atIndex:++index];
    [_dictionary setObject:anObject forKey:aKey];
}

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey beforeKey:(id<NSCopying>)searchKey{
    
    NSInteger index = [_keys indexOfObject:searchKey];
    [_keys insertObject:aKey atIndex:index];
    [_dictionary setObject:anObject forKey:aKey];
}

- (void)removeObjectForKey:(id)aKey{
    [_dictionary removeObjectForKey:aKey];
    [_keys removeObject:aKey];
}

- (void)removeObjectAtIndex:(NSUInteger)index{
    id key = [_keys objectAtIndex:index];
    [_keys removeObjectAtIndex:index];
    [_dictionary removeObjectForKey:key];
}

- (void)removeAllObjects{
    [_keys removeAllObjects];
    [_dictionary removeAllObjects];
}

#pragma mark Count
- (NSUInteger)count{
    return [_dictionary count];
}

#pragma mark Accessing Keys and Values
- (id)objectForKey:(id)aKey{
    return [_dictionary objectForKey:aKey];
}

- (id)keyForObject:(id)anObject{
    
    __block id searchKey;
    
    [_dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
        if ([anObject isEqual:obj]) {
            searchKey = key;
            *stop = YES;
        }
    }];
    
    return searchKey;
}

- (id)keyForObjectAtIndex:(NSUInteger)index{
    return [_keys objectAtIndex:index];
}

- (NSUInteger)indexOfObject:(id)object{
    return [_keys indexOfObject:[self keyForObject:object]];
}

- (NSUInteger)indexOfObjectWithKey:(id)aKey{
    return [_keys indexOfObject:aKey];
}

- (id)objectAtIndex:(NSInteger)index{
    return [_dictionary objectForKey:[_keys objectAtIndex:index]];
}

- (NSArray *)allKeys{
    return [_keys copy];
}

- (NSArray *)allValues{
    return [_dictionary allValues];
}

#pragma mark Enumerating
- (NSEnumerator *)keyEnumerator{
    return [_keys objectEnumerator];
}

- (NSEnumerator *)reverseKeyEnumerator{
    return [_keys reverseObjectEnumerator];
}

- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(id key, id obj, BOOL *stop))block{
    [_keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj, [_dictionary objectForKey:obj], stop);
    }];
}

#pragma mark Equality
- (BOOL)isEqual:(id)object{
    if (object == self){
        return YES;
    }
    
    //There is only one instance of each class, hence == is acceptable
    if([object class] == [self class]){
        SJHOrderedDictionary *orderedDictionary = object;
        return [_keys isEqualToArray:orderedDictionary.keys] && [_dictionary isEqualToDictionary:orderedDictionary.dictionary];
    }
    
    return NO;
}

//Requires otherDictionary to be an orderedDictionary
//Note: Comparing [orderedDictionary isEqualToDictionary dictionary] (returns NO) is not
//the same as comparing [dictionary isEqualToDictionary orderedDictionary] (returns YES)
- (BOOL)isEqualToDictionary:(NSDictionary *)otherDictionary{
    return [self isEqual:otherDictionary];
}

#pragma mark Copying
//Normally copy returns an immutable copy, but, as there is no immutable
//SJHOrderedDictionary, it merely returns a mutable copy
- (id)copy{
    return [self mutableCopy];
}

- (id)mutableCopy{
    SJHOrderedDictionary *copy = [[[self class] alloc] init];
    
    if (copy){
        for (id key in _keys) {
            [copy setObject:[_dictionary objectForKey:key] forKey:key];
        }
    }
    
    return copy;
}

@end