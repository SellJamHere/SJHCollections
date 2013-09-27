//
//  SJHCollectionProtocol.h
//  Collections
//
//  Created by James Heller on 9/26/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SJHCollectionProtocol <NSObject, NSCopying> //Someday, implement NSFastEnumeration

//Insertion and removal
- (BOOL)add:(id)object;
- (BOOL)addAll:(id<NSFastEnumeration>)objects;
- (id)remove;
- (void)clear;

//Queries
- (id)peak;
- (BOOL)isEmpty;
- (NSInteger)count;

//Misc
- (NSEnumerator *)enumerator;
- (NSArray *)toArray;
- (id<SJHCollectionProtocol>)copy;

//Inherited
- (NSString *)description;
- (BOOL)isEqual:(id)object;
- (NSInteger)hash;

@end
