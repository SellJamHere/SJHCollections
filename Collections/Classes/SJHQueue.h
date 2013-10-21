//
//  SJHQueue.h
//  Collections
//
//  Created by James Heller on 10/19/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJHQueue : NSMutableArray

+ (id)queueWithObjects:(NSArray *)array;

- (void)add:(id)object;
- (id)remove;
- (id)peek;

@end
