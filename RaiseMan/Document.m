//
//  Document.m
//  RaiseMan
//
//  Created by Marcin Malinowski on 2013-01-24.
//  Copyright (c) 2013 Marcin Malinowski. All rights reserved.
//

#import "Document.h"
#import "Person.h"

@implementation Document

- (id)init
{
    self = [super init];
    if (self) {
        employees = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setEmployees:(NSMutableArray *)array
{
    if (array == employees) {
        return;
    }

    for (Person *person in employees) {
        [self stopObservingPerson:person];
    }

    employees = array;

    for (Person *person in employees) {
        [self startObservingPerson:person];
    }
}

- (void)createEmployee:(id)sender
{
    NSWindow *window = [tableView window];

    BOOL editingEnded = [window makeFirstResponder:window];
    if (!editingEnded) {
        NSLog(@"Unable to end editing");
        return;
    }

    NSUndoManager *undo = [self undoManager];
    if ([undo groupingLevel]) {
        [undo endUndoGrouping];
        [undo beginUndoGrouping];
    }

    Person *person = [employeeController newObject];
    [employeeController addObject:person];

    // re-sort
    [employeeController rearrangeObjects];
    NSArray *array = [employeeController arrangedObjects];
    NSUInteger row = [array indexOfObjectIdenticalTo:person];

    NSLog(@"starting edit of %@ in row %ld", person, row);
    [tableView editColumn:0 row:row withEvent:nil select:YES];
}

- (void)insertObject:(Person *)person inEmployeesAtIndex:(int)index
{
    NSLog(@"adding %@ to %@", person, employees);

    NSUndoManager *undo = [self undoManager];
    [[undo prepareWithInvocationTarget:self] removeObjectFromEmployeesAtIndex:index];
    if (![undo isUndoing]) {
        [undo setActionName:@"Insert Person"];
    }

    [self startObservingPerson:person];
    [employees insertObject:person atIndex:index];
}

-(void)removeObjectFromEmployeesAtIndex:(int)index
{
    Person *person = [employees objectAtIndex:index];

    NSLog(@"removing %@ from %@", person, employees);

    NSUndoManager *undo = [self undoManager];
    [[undo prepareWithInvocationTarget:self] insertObject:person
                                       inEmployeesAtIndex:index];
    if (![undo isUndoing]) {
        [undo setActionName:@"Delete Person"];
    }

    [self stopObservingPerson:person];
    [employees removeObjectAtIndex:index];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    NSUndoManager *undo = [self undoManager];
    id oldValue = [change objectForKey:NSKeyValueChangeOldKey];

    if (oldValue == [NSNull null]) {
        oldValue = nil;
    }
    NSLog(@"oldValue = %@", oldValue);
    [[undo prepareWithInvocationTarget:self] changeKeyPath:keyPath
                                                  ofObject:object
                                                   toValue:oldValue];
    [undo setActionName:@"Edit"];
}

- (void)changeKeyPath:(NSString *)keyPath
             ofObject:(id)obj
              toValue:(id)newValue
{
    [obj setValue:newValue forKeyPath:keyPath];
}

- (void)startObservingPerson:(Person *)person
{
    [person addObserver:self
             forKeyPath:@"personName"
                options:NSKeyValueObservingOptionOld
                context:NULL];

    [person addObserver:self
             forKeyPath:@"expectedRaise"
                options:NSKeyValueObservingOptionOld
                context:NULL];
}

- (void)stopObservingPerson:(Person *)person
{
    [person removeObserver:self forKeyPath:@"personName"];
    [person removeObserver:self forKeyPath:@"expectedRaise"];
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"Document";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

#pragma mark - saving/loading

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    [[tableView window] endEditingFor:nil];
    return [NSKeyedArchiver archivedDataWithRootObject:employees];
}

- (BOOL)readFromData:(NSData *)data
              ofType:(NSString *)typeName
               error:(NSError **)outError
{
    NSLog(@"About to read data of type %@", typeName);
    NSMutableArray *newArray = nil;
    @try {
        newArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    @catch (NSException *exception) {
        if (outError) {
            NSDictionary *dict =
                [NSDictionary dictionaryWithObject:@"The data is corrupted."
                                            forKey:NSLocalizedFailureReasonErrorKey];
            *outError = [NSError errorWithDomain:NSOSStatusErrorDomain
                                            code:unimpErr
                                        userInfo:dict];
        }
        return NO;
    }

    [self setEmployees:newArray];
    return YES;
}

@end
