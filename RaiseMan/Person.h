//
//  Person.h
//  RaiseMan
//
//  Created by Marcin Malinowski on 2013-01-24.
//  Copyright (c) 2013 Marcin Malinowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding> {
    NSString *personName;
    float expectedRaise;
}

@property (copy) NSString *personName;
@property float expectedRaise;

@end
