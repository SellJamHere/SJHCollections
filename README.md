# SJHCollections

SJHCollections is a set of high level collections based on the NSArray and NSDictionary classes.

## SJHOrderedDictionary

SJHOrderedDictionary (and SJHMutableOrderedDictionary) is an NSDictionary (or NSMutableDictionary) subclass. Internally, they are implemented with an NSArray storing keys in order, and an NSDictionary storing key/value pairs. Iteration is implemented using the key array, allowing for ordered traversal.

## SJHStack

SJHStack is mutable. Implementation is a little wonky, as it subclasses NSArray, throwing exceptions in methods ill fit for a stack. A more perfect solution would be to create a new class implementing the necessary delegates.

## SJHCollectionProtocol

SJHCollectionProtocol provies and interface for general datastructure operations.

### SJHListQueue

SJHListQueue is a mutable linked-list based FIFO queue. New items are added to the rear, and removed from the front, allowing for a singly linked list.

# CollectionsTests

Unit tests for collections. Collections conforming to SJHCollectionProtocol run a generic test in SJHCollectionProtocolTests. Specific tests for a datastructure must be written in supporting test files.

## SJHCollectionProtocolTests

Supports generic testing of structure methods. As different datastructures require different forms data insertion and removal, certain methods should also be tested in seperate test files. For example, add is tested, but only for data containment and concurrent iterator modifications.

The following methods should be tested seperately:
* add
* remove
* toArray
* equals

