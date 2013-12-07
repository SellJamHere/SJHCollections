//
//  SJHGraphDriver.m
//  Collections
//
//  Created by James Heller on 11/27/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import "SJHGraphDriver.h"

#import "SJHGraph.h"

@interface SJHGraphDriver ()

@property (strong, nonatomic) SJHGraph *graph;

@end

static NSString *preface = @"Graph";

@implementation SJHGraphDriver

- (id)init{
    self = [super init];
    if(self)
    {
        _graph = [[SJHGraph alloc] init];
    }
    return self;
}

+ (SJHGraph *)standardGraph{
    SJHGraph *standardGraph = [[SJHGraph alloc] init];
    
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"S"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"a"] weight:@5]];
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"S"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"c"] weight:@10]];
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"a"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"b"] weight:@6]];
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"a"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"d"] weight:@20]];
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"b"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"c"] weight:@2]];
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"b"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"d"] weight:@10]];
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"c"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"a"] weight:@1]];
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"c"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"e"] weight:@1]];
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"d"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"e"] weight:@3]];
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"d"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"T"] weight:@4]];
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"e"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"d"] weight:@9]];
    [standardGraph addEdge:[[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:@"e"] outgoingNode:[[SJHGraphNode alloc] initWithValue:@"T"] weight:@8]];
    
    return standardGraph;
}

- (NSString *)presentMenu{
    printf("\n\n\n%s  Mutators            Accessors                    General\n", [preface UTF8String]);
    printf("%s  n - addNode             h - hasNode                  d - description\n", [preface UTF8String]);
    printf("%s  e - addEdge             H - hasEdge                  l - load standard graph\n", [preface UTF8String]);
    printf("%s  rn - removeNode         v - edgeValue                q - quit\n", [preface UTF8String]);
    printf("%s  re - removeEdge         > - inDegree\n", [preface UTF8String]);
    printf("%s  c - clear               < - outDegree\n", [preface UTF8String]);
    printf("%s                          g - getAllNodes\n", [preface UTF8String]);
    printf("%s                          G - getAllEdges\n", [preface UTF8String]);
    printf("%s                          # - node/edge counts\n", [preface UTF8String]);
    printf("%s                          o - out information\n", [preface UTF8String]);
    printf("%s                          i - in information\n", [preface UTF8String]);
    printf("%s                          p - shortest path\n", [preface UTF8String]);
    printf("\nEnter Command: ");
    
    char str[50] = {0};
    scanf("%s", str);
    return [NSString stringWithUTF8String:str];
}

- (void)processCommands{
    
    printf("All values entered as String\n");
    
    NSString *menuSelection;
    
    do {
        menuSelection = [self presentMenu];
        
        if ([menuSelection isEqualToString:@"n"]) {
            char node[50] = {0};
            
            printf("Enter node: ");
            scanf("%s", node);
            [_graph addNodeWithValue: [NSString stringWithUTF8String:node]];
        }
        else if ([menuSelection isEqualToString:@"e"]) {
            char originNode[50] = {0};
            char destinationNode[50] = {0};
            char value[50] = {0};
            
            printf("Enter origin node: ");
            scanf("%s", originNode);
            printf("Enter destination node: ");
            scanf("%s", destinationNode);
            printf("Enter edge value: ");
            scanf("%s", value);
            
            SJHGraphEdge *edge = [[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:[NSString stringWithUTF8String:originNode]] outgoingNode:[[SJHGraphNode alloc] initWithValue:[NSString stringWithUTF8String:destinationNode]] weight: [NSNumber numberWithInteger:[[NSString stringWithUTF8String:value] integerValue]]];
            
            [_graph addEdge:edge];
            
        }
        else if ([menuSelection isEqualToString:@"rn"]) {
            char node[50] = {0};
            
            printf("Enter node: ");
            scanf("%s", node);
            [_graph removeNode:[[SJHGraphNode alloc] initWithValue: [NSString stringWithUTF8String:node]]];
            
        }
        else if ([menuSelection isEqualToString:@"re"]) {
            char originNode[50] = {0};
            char destinationNode[50] = {0};
            
            printf("Enter origin node: ");
            scanf("%s", originNode);
            printf("Enter destination node: ");
            scanf("%s", destinationNode);
            
            SJHGraphEdge *edge = [[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:[NSString stringWithUTF8String:originNode]] outgoingNode:[[SJHGraphNode alloc] initWithValue:[NSString stringWithUTF8String:destinationNode]]];
            
            [_graph removeEdge:edge];
            
        }
        else if ([menuSelection isEqualToString:@"h"]) {
            char node[50] = {0};
            
            printf("Enter node: ");
            scanf("%s", node);
            printf("%s", ([_graph hasNode:[[SJHGraphNode alloc] initWithValue: [NSString stringWithUTF8String:node]]] ? "TRUE" : "FALSE"));
            
        }
        else if ([menuSelection isEqualToString:@"H"]) {
            char originNode[50] = {0};
            char destinationNode[50] = {0};
            
            printf("Enter origin node: ");
            scanf("%s", originNode);
            printf("Enter destination node: ");
            scanf("%s", destinationNode);
            
            SJHGraphEdge *edge = [[SJHGraphEdge alloc] initWithIncomingNode:[[SJHGraphNode alloc] initWithValue:[NSString stringWithUTF8String:originNode]] outgoingNode:[[SJHGraphNode alloc] initWithValue:[NSString stringWithUTF8String:destinationNode]]];
            
            printf("%s", ([_graph hasEdge:edge] ? "TRUE" : "FALSE"));
            
        }
        else if ([menuSelection isEqualToString:@"l"]) {
            _graph = [SJHGraphDriver standardGraph];
        }
        else if ([menuSelection isEqualToString:@"p"]) {
            char originNode[50] = {0};
            
            printf("Enter origin node: ");
            scanf("%s", originNode);
            
            SJHGraph *path = [_graph shortestPath:[SJHGraphNode nodeWithValue:[NSString stringWithUTF8String:originNode]]];
            
            printf("%s", [[path description] UTF8String]);
        }

        
        else if([menuSelection isEqualToString:@"d"]){
            printf("%s", [[_graph description] UTF8String]);
        }
        else if(![menuSelection isEqualToString:@"q"]){
            printf("\nError: %s is not a valid menu selection.", [menuSelection UTF8String]);
            
        }
        
    } while (![menuSelection isEqualToString:@"q"]);
}

@end
