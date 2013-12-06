//
//  SJHGraph.m
//  Collections
//
//  Created by James Heller on 11/18/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import "SJHGraph.h"

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
    if(![_nodes objectForKey:node.value]){
        [_nodes setObject:node forKey:node.value];
    }
}

- (void)addNodeWithValue:(id)value{
    SJHGraphNode *node = [[SJHGraphNode alloc] initWithValue:value];
    [self addNode:node];
}

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
- (void)addEdge:(SJHGraphEdge *)edge{
    SJHGraphEdge *originalEdge = [_edges member:edge];
    if(originalEdge){
        originalEdge.weight = edge.weight;
    }
    else{
        SJHGraphNode *outgoingNode = [_nodes objectForKey: [edge.outgoingNode value]];
        SJHGraphNode *incomingNode = [_nodes objectForKey: [edge.incomingNode value]];
        
        if(!outgoingNode){
            outgoingNode = edge.outgoingNode;
        }
        if(!incomingNode){
            incomingNode = edge.incomingNode;
        }
        
        if(![_nodes objectForKey:incomingNode.value]){
            [_nodes setObject:incomingNode forKey:edge.incomingNode.value];
        }
        if(![_nodes objectForKey:outgoingNode.value]){
            [_nodes setObject:outgoingNode forKey:edge.outgoingNode.value];
        }
        
        [outgoingNode.incomingNodes addObject:incomingNode];
        [outgoingNode.incomingEdges addObject:edge];
        
        [incomingNode.outgoingNodes addObject:outgoingNode];
        [incomingNode.outgoingEdges addObject:edge];
        
        [_edges addObject:edge];
    }
}

- (void)addEdgeWithOrigin:(id)originValue destination:(id)destinationValue weight:(id)weight{
    [self addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[SJHGraphNode nodeWithValue:originValue] outgoingNode:[SJHGraphNode nodeWithValue:destinationValue] weight:weight]];
}

/**
 * Remove a node from this graph
 * If the node is in the graph, remove all edges connected
 *   to it (and update the local information for the other
 *   nodes affected by the edge removal); if not, make no changes.
 *
 * @param nodeName - the name of the node to remove from this graph.
 */
- (void)removeNode:(SJHGraphNode *)node{
    SJHGraphNode *internalNode = [_nodes objectForKey:node.value];
    
    if(internalNode){
        //copy of outgoingEdges to prevent fast enumeration mutation errors
        for (SJHGraphEdge *edge in [internalNode.outgoingEdges copy]){
            [self removeEdge:edge];
        }
        for (SJHGraphEdge *edge in [internalNode.incomingEdges copy]) {
            [self removeEdge:edge];
        }
        
        [_nodes removeObjectForKey:internalNode.value];
    }
}

/**
 * Remove an edge from this graph
 * incomingNode and outgoingNode are taken from self.nodes, as an edge can
 * be created with new nodes of the same value, which will prevent the proper
 * internal nodes from being updated.
 *
 * @param edge  - the edge to remove from this graph.
 */
- (void)removeEdge:(SJHGraphEdge *)edge{
    //remove edge and edge.outgoingNode from edge.incomingNode
    SJHGraphNode *incomingNode = [_nodes objectForKey:edge.incomingNode.value];
    [incomingNode.outgoingNodes removeObject:edge.outgoingNode];
    [incomingNode.outgoingEdges removeObject:edge];
    
    //remove edge and edge.incomingNode edge.outgoingNode
    SJHGraphNode *outgoingNode = [_nodes objectForKey:edge.outgoingNode.value];
    [outgoingNode.incomingNodes removeObject:edge.incomingNode];
    [outgoingNode.incomingEdges removeObject:edge];
    
    [_edges removeObject:edge];
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
    return ([_nodes objectForKey:node.value] ? TRUE : FALSE);
}

/**
 * @warning If new edge is constructed, send in copies of the nodes must be sent in
 */
- (BOOL)hasEdge:(SJHGraphEdge *)edge{
    return [_edges containsObject:edge];
}

- (NSUInteger)inDegree:(SJHGraphNode *)node{
    return [[[_nodes objectForKey:node.value] incomingNodes] count];
}

- (NSUInteger)outDegree:(SJHGraphNode *)node{
    return [[[_nodes objectForKey:node.value] outgoingNodes] count];
}

- (NSUInteger)degree:(SJHGraphNode *)node{
    //instantiate node to prevent multiple look ups
    SJHGraphNode *internalNode = [_nodes objectForKey:node.value];
    return [internalNode.incomingNodes count] + [internalNode.outgoingNodes count];
}

//returns a set constructed from the dictionary values
- (NSSet *)allNodes{
    return [NSSet setWithArray:[_nodes allValues]];
}

//returns a copy
- (NSSet *)allEdges{
    return [_edges copy];
}

//returns a set of all the nodes in the graph that are sources of the given node via some edge
- (NSSet *)inNodes:(SJHGraphNode *)node{
    SJHGraphNode *internalNode = [_nodes objectForKey:node.value];
    return [internalNode.incomingNodes copy];
}

//returns a set of all the nodes in the graph that are desinations of the given node via some edge
- (NSSet *)outNodes:(SJHGraphNode *)node{
    SJHGraphNode *internalNode = [_nodes objectForKey:node.value];
    return [internalNode.outgoingNodes copy];
}

- (NSSet *)inEdges:(SJHGraphNode *)node{
    SJHGraphNode *internalNode = [_nodes objectForKey:node.value];
    return [internalNode.incomingEdges copy];
}

- (NSSet *)outEdges:(SJHGraphNode *)node{
    SJHGraphNode *internalNode = [_nodes objectForKey:node.value];
    return [internalNode.outgoingEdges copy];
}

- (NSString *)description{
    //Key: (NSString *)node.value
    //Value: node
    NSMutableDictionary *nodes = [[NSMutableDictionary alloc] initWithCapacity:[_nodes count]];
    
    NSMutableArray *nodeNames = [[NSMutableArray alloc] initWithCapacity:[_nodes count]];
    for (id nodeValue in _nodes) {
        SJHGraphNode *node = [_nodes objectForKey:nodeValue];
        [nodes setObject:node forKey:(NSString *)nodeValue];
        [nodeNames addObject:(NSString *)nodeValue];
    }
    
    [nodeNames sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *first = obj1;
        NSString *second = obj2;
        
        return [first compare: second];
    }];
    
    NSMutableString *answer = [[NSMutableString alloc] init];
    for (NSString *nodeName in nodeNames) {
        [answer appendFormat:@"\n\nNode = %@ \n%@", nodeName, [nodes objectForKey:nodeName]];
    }
    
    return [answer copy];
}

@end

@implementation SJHGraphNode

+ (SJHGraphNode *)nodeWithValue:(id)value{
    return [[SJHGraphNode alloc] initWithValue:value];
}

- (id)init{
    self = [self initWithValue:nil];
    return self;
}

- (id)initWithValue:(id)value{
    self = [super init];
    if(self){
        _value = value;
        _outgoingEdges = [[NSMutableSet alloc] init];
        _incomingEdges = [[NSMutableSet alloc] init];
        _incomingNodes = [[NSMutableSet alloc] init];
        _outgoingNodes = [[NSMutableSet alloc] init];
        
        _additionalInfo = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (BOOL)isEqualToGraphNode:(SJHGraphNode *)graphNode{
    if(!graphNode || ![self.value isEqual:graphNode.value]){
        return NO;
    }
    return YES;
}

- (BOOL)isEqual:(id)object{
    
    if(self == object){
        return YES;
    }
    
    if(![object isKindOfClass: [self class]]){
        return NO;
    }
    
    return [self isEqualToGraphNode: (SJHGraphNode *)object];
}

- (NSUInteger)hash{
    NSUInteger result = 1;
    NSUInteger prime = 31;
    //    NSUInteger yesPrime = 1231;
    //    NSUInteger noPrime = 1237;
    
    // Add any object that already has a hash function (NSString)
    result = prime * result + [self.value hash];
    
    // Add primitive variables (int)
    //    result = prime * result + self.primitiveVariable;
    
    // Boolean values (BOOL)
    //    result = prime * result + self.isSelected?yesPrime:noPrime;
    
    return result;
}

- (NSString *)description{
    NSMutableString *answer = [[NSMutableString alloc] init];
    NSMutableArray *outEdgeList = [NSMutableArray arrayWithArray:[_outgoingEdges allObjects]];
    [outEdgeList sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [[[obj1 outgoingNode] value] compare: [[obj2 outgoingNode] value]];
    }];
    
    [answer appendString:@"  Out Edges:  "];
    
    for (SJHGraphEdge *edge in outEdgeList) {
        [answer appendFormat:@"%@, ", edge];
    }
    [answer setString:[answer substringToIndex: [answer length] - 2]];
    
    NSMutableArray *inEdgeList = [NSMutableArray arrayWithArray:[_incomingEdges allObjects]];
    [inEdgeList sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [[[obj1 incomingNode] value] compare: [[obj2 incomingNode] value]];
    }];
    
    [answer appendString:@"  In Edges:  "];
    
    for (NSInteger i = 0; i < [inEdgeList count]; i++) {
        [answer appendFormat:@"%@, ", [inEdgeList objectAtIndex:i]];
    }
    [answer setString:[answer substringToIndex: [answer length] - 2]];
    
    return [answer copy];
    
}

#pragma mark <NSCopying>
- (id)copyWithZone:(NSZone *)zone{
    SJHGraphNode *copy = [[[self class] alloc] initWithValue:self.value];
    [copy setOutgoingNodes:[self.outgoingNodes mutableCopy]];
    [copy setIncomingNodes:[self.incomingNodes mutableCopy]];
    [copy setOutgoingEdges:[self.outgoingEdges mutableCopy]];
    [copy setIncomingEdges:[self.incomingEdges mutableCopy]];
    
    return copy;
}

@end

@implementation SJHGraphEdge

- (id)init{
    [[NSException exceptionWithName:@"SJHGraphEdge init exception" reason:@"SJHGraphEdge must have incoming and outgoing nodes upon init" userInfo:nil] raise];
    return nil;
}

+ (SJHGraphEdge *)edgeWithIncomingNode:(SJHGraphNode *)incomingNode outgoingNode:(SJHGraphNode *)outgoingNode{
    return [[SJHGraphEdge alloc] initWithIncomingNode:incomingNode outgoingNode:outgoingNode];
}

+ (SJHGraphEdge *)edgeWithIncomingNode:(SJHGraphNode *)incomingNode outgoingNode:(SJHGraphNode *)outgoingNode weight:(id)weight{
    return [[SJHGraphEdge alloc] initWithIncomingNode:incomingNode outgoingNode:outgoingNode weight:weight];
}

- (id)initWithIncomingNode:(SJHGraphNode *)incomingNode outgoingNode:(SJHGraphNode *)outgoingNode{
    self = [self initWithIncomingNode:incomingNode outgoingNode:outgoingNode weight:@1];
    return self;
}

- (id)initWithIncomingNode:(SJHGraphNode *)incomingNode outgoingNode:(SJHGraphNode *)outgoingNode weight:(id)weight{
    self = [super init];
    if(self){
        _incomingNode = incomingNode;
        _outgoingNode = outgoingNode;
        _weight = weight;
        
        [_incomingNode.outgoingEdges addObject:self];
        [_incomingNode.outgoingNodes addObject:_outgoingNode];
        [_outgoingNode.incomingEdges addObject:self];
        [_outgoingNode.incomingNodes addObject:_incomingNode];
    }
    return self;
}

//To edges are considered equal if they have the same incoming and outgoing nodes.
- (BOOL)isEqualToGraphEdge:(SJHGraphEdge *)graphEdge{
    if(!graphEdge || ![self.incomingNode isEqual:graphEdge.incomingNode] || ![self.outgoingNode isEqual:graphEdge.outgoingNode]){
        return NO;
    }
    return YES;
}

- (BOOL)isEqual:(id)object{
    if(self == object){
        return YES;
    }
    
    if(![object isKindOfClass:[self class]]){
        return NO;
    }
    
    return [self.incomingNode isEqual: [object incomingNode]] && [self.outgoingNode isEqual:[object outgoingNode]];
}

- (NSUInteger)hash{
    NSUInteger result = 1;
    NSUInteger prime = 31;
    //    NSUInteger yesPrime = 1231;
    //    NSUInteger noPrime = 1237;
    
    // Add any object that already has a hash function (NSString)
    result = prime * result + [self.incomingNode hash];
    result = prime * result + [self.outgoingNode hash];
    
    // Add primitive variables (int)
    //    result = prime * result + self.primitiveVariable;
    
    // Boolean values (BOOL)
    //    result = prime * result + self.isSelected?yesPrime:noPrime;
    
    return result;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@ ->(%@) %@", _incomingNode.value, _weight, _outgoingNode.value];
}

@end
