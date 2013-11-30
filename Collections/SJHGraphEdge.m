//
//  SJHGraphEdge.m
//  Collections
//
//  Created by James Heller on 11/18/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import "SJHGraphEdge.h"

#import "SJHGraphNode.h"

@implementation SJHGraphEdge

- (id)init{
    [[NSException exceptionWithName:@"SJHGraphEdge init exception" reason:@"SJHGraphEdge must have incoming and outgoing nodes upon init" userInfo:nil] raise];
    return nil;
}

- (id)initWithIncomingNode:(SJHGraphNode *)incomingNode andOutgoingNode:(SJHGraphNode *)outgoingNode{
    self = [self initWithIncomingNode:incomingNode OutgoingNode:outgoingNode andWeight:@1];
    return self;
}

- (id)initWithIncomingNode:(SJHGraphNode *)incomingNode OutgoingNode:(SJHGraphNode *)outgoingNode andWeight:(id)weight{
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
