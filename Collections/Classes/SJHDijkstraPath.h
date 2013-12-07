//
//  SJHDijkstraPath.h
//  Collections
//
//  Created by James Heller on 12/6/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SJHGraph, SJHGraphNode;

@interface SJHDijkstraPath : NSObject

- (id)initWithGraph:(SJHGraph *)graph;

- (SJHGraph *)pathTree:(SJHGraphNode *)source;

- (void)setGraph:(SJHGraph *)graph;

@end
