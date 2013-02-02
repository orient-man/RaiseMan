//
//  Document.h
//  RaiseMan
//
//  Created by Marcin Malinowski on 2013-01-24.
//  Copyright (c) 2013 Marcin Malinowski. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class Person;

@interface Document : NSDocument {
    NSMutableArray *employees;
    IBOutlet NSTableView *tableView;
    IBOutlet NSArrayController *employeeController;
}

- (void)setEmployees:(NSMutableArray *)array;
- (IBAction)createEmployee:(id)sender;
- (void)insertObject:(Person *)person inEmployeesAtIndex:(int)index;
- (void)removeObjectFromEmployeesAtIndex:(int)index;

@end
