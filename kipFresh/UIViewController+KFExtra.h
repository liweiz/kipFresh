//
//  UIViewController+KFExtra.h
//  kipFresh
//
//  Created by Liwei Zhang on 2014-09-28.
//  Copyright (c) 2014 Liwei Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KFBox.h"

@interface UIViewController (KFExtra)

- (NSDate *)stringToDate:(NSString *)string;
- (NSArray *)getDateFromString:(NSString *)string;
- (NSString *)combineToGetStringDate:(NSDateComponents *)c;
- (NSString *)dateToString:(NSDate *)date;
- (NSInteger)getDaysLeftFrom:(NSDate *)start to:(NSDate *)end;
- (BOOL)validateDateInput:(NSString *)input;
- (BOOL)validateNotesInput:(NSString *)input;
- (void)configLayer:(CALayer *)layer box:(KFBox *)b isClear:(BOOL)isClear;

@end
