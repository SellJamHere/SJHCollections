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

#pragma mark Creating a Dictionary
+ (id)mutableOrderedDictionaryWithObjects:(NSArray *)objects andKeys:(NSArray *)keys{
    return [[SJHOrderedDictionary alloc] initWithObjects:objects forKeys:keys];
}

#pragma mark Initializing a Dictionary

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
        NSMutableArray *tempKeys = [[NSMutableArray alloc] initWithCapacity:[keys count]];
        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] initWithCapacity:[objects count]];
        
        for (int i = 0; i < [keys count]; i++) {
            [tempKeys addObject:keys[i]];
            [tempDict setObject:objects[i] forKey:keys[i]];
        }
        
        _keys = [tempKeys copy];
        _dictionary = [tempDict copy];
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

#pragma mark Adding and Removing From a Dictionary
//If aKey already exists in the dictionary anObject takes its place.
- (void)setObject:(id)anObject forKey:(id <NSCopying>)aKey{
    if (![_dictionary objectForKey:aKey])
    {
        [_keys addObject:aKey];
    }
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

#pragma mark Count

- (NSUInteger)count{
    return [_dictionary count];
}

#pragma mark Accessing Keys and Values

- (id)objectForKey:(id)aKey{
    return [_dictionary objectForKey:aKey];
}

- (NSArray *)allKeys{
    return [_keys copy];
}

- (NSArray *)allValues{
    return [_dictionary allValues];
}

#pragma mark Enumerating Dictionaries

- (NSEnumerator *)keyEnumerator{
    return [_keys objectEnumerator];
}

- (NSEnumerator *)reverseKeyEnumerator{
    return [_keys reverseObjectEnumerator];
}

#pragma mark Copying Dictionaries
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
