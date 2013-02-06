//
//  AppController.h
//  RaiseMan
//
//  Created by Marcin Malinowski on 2013-02-03.
//  Copyright (c) 2013 Marcin Malinowski. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PreferenceController;

@interface AppController : NSObject <NSApplicationDelegate> {
    PreferenceController *preferenceController;
}

- (IBAction)showPreferencePanel:(id)sender;

@end
