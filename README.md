# SJHCollections

SJHCollections is a set of high level collections based on the NSArray and NSDictionary classes.

## SJHOrderedDictionary

SJHOrderedDictionary (and SJHMutableOrderedDictionary) is an NSDictionary (or NSMutableDictionary) subclass. Internally, they are implemented with an NSArray storing keys in order, and an NSDictionary storing key/value pairs. Iteration is implemented using the key array, allowing for ordered traversal.

## SJHStack

SJHStack is mutable. Implementation is a little wonky, as it subclasses NSArray, throwing exceptions in methods ill fit for a stack.

## SJHQueue

SJHQueue is mutable. Implementation is much like SJHStack, where it throws exceptions for methods ill fitting of a queue.

# CollectionsTests

The CollectionsTests.h header file contains kTestSize, used to determine the number of integers stored during each test.

## SJHOrderedDictionaryTests

Tests both SJHOrderedDictionary and SJHMutableOrderedDictionary.

## SJHStackTests

Tests SJHStack.

## SJHQueueTests

Tests SJHQueue.
