//
//  SJHGraphNode.m
//  Collections
//
//  Created by James Heller on 11/18/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import "SJHGraphNode.h"

#import "SJHGraphEdge.h"

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
