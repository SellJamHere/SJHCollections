//
//  SJHGraphTest.m
//  Collections
//
//  Created by James Heller on 11/29/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

#import "SJHGraph.h"
#import "SJHGraphNode.h"
#import "SJHGraphEdge.h"

@interface SJHGraphTest : SenTestCase

@property (strong, nonatomic) SJHGraphNode *incomingNode;
@property (strong, nonatomic) SJHGraphNode *outgoingNode;

@end

@implementation SJHGraphTest

static NSString const *kTestValue = @"TestValue";
static NSString const *kIncomingNode = @"IncomingNode";
static NSString const *kOutgoingNode = @"OutgoingNode";
static NSInteger const kTestWeight = 999;
static NSUInteger const kNodeTestHash = 4584756847429206469;
static NSUInteger const kEdgeTestHash = 2411790121561763705;

+ (SJHGraph *)standardGraph{
    SJHGraph *standardGraph = [[SJHGraph alloc] init];
    
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"a"] OutgoingNode:[[SJHGraphNode alloc] initWithValue:@"b"] andWeight:nil]];
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"a"] OutgoingNode:[[SJHGraphNode alloc] initWithValue:@"c"] andWeight:@"a->c"]];
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"b"] OutgoingNode:[[SJHGraphNode alloc] initWithValue:@"d"] andWeight:@1]];
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"c"] OutgoingNode:[[SJHGraphNode alloc] initWithValue:@"d"] andWeight:@0.5]];
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"a"] OutgoingNode:[[SJHGraphNode alloc] initWithValue:@"d"] andWeight:@0]];
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"d"] OutgoingNode:[[SJHGraphNode alloc] initWithValue:@"a"] andWeight:@(-1)]];
    [standardGraph addNode:[[SJHGraphNode alloc] initWithValue:@"e"]];
    
    return standardGraph;
}

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    _incomingNode = [[SJHGraphNode alloc] initWithValue:kIncomingNode];
    _outgoingNode = [[SJHGraphNode alloc] initWithValue:kOutgoingNode];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

//GraphNode tests
- (void)test_NodeInit{
    //test base init
    SJHGraphNode *node = [[SJHGraphNode alloc] init];
    STAssertTrue([node isKindOfClass:[SJHGraphNode class]], @"Node is not of proper class");
    STAssertNil(node.value, @"node.value should be nil after base init");
    node.value = kTestValue;
    STAssertTrue([node.value isEqual:kTestValue], @"node.value should Equal %@", kTestValue);
    
    //test initWithValue
    node = [[SJHGraphNode alloc] initWithValue:kTestValue];
    STAssertTrue([node isKindOfClass:[SJHGraphNode class]], @"Node is not of proper class");
    STAssertTrue([node.value isEqual:kTestValue], @"node.value should Equal %@", kTestValue);
}

- (void)test_NodeEquality{
    SJHGraphNode *baseNode = [[SJHGraphNode alloc] initWithValue:kTestValue];
    SJHGraphNode *duplicatePointer = baseNode;
    
    //test isEqual
    STAssertTrue([baseNode isEqual:duplicatePointer], @"baseNode should equal duplicatePointer");
    STAssertTrue([baseNode isEqual:[[SJHGraphNode alloc] initWithValue:kTestValue]], @"baseNode should equal node created with same value");
    
    //test isEqualToGraphNode
    STAssertTrue([baseNode isEqualToGraphNode:duplicatePointer], @"baseNode should equal duplicatePointer");
    STAssertTrue([baseNode isEqualToGraphNode:[[SJHGraphNode alloc] initWithValue:kTestValue]], @"baseNode should equal node created with same value");
    
    //test hash
    STAssertTrue([baseNode hash] == kNodeTestHash, @"baseNode hash should equal %ld", kNodeTestHash);
}

//GraphEdge tests
- (void)test_EdgeInit{
    //test base init
    STAssertThrowsSpecific([[SJHGraphEdge alloc] init], NSException, @"Should have thrown NSException, as an edge requires incoming and outgoing nodes");
    
    //test initWithIncoming: andOutgoing
    SJHGraphEdge *baseEdge = [[SJHGraphEdge alloc] initWithIncomingNode:_incomingNode andOutgoingNode:_outgoingNode];
    STAssertTrue([baseEdge isKindOfClass:[SJHGraphEdge class]], @"baseEdge is not of proper class");
    STAssertTrue([baseEdge.incomingNode isEqual:_incomingNode], @"baseEdge.incomingNode is not equal to incomingNode");
    STAssertTrue([baseEdge.outgoingNode isEqual:_outgoingNode], @"baseEdge.outgoingNode is not equal to outgoingNode");
    STAssertTrue([baseEdge.weight isEqual:@1], @"baseEdge.weight should default to @1");
    
    //test initWithIncoming: outgoing: andWeight
    baseEdge = [[SJHGraphEdge alloc] initWithIncomingNode:_incomingNode OutgoingNode:_outgoingNode andWeight:[NSNumber numberWithInteger:kTestWeight]];
    STAssertTrue([baseEdge isKindOfClass:[SJHGraphEdge class]], @"baseEdge is not of proper class");
    STAssertTrue([baseEdge.incomingNode isEqual:_incomingNode], @"baseEdge.incomingNode is not equal to incomingNode");
    STAssertTrue([baseEdge.outgoingNode isEqual:_outgoingNode], @"baseEdge.outgoingNode is not equal to outgoingNode");
    STAssertTrue([baseEdge.weight isEqual:[NSNumber numberWithInteger:kTestWeight]], @"baseEdge.weight should default to %ld", kTestWeight);
}

- (void)test_EdgeEquals{
    SJHGraphEdge *baseEdge = [[SJHGraphEdge alloc] initWithIncomingNode:_incomingNode andOutgoingNode:_outgoingNode];
    SJHGraphEdge *duplicatePointer = baseEdge;
    
    //test isEqual
    STAssertTrue([baseEdge isEqual:duplicatePointer], @"baseEdge should equal duplicatePointer");
    STAssertTrue([baseEdge isEqual:[[SJHGraphEdge alloc] initWithIncomingNode:_incomingNode andOutgoingNode:_outgoingNode]], @"baseEdge should equal edge created with same nodes");
    
    //test isEqualToGraphNode
    STAssertTrue([baseEdge isEqualToGraphEdge:duplicatePointer], @"baseNode should equal duplicatePointer");
    STAssertTrue([baseEdge isEqualToGraphEdge:[[SJHGraphEdge alloc] initWithIncomingNode:_incomingNode andOutgoingNode:_outgoingNode]], @"baseEdge should equal edge created with same nodes");
    
    //test hash
    STAssertTrue([baseEdge hash] == kEdgeTestHash, @"baseEdge hash should equal %ld", kEdgeTestHash);
}

//Graph tests
- (void)test_GraphInit{
    SJHGraph *graph = [[SJHGraph alloc] init];
    STAssertTrue([graph isKindOfClass:[SJHGraph class]], @"graph is not of proper class");
}

- (void)test_addNode{
    SJHGraph *graph = [[SJHGraph alloc] init];
    
    [graph addNode:[[SJHGraphNode alloc] initWithValue:@"a"]];
    [graph addNode:[[SJHGraphNode alloc] initWithValue:@"b"]];
    [graph addNode:[[SJHGraphNode alloc] initWithValue:@"b"]];
    
    STAssertTrue([graph hasNode:[[SJHGraphNode alloc] initWithValue:@"a"]], @"Graph should have node");
    STAssertTrue([graph hasNode:[[SJHGraphNode alloc] initWithValue:@"b"]], @"Graph should have node");
    STAssertFalse([graph hasNode:[[SJHGraphNode alloc] initWithValue:@"c"]], @"Graph should not have node");
}

- (void)test_addEdge{
    SJHGraphNode *aNode = [[SJHGraphNode alloc] initWithValue:@"a"];
    SJHGraphNode *bNode = [[SJHGraphNode alloc] initWithValue:@"b"];
    SJHGraphNode *cNode = [[SJHGraphNode alloc] initWithValue:@"c"];
    
    SJHGraph *graph = [[SJHGraph alloc] init];
    
    [graph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:aNode andOutgoingNode:bNode]];
    STAssertTrue([graph hasNode:aNode], @"Graph should have Node");
    STAssertTrue([graph hasNode:bNode], @"Graph should have Node");
    STAssertTrue([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:aNode andOutgoingNode:bNode]], @"Graph should have edge");
    STAssertFalse([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:bNode andOutgoingNode:aNode]], @"Graph should not have edge");
    STAssertFalse([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:bNode andOutgoingNode:cNode]], @"Graph should not have edge");
    
    [graph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:bNode andOutgoingNode:cNode]];
    STAssertTrue([graph hasNode:cNode], @"Graph should have node");
    STAssertTrue([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:aNode andOutgoingNode:bNode]], @"Graph should have edge");
    STAssertTrue([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:bNode andOutgoingNode:cNode]], @"Graph should have edge");
    STAssertFalse([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:bNode andOutgoingNode:aNode]], @"Graph should not have edge");
    STAssertFalse([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:aNode andOutgoingNode:cNode]], @"Graph should not have edge");
    
    [graph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:aNode andOutgoingNode:cNode]];
    STAssertTrue(2 == [graph get], <#description, ...#>)
}

- (void)test_hasNode{
    SJHGraph *graph = [SJHGraphTest standardGraph];
    
    STAssertTrue([graph hasNode:[[SJHGraphNode alloc] initWithValue:@"a"]], @"Node not found");
    STAssertTrue([graph hasNode:[[SJHGraphNode alloc] initWithValue:@"b"]], @"Node not found");
    STAssertTrue([graph hasNode:[[SJHGraphNode alloc] initWithValue:@"c"]], @"Node not found");
    STAssertTrue([graph hasNode:[[SJHGraphNode alloc] initWithValue:@"d"]], @"Node not found");
    STAssertTrue([graph hasNode:[[SJHGraphNode alloc] initWithValue:@"e"]], @"Node not found");

    STAssertFalse([graph hasNode:[[SJHGraphNode alloc] initWithValue:@"f"]], @"Node not found");

    //test iteratively
    for (SJHGraphNode *node in [graph allNodes]) {
        STAssertTrue([graph hasNode:[[SJHGraphNode alloc] initWithValue:node.value]], @"Node not found");
    }
    for (SJHGraphEdge *edge in [graph allEdges]) {
        STAssertTrue([graph hasNode:edge.incomingNode], @"edge.incomingNode not found");
        STAssertTrue([graph hasNode:edge.outgoingNode], @"edge.outgoingNode not found");
    }
}

- (void)test_hasEdge{
    SJHGraph *graph = [SJHGraphTest standardGraph];
    
    STAssertTrue([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"a"] andOutgoingNode:[[SJHGraphNode alloc] initWithValue:@"b"]]], @"edge not found");
    STAssertTrue([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"a"] andOutgoingNode:[[SJHGraphNode alloc] initWithValue:@"c"]]], @"edge not found");
    STAssertTrue([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"a"] andOutgoingNode:[[SJHGraphNode alloc] initWithValue:@"d"]]], @"edge not found");
    STAssertTrue([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"b"] andOutgoingNode:[[SJHGraphNode alloc] initWithValue:@"d"]]], @"edge not found");
    STAssertTrue([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"c"] andOutgoingNode:[[SJHGraphNode alloc] initWithValue:@"d"]]], @"edge not found");
    STAssertTrue([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"d"] andOutgoingNode:[[SJHGraphNode alloc] initWithValue:@"a"]]], @"edge not found");
    
    STAssertFalse([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"b"] andOutgoingNode:[[SJHGraphNode alloc] initWithValue:@"a"]]], @"edge not found");
    STAssertFalse([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"c"] andOutgoingNode:[[SJHGraphNode alloc] initWithValue:@"a"]]], @"edge not found");
    STAssertFalse([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"d"] andOutgoingNode:[[SJHGraphNode alloc] initWithValue:@"b"]]], @"edge not found");
    STAssertFalse([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"d"] andOutgoingNode:[[SJHGraphNode alloc] initWithValue:@"c"]]], @"edge not found");
    STAssertFalse([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"a"] andOutgoingNode:[[SJHGraphNode alloc] initWithValue:@"e"]]], @"edge not found");
    
    //test iteratively
    for (SJHGraphEdge *edge in [graph allEdges]) {
        STAssertTrue([graph hasNode:edge.incomingNode], @"edge.incomingNode not found");
        STAssertTrue([graph hasNode:edge.outgoingNode], @"edge.outgoingNode not found");
        STAssertTrue([graph hasEdge:edge], @"Edge not found");
    }
}

@end
