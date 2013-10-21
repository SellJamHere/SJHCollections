# SJHCollections

SJHCollections is a set of high level collections based on the NSArray and NSDictionary classes. These classes aren't absolutely necessary, as they can be implemented in-code, but, while they aren't optimized, I've found these classes reduce complexity in most simple cases. 

## SJHOrderedDictionary

SJHOrderedDictionary (and SJHMutableOrderedDictionary) is an NSDictionary (or NSMutableDictionary) subclass. Internally, they are implemented with an NSArray storing keys in order, and an NSDictionary storing key/value pairs. Iteration is implemented using the key array, allowing for ordered traversal.

An in-code implementation requres declaring an NSArray* to store keys in order, and an NSDicionary for the key value parings. The dictinary could then be traversed with

	for (id key in keys) {
		id value = [values objectForKey: key];
		//code away
	}


## SJHStack

SJHStack is mutable. Implementation is a little wonky, as it subclasses NSArray, throwing exceptions in methods ill fit for a stack. Items are added and removed from the rear of the underlying array, taking advantage of NSArray optimizations.

An in-code implementation is possible by declaring an NSArray* to which you add with

	[array addObject: anObject];

and remove with

	id object = [array lastObject];
	[array removeLastObject];


## SJHQueue

SJHQueue is mutable. Implementation is much like SJHStack, where it throws exceptions for methods ill fitting of a queue. Items are added to the rear and removed from the front.

An in-code implementation is possible by declaring an NSArray* to which you add with

	[array addObject: anObject];

and remove with

	id object = [array objectAtIndex:0];
	[array removeObjectAtIndex:0];


# CollectionsTests

The CollectionsTests.h header file contains kTestSize, used to determine the number of integers stored during each test.

## SJHOrderedDictionaryTests

Tests both SJHOrderedDictionary and SJHMutableOrderedDictionary.

## SJHStackTests

Tests SJHStack.

## SJHQueueTests

Tests SJHQueue.
