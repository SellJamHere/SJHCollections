//
//  SJHMutableOrderedDictionary.m
//  Collections
//
//  Created by James Heller on 9/17/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import "SJHMutableOrderedDictionary.h"

@interface SJHMutableOrderedDictionary ()

@property (strong, nonatomic) NSMutableArray *keys;
@property (strong, nonatomic) NSMutableDictionary *dictionary;

@end

@implementation SJHMutableOrderedDictionary

+ (id)mutableOrderedDictionaryWithObjects:(NSArray *)objects andKeys:(NSArray *)keys{
    return [[SJHMutableOrderedDictionary alloc] initWithObjects:objects forKeys:keys];
}

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

-(id)initWithObjects:(NSArray *)objects forKeys:(NSArray *)keys{
    self = [super init];
    if(self){
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

//If aKey already exists in the dictionary anObject takes its place.
- (void)setObject:(id)anObject forKey:(id <NSCopying>)aKey{
    if (![_dictionary objectForKey:aKey])
    {
        [_keys addObject:aKey];
    }
    [_dictionary setObject:anObject forKey:aKey];
}

- (void)removeObjectForKey:(id)aKey{
    [_dictionary removeObjectForKey:aKey];
    [_keys removeObject:aKey];
}

- (NSUInteger)count{
    return [_dictionary count];
}

- (id)objectForKey:(id)aKey{
    return [_dictionary objectForKey:aKey];
}

- (NSEnumerator *)keyEnumerator{
    return [_keys objectEnumerator];
}

- (NSArray *)allKeys{
    return _keys;
}

@end
