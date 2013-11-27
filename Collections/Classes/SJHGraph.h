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
/**
 * Add an edge to this graph
 * If the edge is already in the graph, change its value to this value;
 *   otherwise, add a new edge.
 * If the origin or destination nodes are not in the graph,
 *   add them as well.
 *
 * @param edge  The edge to add to this graph.
 * @param value The value of the edge.
 */
- (void)addEdge:(SJHGraphEdge *)edge;

- (void)removeNode:(SJHGraphNode *)node;
- (void)removeEdge:(SJHGraphEdge *)edge;

- (void)clear;

//Accessors
- (NSUInteger)nodeCount;
- (NSUInteger)edgeCount;
- (BOOL)hasNode:(SJHGraphNode *)node;
- (BOOL)hasEdge:(SJHGraphEdge *)edge;

- (NSUInteger)inDegree;
- (NSUInteger)outDegree;

- (NSSet *)allNodes;
- (NSSet *)allEdges;


@end
