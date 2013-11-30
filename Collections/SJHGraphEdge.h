//
//  SJHGraphEdge.h
//  Collections
//
//  Created by James Heller on 11/18/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SJHGraphNode;

@interface SJHGraphEdge : NSObject

@property (strong, nonatomic, readonly) SJHGraphNode *outgoingNode;
@property (strong, nonatomic, readonly) SJHGraphNode *incomingNode;
@property (strong, nonatomic) id weight; //Generally NSNumber, though other types are allowed
@property (strong, nonatomic) NSMutableDictionary *additionalInfo;

- (id)initWithIncomingNode:(SJHGraphNode *)incomingNode andOutgoingNode:(SJHGraphNode *)outgoingNode;
- (id)initWithIncomingNode:(SJHGraphNode *)incomingNode OutgoingNode:(SJHGraphNode *)outgoingNode andWeight:(id)weight;

- (BOOL)isEqualToGraphEdge:(SJHGraphEdge *)graphEdge;

@end
