//
//  UIViewController+KFExtra.h
//  kipFresh
//
//  Created by Liwei Zhang on 2014-09-28.
//  Copyright (c) 2014 Liwei Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (KFExtra)

- (NSDate *)stringToDate:(NSString *)string;
- (NSArray *)getDateFromString:(NSString *)string;
- (NSString *)combineToGetStringDate:(NSDateComponents *)c;
- (NSString *)dateToString:(NSDate *)date;

@end
