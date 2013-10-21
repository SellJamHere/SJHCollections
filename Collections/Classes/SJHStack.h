//
//  SJHStack.h
//  Collections
//
//  Created by James Heller on 9/25/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

/* 
 * SJHStack is implemented by extending NSMutableArray. This
 * isn't ideal, as all NSMutableArray methods are accessable.
 * A more perfect solution is to create a whole new class
 * implementing the same interfaces as NSMutableArray
 */

#import <Foundation/Foundation.h>

@interface SJHStack : NSMutableArray

+ (id)stackWithObjects:(NSArray *)array;

- (void)push:(id)object;
- (id)pop;
- (id)peek;

@end
