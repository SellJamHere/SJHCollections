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
    self = [self initWithIncomingNode:nil andOutgoingNode:nil];
    return self;
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
    }
    return self;
}

//To edges are considered equal if they have the same incoming and outgoing nodes.
- (BOOL)isEqual:(id)object{
    if(self == object){
        return YES;
    }
    if([self.incomingNode isEqual: [object incomingNode]] && [self.outgoingNode isEqual:[object outgoingNode]]){
        return YES;
    }
    
    return NO;
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

@end
