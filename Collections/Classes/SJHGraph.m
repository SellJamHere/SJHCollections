//
//  SJHGraph.m
//  Collections
//
//  Created by James Heller on 11/18/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import "SJHGraph.h"

#import "SJHGraphNode.h"
#import "SJHGraphEdge.h"

@interface SJHGraph()

/*
 * NSMutableDictionary *nodes:
 * Key: the node's (id) value
 * Value: the node itself
 */
@property (strong, nonatomic)NSMutableDictionary *nodes;

@property (strong, nonatomic)NSMutableSet *edges;

@end

@implementation SJHGraph

- (id)init{
    self = [super init];
    if(self){
        _nodes = [[NSMutableDictionary alloc] init];
        _edges = [[NSMutableSet alloc] init];
    }
    return self;
}

//Mutators
- (void)addNode:(SJHGraphNode *)node{
    [_nodes setObject:node forKey:node.value];
}

- (void)addEdge:(SJHGraphEdge *)edge{
    SJHGraphEdge *originalEdge;
    if((originalEdge = [_edges member:edge])){
        originalEdge.value = edge.value;
    }
    else{
        [_edges addObject:edge];
        if(![_nodes objectForKey:edge.incomingNode.value]){
            [_nodes setObject:edge.incomingNode forKey:edge.incomingNode.value];
        }
        if(![_nodes objectForKey:edge.outgoingNode.value]){
            [_nodes setObject:edge.outgoingNode forKey:edge.outgoingNode.value];
        }
    }
}

- (void)removeNode:(SJHGraphNode *)node{
    [_nodes removeObjectForKey:node.value];
}

- (void)removeEdge:(SJHGraphEdge *)edge{
    
}

- (void)clear{
    [_nodes removeAllObjects];
    [_edges removeAllObjects];
}

//Accessors
- (NSUInteger)nodeCount{
    return [_nodes count];
}

- (NSUInteger)edgeCount{
    return [_edges count];
}

- (BOOL)hasNode:(SJHGraphNode *)node{
    
}

- (BOOL)hasEdge:(SJHGraphEdge *)edge{
    
}

- (NSUInteger)inDegree{
    
}

- (NSUInteger)outDegree{
    
}

- (NSSet *)allNodes{
    return [NSSet setWithArray:[_nodes allValues]];
}

- (NSSet *)allEdges{
    return [_edges copy];
}

@end
