//
//  SJHListQueue.h
//  Collections
//
//  Created by James Heller on 9/26/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SJHCollectionProtocol.h"

@interface SJHListQueue : NSObject <SJHCollectionProtocol>

- (id)init;
- (id)initWithIterable:(id<NSFastEnumeration>)iterable;

@end
