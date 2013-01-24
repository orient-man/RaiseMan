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

- (void)testSorting
{
    // arrange
    NSMutableArray *array =
        [[NSMutableArray alloc] initWithObjects: @"b", @"a", @"A", @"ą", nil];

    // act
    [array sortUsingComparator:^(NSString *s1, NSString* s2) {
        return [s1 caseInsensitiveCompare:s2];
    }];

    // assert
    STAssertEqualObjects(@"aAąb",
                         [array componentsJoinedByString:@""],
                         @"wrong sort");
}
@end
