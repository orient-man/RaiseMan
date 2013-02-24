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

+ (void)initialize
{
    NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
    NSData *colorAsData =
        [NSKeyedArchiver archivedDataWithRootObject: [NSColor yellowColor]];

    // defaults
    [defaultValues setObject:colorAsData forKey:BNRTableBgColorKey];
    [defaultValues setObject:[NSNumber numberWithBool:YES] forKey:BNREmptyDocKey];

    // register them
    [[NSUserDefaults standardUserDefaults] registerDefaults: defaultValues];

    NSLog(@"registered defaults: %@", defaultValues);
}

// UWAGA: wymaga ustawienia przed "Edit Scheme": Launch app without state restoration
- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender
{
    NSLog(@"applicationShouldOpenUntitledFile:");
    return [[NSUserDefaults standardUserDefaults] boolForKey:BNREmptyDocKey];
}

- (void)showPreferencePanel:(id)sender
{
    if (!preferenceController) {
        preferenceController = [[PreferenceController alloc] init];
    }

    NSLog(@"showing %@", preferenceController);
    [preferenceController showWindow:self];
}

- (IBAction)showAboutPanel:(id)sender
{
    if (!aboutPanel) {
        // sets aboutPanel
        if (![NSBundle loadNibNamed:@"About" owner:self]) {
            NSLog(@"Ups! Not loaded");
        }
        else {
            NSLog(@"Loaded");
        }
    }
    else {
        NSLog(@"Already loaded");
    }

    [aboutPanel makeKeyAndOrderFront:nil];
}
@end
