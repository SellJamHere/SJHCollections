//
//  SJHAppDelegate.m
//  Collections
//
//  Created by James Heller on 9/18/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import "SJHAppDelegate.h"

#import "SJHOrderedDictionaryDriver.h"

@implementation SJHAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    //Run Drivers Here
    
    SJHOrderedDictionaryDriver *driver = [[SJHOrderedDictionaryDriver alloc] init];
    
    [driver processCommands];
    
    [NSApp terminate:self];
}

@end
