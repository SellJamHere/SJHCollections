//
//  SJHMutableOrderedDictionary.h
//  Collections
//
//  Created by James Heller on 9/17/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJHOrderedDictionary : NSMutableDictionary

//Initializing
- (id)initWithOrderedDictionary:(SJHOrderedDictionary *)orderedDictionary;

//Adding and Removing
- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey afterKey:(id<NSCopying>)searchKey;
- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey beforeKey:(id<NSCopying>)searchKey;

- (void)removeObjectAtIndex:(NSUInteger)index;

//Accessing Keys and Values
- (id)keyForObject:(id)anObject;
- (id)keyForObjectAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfObject:(id)object;
- (NSUInteger)indexOfObjectWithKey:(id)key;

//Enumerating
- (NSEnumerator *)reverseKeyEnumerator;

@end