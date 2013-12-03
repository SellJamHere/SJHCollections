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
    
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"a"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"b"] weight:nil]];
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"a"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"c"] weight:@"a->c"]];
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"b"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"d"] weight:@1]];
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"c"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"d"] weight:@0.5]];
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"a"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"d"] weight:@0]];
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"d"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"a"] weight:@(-1)]];
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

//test standard graph
//this test method assumes all adding methods are correct
//tests all nodes and edges that should be present, and against all edges that shouldn't
- (void)test_standardGraph{
    SJHGraph *graph = [SJHGraphTest standardGraph];
    
    //test nodes
    STAssertTrue([graph hasNode:[SJHGraphNode nodeWithValue:@"a"]], @"a should be in graph");
    STAssertTrue([graph hasNode:[SJHGraphNode nodeWithValue:@"b"]], @"b should be in graph");
    STAssertTrue([graph hasNode:[SJHGraphNode nodeWithValue:@"c"]], @"c should be in graph");
    STAssertTrue([graph hasNode:[SJHGraphNode nodeWithValue:@"d"]], @"d should be in graph");
    STAssertTrue([graph hasNode:[SJHGraphNode nodeWithValue:@"e"]], @"e should be in graph");
    
    //test present edges
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"a"] outgoingNode:[SJHGraphNode nodeWithValue:@"b"]]], @"Should have edge a -> b");
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"a"] outgoingNode:[SJHGraphNode nodeWithValue:@"c"]]], @"Should have edge a -> c");
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"a"] outgoingNode:[SJHGraphNode nodeWithValue:@"d"]]], @"Should have edge a -> d");
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"b"] outgoingNode:[SJHGraphNode nodeWithValue:@"d"]]], @"Should have edge b -> d");
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"c"] outgoingNode:[SJHGraphNode nodeWithValue:@"d"]]], @"Should have edge c -> d");
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"d"] outgoingNode:[SJHGraphNode nodeWithValue:@"a"]]], @"Should have edge d -> a");
    
    //test edges not present
    STAssertFalse([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"a"] outgoingNode:[SJHGraphNode nodeWithValue:@"a"]]], @"Should not have edge a -> a");
    STAssertFalse([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"a"] outgoingNode:[SJHGraphNode nodeWithValue:@"e"]]], @"Should not have edge a -> e");
    
    STAssertFalse([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"b"] outgoingNode:[SJHGraphNode nodeWithValue:@"b"]]], @"Should not have edge b -> b");
    STAssertFalse([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"b"] outgoingNode:[SJHGraphNode nodeWithValue:@"a"]]], @"Should not have edge b -> a");
    STAssertFalse([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"c"] outgoingNode:[SJHGraphNode nodeWithValue:@"c"]]], @"Should not have edge b -> c");
    STAssertFalse([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"b"] outgoingNode:[SJHGraphNode nodeWithValue:@"e"]]], @"Should not have edge b -> e");
    
    STAssertFalse([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"c"] outgoingNode:[SJHGraphNode nodeWithValue:@"c"]]], @"Should not have edge c -> c");
    STAssertFalse([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"c"] outgoingNode:[SJHGraphNode nodeWithValue:@"a"]]], @"Should not have edge c -> a");
    STAssertFalse([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"c"] outgoingNode:[SJHGraphNode nodeWithValue:@"b"]]], @"Should not have edge a -> a");
    STAssertFalse([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"c"] outgoingNode:[SJHGraphNode nodeWithValue:@"e"]]], @"Should not have edge c -> e");
    
    STAssertFalse([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"d"] outgoingNode:[SJHGraphNode nodeWithValue:@"d"]]], @"Should not have edge d -> d");
    STAssertFalse([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"d"] outgoingNode:[SJHGraphNode nodeWithValue:@"b"]]], @"Should not have edge d -> b");
    STAssertFalse([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"d"] outgoingNode:[SJHGraphNode nodeWithValue:@"c"]]], @"Should not have edge d -> c");
    STAssertFalse([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"d"] outgoingNode:[SJHGraphNode nodeWithValue:@"e"]]], @"Should not have edge d -> e");
    
    STAssertFalse([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"e"] outgoingNode:[SJHGraphNode nodeWithValue:@"e"]]], @"Should not have edge e -> e");
    STAssertFalse([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"e"] outgoingNode:[SJHGraphNode nodeWithValue:@"a"]]], @"Should not have edge e -> a");
    STAssertFalse([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"e"] outgoingNode:[SJHGraphNode nodeWithValue:@"b"]]], @"Should not have edge e -> b");
    STAssertFalse([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"e"] outgoingNode:[SJHGraphNode nodeWithValue:@"c"]]], @"Should not have edge e -> c");
    STAssertFalse([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"e"] outgoingNode:[SJHGraphNode nodeWithValue:@"d"]]], @"Should not have edge e -> d");
    
    //Test in and out degrees
    STAssertTrue(1 == [graph inDegree:[SJHGraphNode nodeWithValue:@"a"]], @"a should have inDegree: 1");
    STAssertTrue(3 == [graph outDegree:[SJHGraphNode nodeWithValue:@"a"]], @"a should have outDegree: 3");
    STAssertTrue(1 == [graph inDegree:[SJHGraphNode nodeWithValue:@"b"]], @"b should have inDegree: 1");
    STAssertTrue(1 == [graph outDegree:[SJHGraphNode nodeWithValue:@"b"]], @"b should have outDegree: 1");
    STAssertTrue(1 == [graph inDegree:[SJHGraphNode nodeWithValue:@"c"]], @"c should have inDegree: 1");
    STAssertTrue(1 == [graph outDegree:[SJHGraphNode nodeWithValue:@"c"]], @"c should have outDegree: 1");
    STAssertTrue(3 == [graph inDegree:[SJHGraphNode nodeWithValue:@"d"]], @"d should have inDegree: 3");
    STAssertTrue(1 == [graph outDegree:[SJHGraphNode nodeWithValue:@"d"]], @"d should have outDegree: 1");
    STAssertTrue(0 == [graph inDegree:[SJHGraphNode nodeWithValue:@"e"]], @"e should have inDegree: 0");
    STAssertTrue(0 == [graph outDegree:[SJHGraphNode nodeWithValue:@"e"]], @"e should have outDegree: 0");
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
    
    //test nodeWithValue
    node = [SJHGraphNode nodeWithValue:kTestValue];
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
    
    //Test initWithValue isEqual nodeWithValue
    STAssertTrue([[[SJHGraphNode alloc] initWithValue:kTestValue] isEqual:[SJHGraphNode nodeWithValue:kTestValue]], @"Both constructors should create equal nodes");
}

//GraphEdge tests
- (void)test_EdgeInit{
    //test base init
    STAssertThrowsSpecific([[SJHGraphEdge alloc] init], NSException, @"Should have thrown NSException, as an edge requires incoming and outgoing nodes");
    
    //test initWithIncoming: andOutgoing
    SJHGraphEdge *baseEdge = [[SJHGraphEdge alloc] initWithIncomingNode:_incomingNode outgoingNode:_outgoingNode];
    STAssertTrue([baseEdge isKindOfClass:[SJHGraphEdge class]], @"baseEdge is not of proper class");
    STAssertTrue([baseEdge.incomingNode isEqual:_incomingNode], @"baseEdge.incomingNode is not equal to incomingNode");
    STAssertTrue([baseEdge.outgoingNode isEqual:_outgoingNode], @"baseEdge.outgoingNode is not equal to outgoingNode");
    STAssertTrue([baseEdge.weight isEqual:@1], @"baseEdge.weight should default to @1");
    STAssertTrue([baseEdge isEqual:[SJHGraphEdge edgeWithIncomingNode:_incomingNode outgoingNode:_outgoingNode]], @"Different constructors should be equal");
    
    //test initWithIncoming: outgoing: andWeight
    baseEdge = [[SJHGraphEdge alloc] initWithIncomingNode:_incomingNode outgoingNode:_outgoingNode weight:[NSNumber numberWithInteger:kTestWeight]];
    STAssertTrue([baseEdge isKindOfClass:[SJHGraphEdge class]], @"baseEdge is not of proper class");
    STAssertTrue([baseEdge.incomingNode isEqual:_incomingNode], @"baseEdge.incomingNode is not equal to incomingNode");
    STAssertTrue([baseEdge.outgoingNode isEqual:_outgoingNode], @"baseEdge.outgoingNode is not equal to outgoingNode");
    STAssertTrue([baseEdge.weight isEqual:[NSNumber numberWithInteger:kTestWeight]], @"baseEdge.weight should default to %ld", kTestWeight);
    STAssertTrue([baseEdge isEqual:[SJHGraphEdge edgeWithIncomingNode:_incomingNode outgoingNode:_outgoingNode weight:[NSNumber numberWithInteger:kTestWeight]]], @"Different constructors should be equal");
}

- (void)test_EdgeEquals{
    SJHGraphEdge *baseEdge = [[SJHGraphEdge alloc] initWithIncomingNode:_incomingNode outgoingNode:_outgoingNode];
    SJHGraphEdge *duplicatePointer = baseEdge;
    
    //test isEqual
    STAssertTrue([baseEdge isEqual:duplicatePointer], @"baseEdge should equal duplicatePointer");
    STAssertTrue([baseEdge isEqual:[[SJHGraphEdge alloc] initWithIncomingNode:_incomingNode outgoingNode:_outgoingNode]], @"baseEdge should equal edge created with same nodes");
    
    //test isEqualToGraphNode
    STAssertTrue([baseEdge isEqualToGraphEdge:duplicatePointer], @"baseNode should equal duplicatePointer");
    STAssertTrue([baseEdge isEqualToGraphEdge:[[SJHGraphEdge alloc] initWithIncomingNode:_incomingNode outgoingNode:_outgoingNode]], @"baseEdge should equal edge created with same nodes");
    
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
    
    [graph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:aNode outgoingNode:bNode]];
    STAssertTrue([graph hasNode:[aNode copy]], @"Graph should have Node");
    STAssertTrue([graph hasNode:[bNode copy]], @"Graph should have Node");
    STAssertTrue([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[aNode copy] outgoingNode:[bNode copy]]], @"Graph should have edge");
    STAssertFalse([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[bNode copy] outgoingNode:[aNode copy]]], @"Graph should not have edge");
    STAssertFalse([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[bNode copy] outgoingNode:[cNode copy]]], @"Graph should not have edge");
    
    [graph addEdgeWithOrigin:bNode.value destination:cNode.value weight:@1];
    STAssertTrue([graph hasNode:cNode], @"Graph should have node");
    STAssertTrue([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[aNode copy] outgoingNode:[bNode copy]]], @"Graph should have edge");
    STAssertTrue([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[bNode copy] outgoingNode:[cNode copy]]], @"Graph should have edge");
    STAssertFalse([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[bNode copy] outgoingNode:[aNode copy]]], @"Graph should not have edge");
    STAssertFalse([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[aNode copy] outgoingNode:[cNode copy]]], @"Graph should not have edge");
    
    //test addEdge by values
    [graph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:aNode outgoingNode:cNode]];
    STAssertTrue(2 == [[graph outNodes:[[SJHGraphNode alloc] initWithValue:@"a"]] count], @"Incorrect outNode size");
    STAssertTrue(2 == [[graph outEdges:[[SJHGraphNode alloc] initWithValue:@"a"]] count], @"Incorrect outEdge size");
    STAssertTrue(0 == [[graph inNodes:[[SJHGraphNode alloc] initWithValue:@"a"]] count], @"Incorrect inNode size");
    STAssertTrue(0 == [[graph inEdges:[[SJHGraphNode alloc] initWithValue:@"a"]] count], @"Incorrect inEdge size");
    
    STAssertTrue(1 == [[graph outNodes:[[SJHGraphNode alloc] initWithValue:@"b"]] count], @"Incorrect outNode size");
    STAssertTrue(1 == [[graph outEdges:[[SJHGraphNode alloc] initWithValue:@"b"]] count], @"Incorrect outEdge size");
    STAssertTrue(1 == [[graph inNodes:[[SJHGraphNode alloc] initWithValue:@"b"]] count], @"Incorrect inNode size");
    STAssertTrue(1 == [[graph inEdges:[[SJHGraphNode alloc] initWithValue:@"b"]] count], @"Incorrect inEdge size");
    
    STAssertTrue(0 == [[graph outNodes:[[SJHGraphNode alloc] initWithValue:@"c"]] count], @"Incorrect outNode size");
    STAssertTrue(0 == [[graph outEdges:[[SJHGraphNode alloc] initWithValue:@"c"]] count], @"Incorrect outEdge size");
    STAssertTrue(2 == [[graph inNodes:[[SJHGraphNode alloc] initWithValue:@"c"]] count], @"Incorrect inNode size");
    STAssertTrue(2 == [[graph inEdges:[[SJHGraphNode alloc] initWithValue:@"c"]] count], @"Incorrect inEdge size");
}

- (void)test_removeNode{
    SJHGraph *graph = [SJHGraphTest standardGraph];
    
    STAssertTrue([graph hasNode:[SJHGraphNode nodeWithValue:@"a"]], @"a should be in graph");
    STAssertTrue([graph hasNode:[SJHGraphNode nodeWithValue:@"c"]], @"c should be in graph");
    STAssertTrue([graph hasNode:[SJHGraphNode nodeWithValue:@"d"]], @"d should be in graph");
    STAssertTrue([graph hasNode:[SJHGraphNode nodeWithValue:@"e"]], @"e should be in graph");
    
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"a"] outgoingNode:[SJHGraphNode nodeWithValue:@"c"]]], @"Should have edge a -> c");
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"a"] outgoingNode:[SJHGraphNode nodeWithValue:@"d"]]], @"Should have edge a -> d");
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"c"] outgoingNode:[SJHGraphNode nodeWithValue:@"d"]]], @"Should have edge c -> d");
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"d"] outgoingNode:[SJHGraphNode nodeWithValue:@"a"]]], @"Should have edge d -> a");
    
    [graph removeNode:[SJHGraphNode nodeWithValue:@"b"]];
    
    STAssertTrue([graph hasNode:[SJHGraphNode nodeWithValue:@"a"]], @"a should be in graph");
    STAssertTrue([graph hasNode:[SJHGraphNode nodeWithValue:@"c"]], @"c should be in graph");
    STAssertTrue([graph hasNode:[SJHGraphNode nodeWithValue:@"d"]], @"d should be in graph");
    STAssertTrue([graph hasNode:[SJHGraphNode nodeWithValue:@"e"]], @"e should be in graph");
    
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"a"] outgoingNode:[SJHGraphNode nodeWithValue:@"c"]]], @"Should have edge a -> c");
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"a"] outgoingNode:[SJHGraphNode nodeWithValue:@"d"]]], @"Should have edge a -> d");
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"c"] outgoingNode:[SJHGraphNode nodeWithValue:@"d"]]], @"Should have edge c -> d");
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"d"] outgoingNode:[SJHGraphNode nodeWithValue:@"a"]]], @"Should have edge d -> a");
    
    
    STAssertTrue(2 == [[graph outNodes:[[SJHGraphNode alloc] initWithValue:@"a"]] count], @"Incorrect outNode size");
    STAssertTrue(2 == [[graph outEdges:[[SJHGraphNode alloc] initWithValue:@"a"]] count], @"Incorrect outEdge size");
    STAssertTrue(1 == [[graph inNodes:[[SJHGraphNode alloc] initWithValue:@"a"]] count], @"Incorrect inNode size");
    STAssertTrue(1 == [[graph inEdges:[[SJHGraphNode alloc] initWithValue:@"a"]] count], @"Incorrect inEdge size");
    
    
    STAssertTrue(1 == [[graph outNodes:[[SJHGraphNode alloc] initWithValue:@"c"]] count], @"Incorrect outNode size");
    STAssertTrue(1 == [[graph outEdges:[[SJHGraphNode alloc] initWithValue:@"c"]] count], @"Incorrect outEdge size");
    STAssertTrue(1 == [[graph inNodes:[[SJHGraphNode alloc] initWithValue:@"c"]] count], @"Incorrect inNode size");
    STAssertTrue(1 == [[graph inEdges:[[SJHGraphNode alloc] initWithValue:@"c"]] count], @"Incorrect inEdge size");

    STAssertTrue(1 == [[graph outNodes:[[SJHGraphNode alloc] initWithValue:@"d"]] count], @"Incorrect outNode size");
    STAssertTrue(1 == [[graph outEdges:[[SJHGraphNode alloc] initWithValue:@"d"]] count], @"Incorrect outEdge size");
    STAssertTrue(2 == [[graph inNodes:[[SJHGraphNode alloc] initWithValue:@"d"]] count], @"Incorrect inNode size");
    STAssertTrue(2 == [[graph inEdges:[[SJHGraphNode alloc] initWithValue:@"d"]] count], @"Incorrect inEdge size");
    
    STAssertTrue(0 == [[graph outNodes:[[SJHGraphNode alloc] initWithValue:@"e"]] count], @"Incorrect outNode size");
    STAssertTrue(0 == [[graph outEdges:[[SJHGraphNode alloc] initWithValue:@"e"]] count], @"Incorrect outEdge size");
    STAssertTrue(0 == [[graph inNodes:[[SJHGraphNode alloc] initWithValue:@"e"]] count], @"Incorrect inNode size");
    STAssertTrue(0 == [[graph inEdges:[[SJHGraphNode alloc] initWithValue:@"e"]] count], @"Incorrect inEdge size");
}

- (void)test_removeEdge{
    SJHGraph *graph = [SJHGraphTest standardGraph];
    
    [graph removeEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"a"] outgoingNode:[SJHGraphNode nodeWithValue:@"b"]]];
    [graph removeEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"b"] outgoingNode:[SJHGraphNode nodeWithValue:@"d"]]];
    [graph removeEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"d"] outgoingNode:[SJHGraphNode nodeWithValue:@"b"]]]; //not present
    
    STAssertTrue([graph hasNode:[SJHGraphNode nodeWithValue:@"a"]], @"graph should have node \"a\"");
    STAssertTrue([graph hasNode:[SJHGraphNode nodeWithValue:@"b"]], @"graph should have node \"b\"");
    STAssertTrue([graph hasNode:[SJHGraphNode nodeWithValue:@"c"]], @"graph should have node \"b\"");
    STAssertTrue([graph hasNode:[SJHGraphNode nodeWithValue:@"d"]], @"graph should have node \"d\"");
    STAssertTrue([graph hasNode:[SJHGraphNode nodeWithValue:@"e"]], @"graph should have node \"e\"");
    
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"a"] outgoingNode:[SJHGraphNode nodeWithValue:@"c"]]], @"graph should have edge a -> c");
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"a"] outgoingNode:[SJHGraphNode nodeWithValue:@"d"]]], @"graph should have edge a -> d");
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"c"] outgoingNode:[SJHGraphNode nodeWithValue:@"d"]]], @"graph should have edge c -> d");
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"d"] outgoingNode:[SJHGraphNode nodeWithValue:@"a"]]], @"graph should have edge d -> a");
    
    STAssertFalse([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"a"] outgoingNode:[SJHGraphNode nodeWithValue:@"b"]]], @"graph should not have edge a -> b");
    STAssertFalse([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"b"] outgoingNode:[SJHGraphNode nodeWithValue:@"d"]]], @"graph should not have edge b -> d");
    STAssertFalse([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"d"] outgoingNode:[SJHGraphNode nodeWithValue:@"b"]]], @"graph should not have edge d -> b");
    
    STAssertTrue(2 == [[graph outNodes:[[SJHGraphNode alloc] initWithValue:@"a"]] count], @"Incorrect outNode size");
    STAssertTrue(2 == [[graph outEdges:[[SJHGraphNode alloc] initWithValue:@"a"]] count], @"Incorrect outEdge size");
    STAssertTrue(1 == [[graph inNodes:[[SJHGraphNode alloc] initWithValue:@"a"]] count], @"Incorrect inNode size");
    STAssertTrue(1 == [[graph inEdges:[[SJHGraphNode alloc] initWithValue:@"a"]] count], @"Incorrect inEdge size");
    
    STAssertTrue(0 == [[graph outNodes:[[SJHGraphNode alloc] initWithValue:@"b"]] count], @"Incorrect outNode size");
    STAssertTrue(0 == [[graph outEdges:[[SJHGraphNode alloc] initWithValue:@"b"]] count], @"Incorrect outEdge size");
    STAssertTrue(0 == [[graph inNodes:[[SJHGraphNode alloc] initWithValue:@"b"]] count], @"Incorrect inNode size");
    STAssertTrue(0 == [[graph inEdges:[[SJHGraphNode alloc] initWithValue:@"b"]] count], @"Incorrect inEdge size");
    
    STAssertTrue(1 == [[graph outNodes:[[SJHGraphNode alloc] initWithValue:@"c"]] count], @"Incorrect outNode size");
    STAssertTrue(1 == [[graph outEdges:[[SJHGraphNode alloc] initWithValue:@"c"]] count], @"Incorrect outEdge size");
    STAssertTrue(1 == [[graph inNodes:[[SJHGraphNode alloc] initWithValue:@"c"]] count], @"Incorrect inNode size");
    STAssertTrue(1 == [[graph inEdges:[[SJHGraphNode alloc] initWithValue:@"c"]] count], @"Incorrect inEdge size");
    
    STAssertTrue(1 == [[graph outNodes:[[SJHGraphNode alloc] initWithValue:@"d"]] count], @"Incorrect outNode size");
    STAssertTrue(1 == [[graph outEdges:[[SJHGraphNode alloc] initWithValue:@"d"]] count], @"Incorrect outEdge size");
    STAssertTrue(2 == [[graph inNodes:[[SJHGraphNode alloc] initWithValue:@"d"]] count], @"Incorrect inNode size");
    STAssertTrue(2 == [[graph inEdges:[[SJHGraphNode alloc] initWithValue:@"d"]] count], @"Incorrect inEdge size");
    
}

- (void)test_clear{
    SJHGraph *graph = [SJHGraphTest standardGraph];
    
    STAssertTrue(5 == [graph nodeCount], @"Incorrect nodeCount");
    STAssertTrue(6 == [graph edgeCount], @"Incorrect edgeCount");
    
    [graph clear];
    
    STAssertTrue(0 == [graph nodeCount], @"Incorrect nodeCount");
    STAssertTrue(0 == [graph edgeCount], @"Incorrect edgeCount");
    STAssertTrue(0 == [[graph allNodes] count], @"Incorrect allNodes count");
    STAssertTrue(0 == [[graph allEdges] count], @"Incorrect allEdges count");
}

- (void)test_nodeCount{
    SJHGraph *graph = [SJHGraphTest standardGraph];
    
    STAssertTrue(5 == [graph nodeCount], @"Incorrect nodeCount");
    
    [graph removeNode:[SJHGraphNode nodeWithValue:@"f"]]; //not present
    STAssertTrue(5 == [graph nodeCount], @"Incorrect nodeCount");
    
    [graph removeNode:[SJHGraphNode nodeWithValue:@"a"]];
    STAssertTrue(4 == [graph nodeCount], @"Incorrect nodeCount");
    
    [graph removeNode:[SJHGraphNode nodeWithValue:@"b"]];
    STAssertTrue(3 == [graph nodeCount], @"Incorrect nodeCount");
    
    [graph removeNode:[SJHGraphNode nodeWithValue:@"c"]];
    STAssertTrue(2 == [graph nodeCount], @"Incorrect nodeCount");
    
    [graph removeNode:[SJHGraphNode nodeWithValue:@"d"]];
    STAssertTrue(1 == [graph nodeCount], @"Incorrect nodeCount");
    
    [graph removeNode:[SJHGraphNode nodeWithValue:@"e"]];
    STAssertTrue(0 == [graph nodeCount], @"Incorrect nodeCount");
}

- (void)test_edgeCount{
    SJHGraph *graph = [SJHGraphTest standardGraph];
    
    STAssertTrue(5 == [graph nodeCount], @"Incorrect nodeCount");
    STAssertTrue(6 == [graph edgeCount], @"Incorrect edgeCount");
    
    [graph removeEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"d"] outgoingNode:[SJHGraphNode nodeWithValue:@"c"]]]; //not present
    STAssertTrue(6 == [graph edgeCount], @"Incorrect edgeCount");
    
    [graph removeEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"a"] outgoingNode:[SJHGraphNode nodeWithValue:@"b"]]];
    STAssertTrue(5 == [graph edgeCount], @"Incorrect edgeCount");
    
    [graph removeEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"a"] outgoingNode:[SJHGraphNode nodeWithValue:@"c"]]];
    STAssertTrue(4 == [graph edgeCount], @"Incorrect edgeCount");
    
    [graph removeEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"a"] outgoingNode:[SJHGraphNode nodeWithValue:@"d"]]];
    STAssertTrue(3 == [graph edgeCount], @"Incorrect edgeCount");
    
    [graph removeEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"b"] outgoingNode:[SJHGraphNode nodeWithValue:@"d"]]];
    STAssertTrue(2 == [graph edgeCount], @"Incorrect edgeCount");
    
    [graph removeEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"c"] outgoingNode:[SJHGraphNode nodeWithValue:@"d"]]];
    STAssertTrue(1 == [graph edgeCount], @"Incorrect edgeCount");
    
    [graph removeEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"d"] outgoingNode:[SJHGraphNode nodeWithValue:@"a"]]];
    STAssertTrue(0 == [graph edgeCount], @"Incorrect edgeCount");
    
    STAssertTrue(5 == [graph nodeCount], @"Incorrect nodeCount");
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
    
    STAssertTrue([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"a"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"b"]]], @"edge not found");
    STAssertTrue([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"a"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"c"]]], @"edge not found");
    STAssertTrue([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"a"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"d"]]], @"edge not found");
    STAssertTrue([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"b"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"d"]]], @"edge not found");
    STAssertTrue([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"c"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"d"]]], @"edge not found");
    STAssertTrue([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"d"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"a"]]], @"edge not found");
    
    STAssertFalse([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"b"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"a"]]], @"edge not found");
    STAssertFalse([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"c"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"a"]]], @"edge not found");
    STAssertFalse([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"d"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"b"]]], @"edge not found");
    STAssertFalse([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"d"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"c"]]], @"edge not found");
    STAssertFalse([graph hasEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"a"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"e"]]], @"edge not found");
    
    //test iteratively
    for (SJHGraphEdge *edge in [graph allEdges]) {
        STAssertTrue([graph hasNode:edge.incomingNode], @"edge.incomingNode not found");
        STAssertTrue([graph hasNode:edge.outgoingNode], @"edge.outgoingNode not found");
        STAssertTrue([graph hasEdge:edge], @"Edge not found");
    }
}

- (void)test_inDegree{
    SJHGraph *graph = [SJHGraphTest standardGraph];
    
    STAssertTrue(1 == [graph inDegree:[SJHGraphNode nodeWithValue:@"a"]], @"Incorrect inDegree");
    STAssertTrue(1 == [graph inDegree:[SJHGraphNode nodeWithValue:@"b"]], @"Incorrect inDegree");
    STAssertTrue(1 == [graph inDegree:[SJHGraphNode nodeWithValue:@"c"]], @"Incorrect inDegree");
    STAssertTrue(3 == [graph inDegree:[SJHGraphNode nodeWithValue:@"d"]], @"Incorrect inDegree");
    STAssertTrue(0 == [graph inDegree:[SJHGraphNode nodeWithValue:@"e"]], @"Incorrect inDegree");
    
    STAssertTrue(0 == [graph inDegree:[SJHGraphNode nodeWithValue:@"f"]], @"Incorrect inDegree"); //not present
}

- (void)test_outDegree{
    SJHGraph *graph = [SJHGraphTest standardGraph];

    STAssertTrue(3 == [graph outDegree:[SJHGraphNode nodeWithValue:@"a"]], @"Incorrect inDegree");
    STAssertTrue(1 == [graph outDegree:[SJHGraphNode nodeWithValue:@"b"]], @"Incorrect inDegree");
    STAssertTrue(1 == [graph outDegree:[SJHGraphNode nodeWithValue:@"c"]], @"Incorrect inDegree");
    STAssertTrue(1 == [graph outDegree:[SJHGraphNode nodeWithValue:@"d"]], @"Incorrect inDegree");
    STAssertTrue(0 == [graph outDegree:[SJHGraphNode nodeWithValue:@"e"]], @"Incorrect inDegree");
    
    STAssertTrue(0 == [graph outDegree:[SJHGraphNode nodeWithValue:@"f"]], @"Incorrect inDegree"); //not present
}

- (void)test_degree{
    SJHGraph *graph = [SJHGraphTest standardGraph];
    
    STAssertTrue(4 == [graph degree:[SJHGraphNode nodeWithValue:@"a"]], @"Incorrect inDegree");
    STAssertTrue(2 == [graph degree:[SJHGraphNode nodeWithValue:@"b"]], @"Incorrect inDegree");
    STAssertTrue(2 == [graph degree:[SJHGraphNode nodeWithValue:@"c"]], @"Incorrect inDegree");
    STAssertTrue(4 == [graph degree:[SJHGraphNode nodeWithValue:@"d"]], @"Incorrect inDegree");
    STAssertTrue(0 == [graph degree:[SJHGraphNode nodeWithValue:@"e"]], @"Incorrect inDegree");
    
    STAssertTrue(0 == [graph degree:[SJHGraphNode nodeWithValue:@"f"]], @"Incorrect inDegree"); //not present
}

- (void)test_allNodes{
    SJHGraph *graph = [SJHGraphTest standardGraph];
    
    NSMutableSet *nodes = [[NSMutableSet alloc] init];
    for (SJHGraphNode *node in [graph allNodes]) {
        [nodes addObject:node.value];
    }
    
    STAssertTrue(5 == [nodes count], @"Incorrect nodes count");
    
    NSSet *values = [NSSet setWithObjects:@"a", @"b", @"c", @"d", @"e", nil];
    
    STAssertTrue([nodes isEqualToSet: values], @"Sets should equal");
}

- (void)test_allEdges{
    SJHGraph *graph = [SJHGraphTest standardGraph];
    
    NSSet *edges = [graph allEdges];
    
    STAssertTrue(6 == [edges count], @"edges is of wrong size");
    
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"a"] outgoingNode:[SJHGraphNode nodeWithValue:@"b"]]], @"Should contain edge");
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"a"] outgoingNode:[SJHGraphNode nodeWithValue:@"c"]]], @"Should contain edge");
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"a"] outgoingNode:[SJHGraphNode nodeWithValue:@"d"]]], @"Should contain edge");
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"b"] outgoingNode:[SJHGraphNode nodeWithValue:@"d"]]], @"Should contain edge");
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"c"] outgoingNode:[SJHGraphNode nodeWithValue:@"d"]]], @"Should contain edge");
    STAssertTrue([graph hasEdge:[SJHGraphEdge edgeWithIncomingNode:[SJHGraphNode nodeWithValue:@"d"] outgoingNode:[SJHGraphNode nodeWithValue:@"a"]]], @"Should contain edge");
}

- (void)test_inNodes{
    SJHGraph *graph = [SJHGraphTest standardGraph];
    
    NSSet *smallSet = [NSSet setWithObjects:[SJHGraphNode nodeWithValue:@"d"], nil];
    
    STAssertTrue([smallSet isEqual:[graph inNodes:[SJHGraphNode nodeWithValue:@"a"]]], @"Sets should be equal");
    
    smallSet = [NSSet setWithObjects:[SJHGraphNode nodeWithValue:@"a"], nil];
    
    STAssertTrue([smallSet isEqual:[graph inNodes:[SJHGraphNode nodeWithValue:@"b"]]], @"Sets should be equal");
    
    smallSet = [NSSet setWithObjects:[SJHGraphNode nodeWithValue:@"a"], nil];
    
    STAssertTrue([smallSet isEqual:[graph inNodes:[SJHGraphNode nodeWithValue:@"c"]]], @"Sets should be equal");
    
    smallSet = [NSSet setWithObjects:[SJHGraphNode nodeWithValue:@"a"], [SJHGraphNode nodeWithValue:@"b"], [SJHGraphNode nodeWithValue:@"c"], nil];
    
    STAssertTrue([smallSet isEqual:[graph inNodes:[SJHGraphNode nodeWithValue:@"d"]]], @"Sets should be equal");
    
    smallSet = [NSSet setWithObjects: nil];
    
    STAssertTrue([smallSet isEqual:[graph inNodes:[SJHGraphNode nodeWithValue:@"e"]]], @"Sets should be equal");
}

- (void)test_outNodes{
    SJHGraph *graph = [SJHGraphTest standardGraph];
    
    NSSet *smallSet = [NSSet setWithObjects:[SJHGraphNode nodeWithValue:@"b"], [SJHGraphNode nodeWithValue:@"c"], [SJHGraphNode nodeWithValue:@"d"], nil];
    
    STAssertTrue([smallSet isEqual:[graph outNodes:[SJHGraphNode nodeWithValue:@"a"]]], @"Sets should be equal");
    
    smallSet = [NSSet setWithObjects:[SJHGraphNode nodeWithValue:@"d"], nil];
    
    STAssertTrue([smallSet isEqual:[graph outNodes:[SJHGraphNode nodeWithValue:@"b"]]], @"Sets should be equal");
    
    smallSet = [NSSet setWithObjects:[SJHGraphNode nodeWithValue:@"d"], nil];
    
    STAssertTrue([smallSet isEqual:[graph outNodes:[SJHGraphNode nodeWithValue:@"c"]]], @"Sets should be equal");
    
    smallSet = [NSSet setWithObjects:[SJHGraphNode nodeWithValue:@"a"], nil];
    
    STAssertTrue([smallSet isEqual:[graph outNodes:[SJHGraphNode nodeWithValue:@"d"]]], @"Sets should be equal");
    
    smallSet = [NSSet setWithObjects: nil];
    
    STAssertTrue([smallSet isEqual:[graph outNodes:[SJHGraphNode nodeWithValue:@"e"]]], @"Sets should be equal");
}

- (void)test_inEdges{
    SJHGraph *graph = [SJHGraphTest standardGraph];
    
    for (SJHGraphNode *node in [graph allNodes]) {
        NSMutableSet *nodes = [[NSMutableSet alloc] init];
        for (SJHGraphEdge *edge in [graph inEdges:node]) {
            [nodes addObject:edge.incomingNode];
        }
        NSSet *set = [graph inNodes:node];
        STAssertTrue([nodes isEqual:set], @"Sets should be equal");
    }
}

- (void)test_outEdges{
    SJHGraph *graph = [SJHGraphTest standardGraph];
    
    for (SJHGraphNode *node in [graph allNodes]) {
        NSMutableSet *nodes = [[NSMutableSet alloc] init];
        for (SJHGraphEdge *edge in [graph outEdges:node]) {
            [nodes addObject:edge.outgoingNode];
        }
        NSSet *set = [graph outNodes:node];
        STAssertTrue([nodes isEqual:set], @"Sets should equal");
    }
}

@end
