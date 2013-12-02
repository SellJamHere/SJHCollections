//
//  SJHGraphNode.h
//  Collections
//
//  Created by James Heller on 11/18/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import <Foundation/Foundation.h>

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
