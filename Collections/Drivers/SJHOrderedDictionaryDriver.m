//
//  SJHOrderedDictionaryDriver.m
//  Collections
//
//  Created by James Heller on 11/15/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import "SJHOrderedDictionaryDriver.h"

#import "SJHOrderedDictionary.h"

@interface SJHOrderedDictionaryDriver ()

@property (strong, nonatomic) SJHOrderedDictionary *orderedDictionary;

@end

static NSString *preface = @"Ordered Dictionary";

@implementation SJHOrderedDictionaryDriver

- (id)init{
    self = [super init];
    if(self)
    {
        _orderedDictionary = [SJHOrderedDictionary dictionary];
    }
    return self;
}

- (NSString *)presentMenu{
    printf("\n\n\n%s  Mutators                      Accessors                    General\n", [preface UTF8String]);
    printf("%s  s - setObject:forKey              c - count                    d - description\n", [preface UTF8String]);
    printf("%s  sa - setObject:forKey:afterKey    o - objectForKey             q - quit\n", [preface UTF8String]);
    printf("%s  sb - setObject:forKey:beforeKey   k - keyForObject             \n", [preface UTF8String]);
    printf("%s  rk - removeObjectForKey           ki - keyForObjectAtIndex\n", [preface UTF8String]);
    printf("%s  ri - removeObjectAtIndex          i - indexOfObject\n", [preface UTF8String]);
    printf("%s  R - removeAllObjects              ik - indexOfObjectWithKey\n", [preface UTF8String]);
    printf("%s                                    oi - objectAtIndex\n", [preface UTF8String]);
    printf("%s                                    ak - allKeys\n", [preface UTF8String]);
    printf("%s                                    av - allValues\n", [preface UTF8String]);
    printf("\nEnter Command: ");
    
    char str[50] = {0};
    scanf("%s", str);
    return [NSString stringWithUTF8String:str];
}

- (void)processCommands{
    
    NSString *menuSelection;
    
    do {
        menuSelection = [self presentMenu];
        
        if ([menuSelection isEqualToString:@"s"]) {
            char object[50] = {0};
            char key[50] = {0};
            
            printf("Enter object: ");
            scanf("%s", object);
            printf("Enter key: ");
            scanf("%s", key);
            [_orderedDictionary setObject:[NSString stringWithUTF8String:object] forKey:[NSString stringWithUTF8String:key]];
        }
        else if ([menuSelection isEqualToString:@"sa"]) {
            char object[50] = {0};
            char key[50] = {0};
            char afterKey[50] = {0};
            
            printf("Enter object: ");
            scanf("%s", object);
            printf("Enter key: ");
            scanf("%s", key);
            printf("Enter key for insertion after: ");
            scanf("%s", afterKey);
            [_orderedDictionary setObject:[NSString stringWithUTF8String:object] forKey:[NSString stringWithUTF8String:key] afterKey:[NSString stringWithUTF8String:afterKey]];
        }
        else if ([menuSelection isEqualToString:@"sb"]) {
            char object[50] = {0};
            char key[50] = {0};
            char beforeKey[50] = {0};
            
            printf("Enter object: ");
            scanf("%s", object);
            printf("Enter key: ");
            scanf("%s", key);
            printf("Enter key for insertion before: ");
            scanf("%s", beforeKey);
            [_orderedDictionary setObject:[NSString stringWithUTF8String:object] forKey:[NSString stringWithUTF8String:key] beforeKey:[NSString stringWithUTF8String:beforeKey]];
        }
        else if ([menuSelection isEqualToString:@"rk"]) {
            char key[50] = {0};

            printf("Enter key: ");
            scanf("%s", key);
            [_orderedDictionary removeObjectForKey:[NSString stringWithUTF8String:key]];
        }
        else if ([menuSelection isEqualToString:@"ri"]) {
            int index;
            
            printf("Enter index: ");
            scanf("%d", &index);
            [_orderedDictionary removeObjectAtIndex:index];
        }
        else if ([menuSelection isEqualToString:@"R"]) {
            [_orderedDictionary removeAllObjects];
        }
        else if ([menuSelection isEqualToString:@"c"]) {
            printf("Count: %ld", [_orderedDictionary count]);
        }
        else if ([menuSelection isEqualToString:@"o"]) {
            char key[50] = {0};
            
            printf("Enter key: ");
            scanf("%s", key);
            printf("Object: %s", [[_orderedDictionary objectForKey:[NSString stringWithUTF8String:key]] UTF8String]);
        }
        else if ([menuSelection isEqualToString:@"k"]) {
            char object[50] = {0};
            
            printf("Enter object: ");
            scanf("%s", object);

            printf("Key: %s", [[_orderedDictionary keyForObject:[NSString stringWithUTF8String:object]] UTF8String]);
        }
        else if ([menuSelection isEqualToString:@"ki"]) {
            int index;
            
            printf("Enter index: ");
            scanf("%d", &index);
            printf("Key: %s", [[_orderedDictionary keyForObjectAtIndex:index] UTF8String]);
        }
        else if ([menuSelection isEqualToString:@"i"]) {
            char object[50] = {0};
            
            printf("Enter object: ");
            scanf("%s", object);
            printf("Index: %ld", [_orderedDictionary indexOfObject:[NSString stringWithUTF8String:object]]);
        }
        else if ([menuSelection isEqualToString:@"ik"]) {
            char key[50] = {0};
            
            printf("Enter key: ");
            scanf("%s", key);
            printf("Index: %ld", [_orderedDictionary indexOfObjectWithKey:[NSString stringWithUTF8String:key]]);
        }
        else if ([menuSelection isEqualToString:@"oi"]) {
            int index;
            
            printf("Enter index: ");
            scanf("%d", &index);
            printf("Object: %s", [[_orderedDictionary objectAtIndex:index] UTF8String]);
        }
        else if([menuSelection isEqualToString:@"ak"]){
            NSMutableString *keys = [[NSMutableString alloc] init];
            
            for (id key in [_orderedDictionary allKeys]) {
                [keys appendFormat:@"%@ -> ", key];
            }
            
            printf("Keys: %s", [[keys substringToIndex:[keys length] - 4] UTF8String]);
        }
        else if([menuSelection isEqualToString:@"ak"]){
            NSMutableString *values = [[NSMutableString alloc] init];
            
            for (id value in [_orderedDictionary allValues]) {
                [values appendFormat:@"%@ -> ", value];
            }
            
            printf("Values: %s", [[values substringToIndex:[values length] - 4] UTF8String]);
        }
        else if([menuSelection isEqualToString:@"d"]){
            printf("%s",[[_orderedDictionary description] UTF8String]);
        }
        else if([menuSelection isEqualToString:@"q"]){
        }
        else if(![menuSelection isEqualToString:@"q"]){
            printf("\nError: %s is not a valid menu selection.", [menuSelection UTF8String]);
            
        }
        
    } while (![menuSelection isEqualToString:@"q"]);
}

@end
