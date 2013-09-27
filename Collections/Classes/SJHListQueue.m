//
//  SJHListQueue.m
//  Collections
//
//  Created by James Heller on 9/26/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

/* Complexities
//add         :
//addAll      :
//remove      :
//clear       :
//peek        :
//isEmpty     :
//size        :
//iterator    :
//  hasNext   :
//  next      :
//  remove    :
//toArray     :
//newEmpty    :
//shallowCopy :
//toString    :
//equals      :
//hashCode    :
 */

#import "SJHListQueue.h"

@interface ListNode : NSObject <NSCopying>

@property (strong, nonatomic) id value;
@property (strong, nonatomic) ListNode *next;

- (id)initWithValue:(id)value next:(ListNode *)next;

- (void)destroy;

@end

@interface LinkedQueueEnumerator : NSEnumerator

@property (strong, nonatomic) SJHListQueue *queue; //Retain the queue while iterating

@property (weak, nonatomic) ListNode *previous;
@property (weak, nonatomic) ListNode *seen;
@property (weak, nonatomic) ListNode *next;
@property NSInteger remainingNodeCount;
@property NSInteger expectedModCount;
//@property BOOL removedAlready;    //Used in - (void)remove;

- (id)initWithQueue:(SJHListQueue *)queue;

//Methods are unnecessary, as LinkedQueueEnumerator is not visible outside of SJHListQueue
//- (BOOL)hasNext;
//- (void)remove;

@end

@interface SJHListQueue ()

@property (strong, nonatomic) ListNode *front;
@property (strong, nonatomic) ListNode *rear;
@property NSInteger objectCount;
@property NSInteger modCount;

@end

@implementation SJHListQueue

- (id)init{
    self = [super init];
    if (self){
        
    }
    return self;
}

- (id)initWithIterable:(id<NSFastEnumeration>)iterable{
    self = [super init];
    if (self){
        for (id object in iterable) {
            [self add:object];
        }
    }
    return self;
}

//Insertion and removal

//Nodes are added to the rear
- (BOOL)add:(id)object{

    _rear.next = [[ListNode alloc] initWithValue:object next:nil];
    _rear = _rear.next;
    
    if (!_front){
        _front = _rear;
    }
    
    _objectCount++;
    _modCount++;
    
    return YES;
}

- (BOOL)addAll:(id<NSFastEnumeration>)objects{
    
    BOOL modified = NO;
    
    for (id object in objects) {
        if ([self add:object]){
            _objectCount++;
            modified = YES;
        }
    }
    
    return modified;
}

//Nodes are removed from the front
- (id)remove{
    
    ListNode *node = _front;
    _front = _front.next;
    
    _objectCount--;
    _modCount++;
    
    return node.value;
}

- (void)clear{
    for (ListNode *node in [self enumerator]) {
        [node destroy];
    }
    
    _front = nil;
    _rear = nil;
    _objectCount = 0;
    _modCount = 0;
}

//Queries
- (id)peak{
    return _front.value;
}

- (BOOL)isEmpty{
    if (!_front){
        return YES;
    }
    return NO;
}

- (NSInteger)count{
    return _objectCount;
}

//Misc
- (NSEnumerator *)enumerator{
    return [[LinkedQueueEnumerator alloc] initWithQueue:self];
}

- (NSArray *)toArray{
    return [[self enumerator] allObjects];
}

//- (id<SJHCollectionProtocol>)copy{
//    
//}

- (id)copyWithZone:(NSZone *)zone{
    id copy = [[[self class] alloc] init];
    
    if(copy){
        [copy setFront:[_front copyWithZone:zone]];
        [copy setRear:[_rear copyWithZone:zone]];
        
        [copy setObjectCount:_objectCount];
        [copy setModCount:_modCount];
    }
    return copy;
}

//Inherited
- (NSString *)description{
    //TODO: Add string destription function
    return @"";
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    return [self isEqualToListQueue:other];
}

- (BOOL)isEqualToListQueue:(SJHListQueue *)queue {
    if (self == queue)
        return YES;
    if (![[self front] isEqual:[queue front]])
        return NO;
    if (![[self rear] isEqual:[queue rear]])
        return NO;
    
    NSEnumerator *enumerator = [queue enumerator];
    for (id value in [self enumerator]) {
        if (![value isEqual:[enumerator nextObject]]){
            return NO;
        }
    }
    return YES;
}

- (NSInteger)hash{
    //TODO: Add hash function
    return 0;
}


@end

//Private Implementation of List Node
@implementation ListNode

- (id)initWithValue:(id)value next:(ListNode *)next{
    self = [super init];
    if (self){
        _value = value;
        _next = next;
    }
    return self;
}

- (void)destroy{
    _value = nil;
    _next = nil;
}

//copy is recursive across all nodes.
- (id)copyWithZone:(NSZone *)zone{
    id copy = [[[self class] alloc] init];
 
    if (copy){
        [copy setValue:_value];
        [copy setNext:[_next copyWithZone:zone]];
    }
    return copy;
}

@end

//Private Implementation of ListQueueIterator
@implementation LinkedQueueEnumerator

- (id)initWithQueue:(SJHListQueue *)queue{
    self = [super init];
    if (self){
        _queue = queue;
        _next = _queue.front;
        _expectedModCount = _queue.modCount;
        
    }
    return self;
}

- (BOOL) hasNext{
    return (_next != nil);
}

//Inherited methods

//An array of objects the receiver has yet to enumerate.
//
//Discussion
//Put another way, the array returned by this method does not contain objects that have already been enumerated with previous nextObject messages.
//Invoking this method exhausts the enumerator’s collection so that subsequent invocations of nextObject return nil.
- (NSArray *)allObjects{
    NSMutableArray *allObjects = [[NSMutableArray alloc] initWithCapacity:_remainingNodeCount];
    
    while ([self hasNext]){
        [allObjects addObject:[self nextObject]];
    }
    return [allObjects copy];
}

- (id)nextObject{
    if (_queue.modCount != _expectedModCount){
        [NSException raise:@"ConcurrentModificationException" format:@"LinkedQueueEnumerator.nextObject"];
    }
    
    _seen = _next;
    _next = [_next next];
    _remainingNodeCount--;
    
    return _seen.value;
}

@end
