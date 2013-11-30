//
//  SJHDriver.h
//  Collections
//
//  Created by James Heller on 11/27/13.
//  Copyright (c) 2013 SellJamHere. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SJHDriver <NSObject>

- (void)processCommands;

- (NSString *)presentMenu;

@end
