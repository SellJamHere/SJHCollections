# SJHCollections

SJHCollections is a set of high level collections based on the NSArray and NSDictionary classes.

## SJHOrderedDictionary

SJHOrderedDictionary has both mutable and immutable versions.

## SJHStack

SJHStack is mutable. Implementation is a little wonky, as it subclasses NSArray, throwing exceptions in methods ill fit for a stack. A more perfect solution would be to create a new class implementing the necessary delegates.

## SJHListQueue

SJHListQueue is a mutable linked-list based queue. It implements an NSEnumerator for fast enumeration.
