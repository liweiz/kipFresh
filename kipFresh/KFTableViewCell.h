//
//  KFTableViewCell.h
//  kipFresh
//
//  Created by Liwei Zhang on 2014-09-25.
//  Copyright (c) 2014 Liwei Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "KFBox.h"

@interface KFTableViewCell : UITableViewCell

@property (assign, nonatomic) BOOL isForCardView;
@property (assign, nonatomic) CGRect appRect;
@property (assign, nonatomic) UIColor *textBackGroundColor;
@property (assign, nonatomic) CGFloat textBackGroundAlpha;
@property (strong, nonatomic) KFBox *box;

// Shared view
@property (strong, nonatomic) UIImageView *pic;

// For list
@property (strong, nonatomic) UIView *darkBar;
@property (assign, nonatomic) CGFloat *darkBarRatio;

// For item detail
@property (strong, nonatomic) UITextView *notes;
@property (strong, nonatomic) UITextField *bestBefore;
@property (strong, nonatomic) UITextField *daysLeft;
@property (strong, nonatomic) UITextField *dateAdded;
@property (strong, nonatomic) UIView *deleteBtn;
@property (strong, nonatomic) UITapGestureRecognizer *deleteTap;
@property (strong, nonatomic) NSManagedObjectID *objId;

@end
