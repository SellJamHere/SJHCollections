//
//  SJHGraph.h
//  Collections
//
//  Created by James Heller on 11/18/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SJHGraphNode, SJHGraphEdge;

@interface SJHGraph : NSObject

//Mutators
- (void)addNode:(SJHGraphNode *)node;
- (void)addNodeWithValue:(id)value;

- (void)addEdge:(SJHGraphEdge *)edge;

- (void)removeNode:(SJHGraphNode *)node;
- (void)removeEdge:(SJHGraphEdge *)edge;

- (void)clear;

//Accessors
- (NSUInteger)nodeCount;
- (NSUInteger)edgeCount;
- (BOOL)hasNode:(SJHGraphNode *)node;
- (BOOL)hasEdge:(SJHGraphEdge *)edge;

- (NSUInteger)inDegree:(SJHGraphNode *)node;
- (NSUInteger)outDegree:(SJHGraphNode *)node;

- (NSSet *)allNodes;
- (NSSet *)allEdges;


@end
