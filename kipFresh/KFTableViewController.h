//
//  KFTableViewController.h
//  kipFresh
//
//  Created by Liwei Zhang on 2014-09-25.
//  Copyright (c) 2014 Liwei Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "KFBox.h"



@interface KFTableViewController : UITableViewController

@property (strong, nonatomic) KFBox *box;

@property (assign, nonatomic) BOOL isForCard;

@end
