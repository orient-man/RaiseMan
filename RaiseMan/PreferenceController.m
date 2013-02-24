//
//  PreferenceController.m
//  RaiseMan
//
//  Created by Marcin Malinowski on 2013-02-03.
//  Copyright (c) 2013 Marcin Malinowski. All rights reserved.
//

#import "PreferenceController.h"

@implementation PreferenceController

NSString * const BNRTableBgColorKey = @"TableBackgroundColor";
NSString * const BNREmptyDocKey = @"EmptyDocumentFlag";
NSString * const BNRColorChangedNotification = @"BNRColorChanged";

- (id)init
{
    self = [super initWithWindowNibName:@"Preferences"];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (NSColor *)tableBgColor
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *colorAsData = [defaults objectForKey:BNRTableBgColorKey];
    return [NSKeyedUnarchiver unarchiveObjectWithData:colorAsData];
}

- (BOOL)emptyDoc
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:BNREmptyDocKey];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    [colorWell setColor:[self tableBgColor]];
    [checkbox setState:[self emptyDoc]];
    NSLog(@"Nib file loaded");
}

- (void)changeBackgroundColor:(id)sender
{
    NSColor *color = [colorWell color];
    NSData *colorAsData = [NSKeyedArchiver archivedDataWithRootObject:color];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:colorAsData forKey:BNRTableBgColorKey];

    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:BNRColorChangedNotification object:self];

    NSLog(@"Color changed: %@", color);
}

- (void)changeNewEmptyDoc:(id)sender
{
    NSInteger state = [checkbox state];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:state forKey:BNREmptyDocKey];
    NSLog(@"Checkbox changed %ld", state);
}

- (IBAction)reset:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:BNRTableBgColorKey];
    [defaults removeObjectForKey:BNREmptyDocKey];
    [colorWell setColor:[self tableBgColor]];
    [checkbox setState:[self emptyDoc]];
    NSLog(@"Prefrences reseted");
}

@end
