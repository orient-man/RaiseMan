//
//  PreferenceController.h
//  RaiseMan
//
//  Created by Marcin Malinowski on 2013-02-03.
//  Copyright (c) 2013 Marcin Malinowski. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const BNRTableBgColorKey;
extern NSString * const BNREmptyDocKey;

@interface PreferenceController : NSWindowController {
    IBOutlet NSColorWell *colorWell;
    IBOutlet NSButton *checkbox;
}

- (NSColor *)tableBgColor;
- (BOOL)emptyDoc;
- (IBAction)changeBackgroundColor:(id)sender;
- (IBAction)changeNewEmptyDoc:(id)sender;
- (IBAction)reset:(id)sender;

@end
