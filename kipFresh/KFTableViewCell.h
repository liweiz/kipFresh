//
//  KFTableViewCell.h
//  kipFresh
//
//  Created by Liwei Zhang on 2014-09-25.
//  Copyright (c) 2014 Liwei Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KFTableViewCell : UITableViewCell

@property (assign, nonatomic) BOOL isForCardView;
@property (assign, nonatomic) CGRect appRect;
@property (assign, nonatomic) UIColor *textBackGroundColor;
@property (assign, nonatomic) CGFloat textBackGroundAlpha;

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


@end
