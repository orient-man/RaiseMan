//
//  PreferenceController.m
//  RaiseMan
//
//  Created by Marcin Malinowski on 2013-02-03.
//  Copyright (c) 2013 Marcin Malinowski. All rights reserved.
//

#import "PreferenceController.h"

@implementation PreferenceController

- (id)init
{
    self = [super initWithWindowNibName:@"Preferences"];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    NSLog(@"Nib file loaded");
}

- (void)changeBackgroundColor:(id)sender
{
    NSColor *color = [colorWell color];
    NSLog(@"Color changed: %@", color);
}

- (void)changeNewEmptyDoc:(id)sender
{
    NSInteger state = [checkbox state];
    NSLog(@"Checkbox changed %ld", state);
}

@end
