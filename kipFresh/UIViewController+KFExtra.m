//
//  UIViewController+KFExtra.m
//  kipFresh
//
//  Created by Liwei Zhang on 2014-09-28.
//  Copyright (c) 2014 Liwei Zhang. All rights reserved.
//

#import "UIViewController+KFExtra.h"

@implementation UIViewController (KFExtra)

#pragma mark - string / date conversion

- (NSDate *)stringToDate:(NSString *)string
{
    NSArray *a = [self getDateFromString:string];
    if (a) {
        NSDateComponents *c = [[NSDateComponents alloc] init];
        [c setTimeZone:[NSTimeZone defaultTimeZone]];
        [c setCalendar:[NSCalendar currentCalendar]];
        NSString *year = a[0];
        NSString *month = a[1];
        NSString *day = a[2];
        [c setYear:year.integerValue];
        [c setMonth:month.integerValue];
        [c setDay:day.integerValue];
        return [[NSCalendar currentCalendar] dateFromComponents:c];
    }
    return nil;
}

- (NSArray *)getDateFromString:(NSString *)string
{
    NSString *year = [string substringWithRange:NSMakeRange(0, 4)];
    NSString *month = [string substringWithRange:NSMakeRange(4, 2)];
    if (month.integerValue < 1 || month.integerValue > 12) {
        // Incorrect data
        return nil;
    }
    NSString *day = [string substringWithRange:NSMakeRange(6, 2)];
    if (month.integerValue < 1 || month.integerValue > 31) {
        // Incorrect data
        return nil;
    }
    return [NSArray arrayWithObjects:year, month, day, nil];
}

- (NSString *)combineToGetStringDate:(NSDateComponents *)c
{
    NSString *year = [NSString stringWithFormat:@"%d", c.year];
    NSString *month = [NSString stringWithFormat:@"%d", c.month];
    NSString *day = [NSString stringWithFormat:@"%d", c.day];
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    [s appendString:year];
    if (c.month < 10) {
        [s appendString:@"0"];
    }
    [s appendString:month];
    if (c.day < 10) {
        [s appendString:@"0"];
    }
    [s appendString:day];
    return s;
}

- (NSString *)dateToString:(NSDate *)date
{
    NSDateComponents *c = [[NSCalendar currentCalendar]
                           components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                           fromDate:date];
    return [self combineToGetStringDate:c];
}

@end
