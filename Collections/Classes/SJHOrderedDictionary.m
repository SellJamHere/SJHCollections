//
//  SJHOrderedDictionary.m
//  Collections
//
//  Created by James Heller on 8/22/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import "SJHOrderedDictionary.h"

@interface SJHOrderedDictionary ()

@property (strong, nonatomic) NSArray *keys;
@property (strong, nonatomic) NSDictionary *dictionary;

@end

@implementation SJHOrderedDictionary

-(id)initWithObjects:(NSArray *)objects forKeys:(NSArray *)keys{
    self = [super init];
    if(self){
        NSMutableArray *tempKeys = [[NSMutableArray alloc] initWithCapacity:[keys count]];
        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] initWithCapacity:[objects count]];
        
        for (int i = 0; i < [keys count]; i++) {
            [tempKeys addObject:keys[i]];
            [tempDict setObject:objects[i] forKey:keys[i]];
        }
        
        _keys = [tempKeys copy];
        _dictionary = [tempDict copy];
    }
    return self;
}

-(NSUInteger)count{
    return [_keys count];
}

-(id)objectForKey:(id)aKey{
    return [_dictionary objectForKey:aKey];
}

-(NSEnumerator *)keyEnumerator{
    return [_keys objectEnumerator];
}

@end
