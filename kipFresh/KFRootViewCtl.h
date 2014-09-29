//
//  KFRootViewCtl.h
//  kipFresh
//
//  Created by Liwei Zhang on 2014-09-25.
//  Copyright (c) 2014 Liwei Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KFBox.h"
#import "KFTableViewController.h"
#import "KFView.h"

@interface KFRootViewCtl : UIViewController

@property (assign, nonatomic) CGRect appRect;
@property (strong, nonatomic) KFBox *box;
@property (strong, nonatomic) UIScrollView *interfaceBase;

@property (strong, nonatomic) UIView *camView;

@property (strong, nonatomic) KFView *inputView;
@property (strong, nonatomic) UITextField *bestBefore;
@property (strong, nonatomic) UITextView *notes;
@property (strong, nonatomic) UIView *addBtn;
@property (strong, nonatomic) UITapGestureRecognizer *addTap;

@property (strong, nonatomic) KFTableViewController *listViewCtl;
@property (strong, nonatomic) KFTableViewController *cardViewCtl;

@property (strong, nonatomic) UIView *menuView;

@property (strong, nonatomic) UICollectionViewController *itemViewCtl;

@property (strong, nonatomic) UILabel *warning;

@end
