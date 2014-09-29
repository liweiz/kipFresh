//
//  KFBox.m
//  kipFresh
//
//  Created by Liwei Zhang on 2014-09-25.
//  Copyright (c) 2014 Liwei Zhang. All rights reserved.
//

#import "KFBox.h"
#import "KFItem.h"

@implementation KFBox

@synthesize appRect;
@synthesize ctx;
@synthesize fReq;
@synthesize fResultsCtl;
@synthesize sortSelection;
@synthesize warningText;

- (id)init
{
    self = [super init];
    if (self) {
        self.sortSelection = [NSMutableArray arrayWithCapacity:0];
        [self.sortSelection addObject:[NSNumber numberWithInteger:KFSortTimeCreatedD]];
        self.warningText = [[NSMutableString alloc] init];
    }
    return self;
}

- (void)prepareDataSource
{
    if (!self.fReq) {
        self.fReq = [NSFetchRequest fetchRequestWithEntityName:@"KFItem"];
    }
    self.fReq.sortDescriptors = [self sortOption:self.sortSelection];
    // Config fetchResultController
    self.fResultsCtl = [[NSFetchedResultsController alloc] initWithFetchRequest:self.fReq managedObjectContext:self.ctx sectionNameKeyPath:nil cacheName:nil];
    self.fResultsCtl.delegate = self;
    [self.fResultsCtl performFetch:nil];
}

#pragma mark - fetchedResultsController delegate callbacks

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"startTableChange" object:self];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithCapacity:0];
    [d setValue:indexPath forKey:@"indexPath"];
    [d setValue:newIndexPath forKey:@"newIndexPath"];
    [d setValue:[NSNumber numberWithUnsignedInteger:type] forKey:@"type"];
    NSNotification *n = [NSNotification notificationWithName:@"runTableChange" object:self userInfo:d];
    [[NSNotificationCenter defaultCenter] postNotification:n];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"endTableChange" object:self];
}


- (NSArray *)sortOption:(NSArray *)options
{
    NSMutableArray *ma = [NSMutableArray arrayWithCapacity:0];
    for (NSNumber *n in options) {
        NSSortDescriptor *sd = [self sortBy:n.integerValue];
        [ma addObject:sd];
    }
    return ma;
}

- (NSSortDescriptor *)sortBy:(NSInteger)by
{
    switch (by) {
        case KFSortCellTextAlphabetA:
            return [NSSortDescriptor sortDescriptorWithKey:@"notes" ascending:YES comparator:^(NSString *obj1, NSString *obj2) {
                return [obj1 localizedCompare:obj2];
            }];
        case KFSortCellTextAlphabetD:
            return [NSSortDescriptor sortDescriptorWithKey:@"notes" ascending:NO comparator:^(NSString *obj1, NSString *obj2) {
                return [obj1 localizedCompare:obj2];
            }];
        case KFSortTimeLeftA:
            return [[NSSortDescriptor alloc] initWithKey:@"bestBefore" ascending:YES];
        case KFSortTimeLeftD:
            return [[NSSortDescriptor alloc] initWithKey:@"bestBefore" ascending:NO];
        case KFSortTimeCreatedA:
            return [[NSSortDescriptor alloc] initWithKey:@"timeAdded" ascending:YES];
        case KFSortTimeCreatedD:
            return [[NSSortDescriptor alloc] initWithKey:@"timeAdded" ascending:NO];
        default:
            return nil;
    }
}



- (BOOL)saveToDb
{
    NSError *err;
    [self.ctx save:&err];
    if (err) {
        return NO;
    } else {
        return YES;
    }
}

@end
