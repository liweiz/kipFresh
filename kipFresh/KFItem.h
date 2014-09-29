//
//  KFItem.h
//  kipFresh
//
//  Created by Liwei Zhang on 2014-09-25.
//  Copyright (c) 2014 Liwei Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface KFItem : NSManagedObject

@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSData * pic;
@property (nonatomic, retain) NSDate * timeAdded;
@property (nonatomic, retain) NSDate * bestBefore;

@end
