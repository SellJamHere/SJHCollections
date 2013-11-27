//
//  SJHGraphNode.m
//  Collections
//
//  Created by James Heller on 11/18/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import "SJHGraphNode.h"

@implementation SJHGraphNode

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
        
        _additionalInfo = [[NSMutableDictionary alloc] init];
    }
    return self;
}

@end
