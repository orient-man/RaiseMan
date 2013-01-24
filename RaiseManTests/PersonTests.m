//
//  PersonTests.m
//  RaiseMan
//
//  Created by Marcin Malinowski on 2013-01-24.
//  Copyright (c) 2013 Marcin Malinowski. All rights reserved.
//

#import "PersonTests.h"
#import "Person.h"

@implementation PersonTests

- (void)testDefaultValueForRaise
{
    Person *person = [[Person alloc] init];

    STAssertEqualObjects([person valueForKey:@"expectedRaise"],
                         [NSNumber numberWithFloat:5.0],
                         @"default value is 5.0");
}

- (void)testSettingNilShouldResetValueToZero
{
    // arrange
    Person *person = [[Person alloc] init];

    // act
    [person setValue:nil forKey:@"expectedRaise"];

    // assert
    STAssertEqualObjects([person valueForKey:@"expectedRaise"],
                         [NSNumber numberWithFloat:0.0],
                         @"not 0");
}

@end
