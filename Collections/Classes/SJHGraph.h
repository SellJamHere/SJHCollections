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
- (void)addEdgeWithOrigin:(id)originValue destination:(id)destinationValue weight:(id)weight;

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
- (NSUInteger)degree:(SJHGraphNode *)node;

- (NSArray *)allNodes;      
- (NSSet *)allEdges;

- (NSSet *)inNodes:(SJHGraphNode *)node;
- (NSSet *)outNodes:(SJHGraphNode *)node;
- (NSSet *)inEdges:(SJHGraphNode *)node;
- (NSSet *)outEdges:(SJHGraphNode *)node;

//Path finding
- (SJHGraph *)shortestPath:(SJHGraphNode *)source;
@end

//Internal Node Class
@interface SJHGraphNode : NSObject <NSCopying>

@property (strong, nonatomic) id value;

@property (strong, nonatomic) NSMutableSet *outgoingNodes;
@property (strong, nonatomic) NSMutableSet *incomingNodes;
@property (strong, nonatomic) NSMutableSet *outgoingEdges;
@property (strong, nonatomic) NSMutableSet *incomingEdges;

@property (strong, nonatomic) NSMutableDictionary *additionalInfo;

+ (SJHGraphNode *)nodeWithValue:(id)value;

- (id)initWithValue:(id)value;

- (BOOL)isEqualToGraphNode:(SJHGraphNode *)graphNode;

@end

//Internal Edge Class
@interface SJHGraphEdge : NSObject

@property (strong, nonatomic, readonly) SJHGraphNode *outgoingNode;
@property (strong, nonatomic, readonly) SJHGraphNode *incomingNode;
@property (strong, nonatomic) id weight; //Generally NSNumber, though other types are allowed
@property (strong, nonatomic) NSMutableDictionary *additionalInfo;

+ (SJHGraphEdge *)edgeWithIncomingNode:(SJHGraphNode *)incomingNode outgoingNode:(SJHGraphNode *)outgoingNode;
+ (SJHGraphEdge *)edgeWithIncomingNode:(SJHGraphNode *)incomingNode outgoingNode:(SJHGraphNode *)outgoingNode weight:(id)weight;

- (id)initWithIncomingNode:(SJHGraphNode *)incomingNode outgoingNode:(SJHGraphNode *)outgoingNode;
- (id)initWithIncomingNode:(SJHGraphNode *)incomingNode outgoingNode:(SJHGraphNode *)outgoingNode weight:(id)weight;

- (BOOL)isEqualToGraphEdge:(SJHGraphEdge *)graphEdge;

@end

