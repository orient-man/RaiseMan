//
//  AppController.m
//  RaiseMan
//
//  Created by Marcin Malinowski on 2013-02-03.
//  Copyright (c) 2013 Marcin Malinowski. All rights reserved.
//

#import "AppController.h"
#import "PreferenceController.h"

@implementation AppController

- (void)showPreferencePanel:(id)sender
{
    if (!preferenceController) {
        preferenceController = [[PreferenceController alloc] init];
    }

    NSLog(@"showing %@", preferenceController);
    [preferenceController showWindow:self];
}

@end
