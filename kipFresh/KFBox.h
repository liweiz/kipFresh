//
//  KFBox.h
//  kipFresh
//
//  Created by Liwei Zhang on 2014-09-25.
//  Copyright (c) 2014 Liwei Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

typedef NS_ENUM(NSInteger, KFSort) {
    KFSortCellTextAlphabetA,
    KFSortCellTextAlphabetD,
    KFSortTimeLeftA,
    KFSortTimeLeftD,
    KFSortTimeCreatedA,
    KFSortTimeCreatedD
};

@interface KFBox : NSObject <NSFetchedResultsControllerDelegate>

@property (assign, nonatomic) CGRect appRect;
@property (assign, nonatomic) CGFloat originX;
@property (assign, nonatomic) CGFloat originY;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat oneLineHeight;
@property (assign, nonatomic) CGFloat gap;
@property (assign, nonatomic) CGFloat fontSizeL;
@property (assign, nonatomic) CGFloat fontSizeM;
@property (strong, nonatomic) UIColor *kfGreen;
@property (strong, nonatomic) UIColor *kfGrey;
@property (strong, nonatomic) NSManagedObjectContext *ctx;
@property (strong, nonatomic) NSFetchRequest *fReq;
@property (strong, nonatomic) NSFetchedResultsController *fResultsCtl;
@property (strong, nonatomic) NSMutableArray *sortSelection;
@property (strong, nonatomic) NSMutableString *warningText;

- (void)prepareDataSource;
- (BOOL)saveToDb;

@end
