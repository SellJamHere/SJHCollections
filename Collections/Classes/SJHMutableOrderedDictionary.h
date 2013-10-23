//
//  SJHMutableOrderedDictionary.h
//  Collections
//
//  Created by James Heller on 9/17/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJHMutableOrderedDictionary : NSMutableDictionary

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey afterKey:(id<NSCopying>)searchKey;
- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey beforeKey:(id<NSCopying>)searchKey;

@end
