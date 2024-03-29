//
//  Person.m
//  RaiseMan
//
//  Created by Marcin Malinowski on 2013-01-24.
//  Copyright (c) 2013 Marcin Malinowski. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id)init
{
    self = [super init];
    if (self == nil) {
        return nil;
    }

    expectedRaise = 0.0;
    personName = @"New Person";

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self == nil) {
        return nil;
    }
    personName = [aDecoder decodeObjectForKey:@"personName"];
    expectedRaise = [aDecoder decodeFloatForKey:@"expectedRaise"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:personName forKey:@"personName"];
    [aCoder encodeFloat:expectedRaise forKey:@"expectedRaise"];
}

- (void)setNilValueForKey:(NSString *)key
{
    if ([key isEqualToString:@"expectedRaise"]) {
        [self setExpectedRaise:0.0];
    }
    else {
        [super setNilValueForKey:key];
    }
}

@synthesize personName;
@synthesize expectedRaise;
@end
