//
//  DocumentTests.m
//  RaiseMan
//
//  Created by Marcin Malinowski on 2013-01-27.
//  Copyright (c) 2013 Marcin Malinowski. All rights reserved.
//

#import "DocumentTests.h"
#import "Document.h"

@implementation DocumentTests

- (void)test
{
    Document *doc = [[Document alloc] init];
    id arrayProxy = [doc mutableArrayValueForKey:@"employees"];

    STAssertEqualObjects([NSNumber numberWithUnsignedInteger:[arrayProxy count]],
                         [NSNumber numberWithUnsignedInt:0],
                         @"array should be empty");
}

@end
