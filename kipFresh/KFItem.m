//
//  KFItem.m
//  kipFresh
//
//  Created by Liwei Zhang on 2014-10-02.
//  Copyright (c) 2014 Liwei Zhang. All rights reserved.
//

#import "KFItem.h"
#import "NSObject+KFExtra.h"

@implementation KFItem

@dynamic bestBefore;
@dynamic notes;
@dynamic pic;
@dynamic timeAdded;
@dynamic daysLeft;
@dynamic freshness;

//- (NSNumber *)daysLeft
//{
//    NSInteger d = [self getDaysLeftFrom:[NSDate date] to:[self valueForKey:@"bestBefore"]];
//    return [NSNumber numberWithInteger:d];
//}
//
//// Four scales correspond to four colors: 0: green0, 1: green1, 2: green2, 3: gray.
//- (NSNumber *)freshness
//{
//    NSInteger f = [(NSNumber *)[self valueForKey:@"daysLeft"] integerValue];
//    NSInteger d = [self getDaysLeftFrom:[self valueForKey:@"timeAdded"] to:[self valueForKey:@"bestBefore"]];
//    CGFloat r1 = d / 3.0f;
//    CGFloat r2 = d * 2.0f / 3.0f;
//    if (f <= 0) {
//        return [NSNumber numberWithInteger:3];
//    } else if (f <= floorf(r1)) {
//        return [NSNumber numberWithInteger:2];
//    } else if (f <= floorf(r2)) {
//        return [NSNumber numberWithInteger:1];
//    } else {
//        return [NSNumber numberWithInteger:0];
//    }
//}

@end
