//
//  KFTableViewCell.m
//  kipFresh
//
//  Created by Liwei Zhang on 2014-09-25.
//  Copyright (c) 2014 Liwei Zhang. All rights reserved.
//

#import "KFTableViewCell.h"
#import "KFRootViewCtl.h"


@implementation KFTableViewCell

@synthesize pic;
@synthesize darkBar;
@synthesize darkBarRatio;
@synthesize isForCardView;
@synthesize appRect;
@synthesize textBackGroundColor;
@synthesize textBackGroundAlpha;
@synthesize notes;
@synthesize bestBefore;
@synthesize daysLeft;
@synthesize dateAdded;
@synthesize deleteBtn;
@synthesize deleteTap;
@synthesize objId;
@synthesize box;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        if ([reuseIdentifier isEqualToString:@"cell"]) {
            self.isForCardView = NO;
        } else {
            self.isForCardView = YES;
        }
        self.appRect = [(KFRootViewCtl *)[UIApplication sharedApplication].keyWindow.rootViewController appRect];
        self.textBackGroundColor = [UIColor lightGrayColor];
        self.textBackGroundAlpha = 0.7f;
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // In editing mode, contentView's x is 38.0, while in normal mode, it is 0.0. This can be calculated with NSLogging contentView and backgroundView. contentView's width changes to 282.0 as well, while backgroundView's width does not change.
    
    if (!self.backgroundView) {
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
    }
    if (!self.pic) {
        self.pic = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.backgroundView.frame.size.width, self.backgroundView.frame.size.height)];
    }
    if (self.pic.image) {
        [self.backgroundView addSubview:self.pic];
    } else {
        [self.pic removeFromSuperview];
    }
    if (!self.isForCardView) {
        if (!self.darkBar) {
            self.darkBar = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.backgroundView.frame.size.width, self.backgroundView.frame.size.height)];
        }
    } else {
        if (!self.notes) {
            self.notes = [[UITextView alloc] initWithFrame:CGRectMake(10.0f, 10.0f, self.appRect.size.width - 20.0f, 80.0f)];
            self.notes.backgroundColor = self.textBackGroundColor;
            self.notes.alpha = self.textBackGroundAlpha;
            self.notes.userInteractionEnabled = NO;
            [self.contentView addSubview:self.notes];
        }
        if (!self.dateAdded) {
            self.dateAdded = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 100.0f, self.appRect.size.width - 20.0f, 44.0f)];
            self.dateAdded.backgroundColor = self.textBackGroundColor;
            self.dateAdded.alpha = self.textBackGroundAlpha;
            self.dateAdded.userInteractionEnabled = NO;
            [self.contentView addSubview:self.dateAdded];
        }
        if (!self.bestBefore) {
            self.bestBefore = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, self.dateAdded.frame.origin.y + self.dateAdded.frame.size.height + 10.0f, self.appRect.size.width - 20.0f, 44.0f)];
            self.bestBefore.backgroundColor = self.textBackGroundColor;
            self.bestBefore.alpha = self.textBackGroundAlpha;
            self.bestBefore.userInteractionEnabled = NO;
            [self.contentView addSubview:self.bestBefore];
        }
        
        if (!self.deleteBtn) {
            self.deleteBtn = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - 44.0f) / 2, self.frame.size.height - 20.0f - 44.0f, 44.0f, 44.0f)];
            self.deleteBtn.backgroundColor = self.textBackGroundColor;
            self.deleteBtn.alpha = self.textBackGroundAlpha;
            [self.contentView addSubview:self.deleteBtn];
            self.deleteTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callForDeletion)];
            [self.deleteBtn addGestureRecognizer:self.deleteTap];
        }
        if (!self.daysLeft) {
            self.daysLeft = [[UITextField alloc] initWithFrame:CGRectMake((self.frame.size.width - 70.0f) / 2, self.frame.size.height / 2, 70.0f, self.frame.size.height / 2 - self.deleteBtn.frame.size.height - 20.0f * 2)];
            self.daysLeft.backgroundColor = self.textBackGroundColor;
            self.daysLeft.alpha = self.textBackGroundAlpha;
            self.daysLeft.userInteractionEnabled = NO;
            [self.contentView addSubview:self.daysLeft];
        }
    }
    
    if (self.pic.image) {
        [self.backgroundView addSubview:self.pic];
    } else {
        [self.pic removeFromSuperview];
    }
}

- (void)callForDeletion
{
    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithCapacity:0];
    [d setValue:objId forKey:@"objId"];
    NSNotification *n = [[NSNotification alloc] initWithName:@"deleteItem" object:self userInfo:d];
    [[NSNotificationCenter defaultCenter] postNotification:n];
}

@end
