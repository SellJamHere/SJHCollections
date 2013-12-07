//
//  SJHDijkstraPath.m
//  Collections
//
//  Created by James Heller on 12/6/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import "SJHDijkstraPath.h"

#import "SJHGraph.h"

@interface SJHDijkstraPath ()

@property (weak, nonatomic) SJHGraph *graph;

@property (strong, nonatomic) NSArray *allNodes;

@property (strong, nonatomic) NSMutableArray *visited;
@property (strong, nonatomic) NSMutableArray *distance;
@property (strong, nonatomic) NSMutableArray *previous;

@end

@implementation SJHDijkstraPath

- (id)initWithGraph:(SJHGraph *)graph{
    self = [super init];
    if(self){
        _graph = graph;
        [self initializeInternalStructures];
    }
    return self;
}

- (id)init{
    self = [self initWithGraph:nil];
    return self;
}

//used internally any time _graph is set
- (void)initializeInternalStructures{
    _allNodes = [_graph allNodes];
    
    NSUInteger count = [_graph nodeCount];
    _visited = [[NSMutableArray alloc] initWithCapacity:count];
    _distance = [[NSMutableArray alloc] initWithCapacity:count];
    _previous = [[NSMutableArray alloc] initWithCapacity:count];
}

- (SJHGraph *)pathTree:(SJHGraphNode *)source{
    
    NSUInteger sourceIndex = [_allNodes indexOfObject:source];
    
    NSMutableArray *unfinished = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < [_allNodes count]; i++) {
        
        _distance[i] = [NSNumber numberWithFloat:INFINITY];
        _visited[i] = [NSNumber numberWithBool:NO];
        _previous[i] = [NSNull null];
    }
    
    _distance[sourceIndex] = @0.0;
    [unfinished addObject:source];
    
    while ([unfinished count] > 0) {
        NSInteger index = [self smallestNodeOfAllNodes:_allNodes withUnfinished:unfinished];
        SJHGraphNode *node = _allNodes[index];
        [unfinished removeObject: node];
        _visited[index] = [NSNumber numberWithBool:YES];
        
        for (SJHGraphEdge *edge in node.outgoingEdges) {
            float altDist = [_distance[index] floatValue] + [(NSNumber *)edge.weight floatValue];
            NSInteger edgeOutgoingNodeIndex = [_allNodes indexOfObject:edge.outgoingNode];
            if (altDist < [_distance[edgeOutgoingNodeIndex] floatValue]) {
                _distance[edgeOutgoingNodeIndex] = [NSNumber numberWithFloat:altDist];
                _previous[edgeOutgoingNodeIndex] = node;
                if(![_visited[edgeOutgoingNodeIndex] boolValue]){
                    [unfinished addObject:_allNodes[edgeOutgoingNodeIndex]];
                }
            }
        }
    }
    
    //convert previous[] to a graph
    SJHGraph *pathGraph = [[SJHGraph alloc] init];
    NSInteger i = 0;
    for (SJHGraphNode *node in _allNodes) {
        SJHGraphNode *previous = _previous[i];
        if(![previous isKindOfClass:[NSNull class]])
        [pathGraph addEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:previous.value] outgoingNode:[SJHGraphNode nodeWithValue:node.value]]];
        i++;
    }
    
    return pathGraph;
}

//returns index in terms of _distance and _nodes,
- (NSInteger)smallestNodeOfAllNodes:(NSArray *)allNodes withUnfinished:(NSArray *)unfinished{
    
    NSInteger index = [allNodes indexOfObject:unfinished[0]];
    
    float smallestDist = [_distance[index] floatValue];

    //for each node in unfinished
    for (SJHGraphNode *node in unfinished) {
        NSInteger i = [allNodes indexOfObject:node];
        
        if ([_distance[i] floatValue] < smallestDist) {
            index = i;
        }
    }
    
    return index;
}

- (void)setGraph:(SJHGraph *)graph{
    _graph = graph;
    [self initializeInternalStructures];
}

@end
