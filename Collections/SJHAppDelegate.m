//
//  SJHAppDelegate.m
//  Collections
//
//  Created by James Heller on 9/18/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import "SJHAppDelegate.h"

#import "SJHOrderedDictionaryDriver.h"
#import "SJHGraphDriver.h"

#import "SJHGraph.h"
#import "SJHGraphNode.h"
#import "SJHGraphEdge.h"

@implementation SJHAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    //Run Drivers Here
    
//    SJHOrderedDictionaryDriver *driver = [[SJHOrderedDictionaryDriver alloc] init];
//    
//    [driver processCommands];
    
    
    
    SJHGraphDriver *driver = [[SJHGraphDriver alloc] init];
    [driver processCommands];
    
    
    
//    SJHGraphNode *one = [[SJHGraphNode alloc] initWithValue:@37];
//    SJHGraphNode *two = [[SJHGraphNode alloc] initWithValue:@4];
//    
//    SJHGraphEdge *edge = [[SJHGraphEdge alloc] initWithIncomingNode:one OutgoingNode:two andWeight:@7];
//    SJHGraphEdge *duplicateEdge = [[SJHGraphEdge alloc] initWithIncomingNode:one OutgoingNode:two andWeight:@1];
//    
//    NSMutableSet *set = [[NSMutableSet alloc] init];
//    [set addObject:edge];
//    
//    NSLog(@"%d", [edge isEqual:duplicateEdge]);
//    NSLog(@"%d", [set containsObject:edge]);
//    NSLog(@"%@", [set member:duplicateEdge]);
    
    [NSApp terminate:self];
}

@end
