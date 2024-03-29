//
//  KFBox.m
//  kipFresh
//
//  Created by Liwei Zhang on 2014-09-25.
//  Copyright (c) 2014 Liwei Zhang. All rights reserved.
//

#import "KFBox.h"
#import "KFItem.h"
#import "NSObject+KFExtra.h"

@implementation KFBox

@synthesize appRect;
@synthesize ctx;
@synthesize fReq;
@synthesize fResultsCtl;
@synthesize sortSelection;
@synthesize warningText;
@synthesize originX;
@synthesize originY;
@synthesize oneLineHeight;
@synthesize width;
@synthesize gap;
@synthesize kfGreen0;
@synthesize kfGreen1;
@synthesize kfGreen2;
@synthesize kfGray;

- (id)init
{
    self = [super init];
    if (self) {
        self.sortSelection = [NSMutableArray arrayWithCapacity:0];
        [self.sortSelection addObject:[NSNumber numberWithInteger:KFSortFreshnessD]];
        [self.sortSelection addObject:[NSNumber numberWithInteger:KFSortDaysLeftA]];
//        [self.sortSelection addObject:[NSNumber numberWithInteger:KFSortCellTextAlphabetA]];
        self.warningText = [[NSMutableString alloc] init];
        self.originX = 15.0f;
        self.originY = 15.0f;
        self.gap = 10.0f;
        self.oneLineHeight = 40.0f;
        self.fontSizeL = 16.0f;
        self.fontSizeM = 14.0f;
        self.kfGreen0 = [UIColor colorWithRed:157.0f/255.0f green:225.0f/255.0f blue:63.0f/255.0f alpha:1.0f];
        self.kfGreen1 = [UIColor colorWithRed:150.0f/255.0f green:206.0f/255.0f blue:107.0f/255.0f alpha:1.0f];
        self.kfGreen2 = [UIColor colorWithRed:152.0f/255.0f green:189.0f/255.0f blue:93.0f/255.0f alpha:1.0f];
        self.kfGray = [UIColor colorWithRed:130.0f/255.0f green:131.0f/255.0f blue:126.0f/255.0f alpha:1.0f];
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
    [self refreshDb];
}

- (void)refreshDb
{
    for (KFItem *i in self.fResultsCtl.fetchedObjects) {
        [self resetDaysLeft:i];
        [self resetFreshness:i];
    }
    if (![self saveToDb]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"generalError" object:self];
    }
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
        case KFSortDaysLeftA:
            return [[NSSortDescriptor alloc] initWithKey:@"daysLeft" ascending:YES];
        case KFSortDaysLeftD:
            return [[NSSortDescriptor alloc] initWithKey:@"daysLeft" ascending:NO];
        case KFSortTimeCreatedA:
            return [[NSSortDescriptor alloc] initWithKey:@"timeAdded" ascending:YES];
        case KFSortTimeCreatedD:
            return [[NSSortDescriptor alloc] initWithKey:@"timeAdded" ascending:NO];
        case KFSortFreshnessA:
            return [[NSSortDescriptor alloc] initWithKey:@"freshness" ascending:YES];
        case KFSortFreshnessD:
            return [[NSSortDescriptor alloc] initWithKey:@"freshness" ascending:NO];
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
