# SJHCollections

SJHCollections is a set of high level collections subclassing NSArray and NSDictionary. These classes aren't absolutely necessary, as they can be implemented in-code. However, I've found these classes reduce complexity in most pre-optimization cases.

## SJHOrderedDictionary

SJHOrderedDictionary (and SJHMutableOrderedDictionary) is an NSDictionary (or NSMutableDictionary) subclass. Internally, they are implemented with an NSArray storing keys in order, and an NSDictionary storing key/value pairs. Iteration is implemented using the key array, allowing for ordered traversal.

An in-code implementation requres declaring an NSArray* to store keys in order, and an NSDicionary for the key value parings. The dictinary can then be traversed with

	NSArray *orderedKeys = ...;
	NSDictionary *dictionary = ...;

	for (id key in orderedKeys) {
		id value = [dictionary objectForKey: key];
		//Do Something
	}

Both isEqual: and isEqualToDictionary: can be used for equality. It should be noted that order is important when comparing an NSDictionary to a SJHOrderedDictionary, in that the NSDictionary must be the object from which isEqual: is called.

	NSDictionary *dictionary = ...;
	SJHOrderedDictionary *orderedDictionary = ...;

	[dictionary isEqualTo: orderedDictionary];  //returns YES
	[orderedDictionary isEqualTo: dictionary];  //returns NO


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

Tests SJHOrderedDictionary.

TODO: Implement the following tests:
* removeObjectForKey
* removeObjectAtIndex
* keyForObject
* keyForObjectAtIndex
* indexOfObject
* indexOfObjectWithKey
* objectAtIndex
* allKeys
* allValues
* keyEnumerator
* reverseKeyEnumerator
* enumerateKeysAndObjectsUsingBlock
* isEqual
* isEqualToDictionary
* copy
* mutableCopy

## SJHStackTests

Tests SJHStack.

## SJHQueueTests

Tests SJHQueue.
