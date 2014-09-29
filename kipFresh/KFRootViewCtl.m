//
//  KFRootViewCtl.m
//  kipFresh
//
//  Created by Liwei Zhang on 2014-09-25.
//  Copyright (c) 2014 Liwei Zhang. All rights reserved.
//

#import "KFRootViewCtl.h"
#import "KFItem.h"

@interface KFRootViewCtl ()

@end

@implementation KFRootViewCtl

@synthesize appRect;
@synthesize box;
@synthesize interfaceBase;
@synthesize inputView;
@synthesize bestBefore;
@synthesize addBtn;
@synthesize addTap;
@synthesize notes;
@synthesize camView;
@synthesize listViewCtl;
@synthesize cardViewCtl;
@synthesize menuView;
@synthesize itemViewCtl;
@synthesize warning;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.box = [[KFBox alloc] init];
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:self.appRect];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.box.appRect = self.appRect;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interfaceBase = [[UIScrollView alloc] initWithFrame:self.box.appRect];
    // Four views, from left to right: 1. cam 2. input 3. list 4. menu/card
    CGSize theContentSize = CGSizeMake(self.box.appRect.size.width * 4, self.box.appRect.size.height);
    self.interfaceBase.contentSize = theContentSize;
    self.interfaceBase.contentOffset = CGPointMake(self.appRect.size.width * 2, 0.0f);
    self.interfaceBase.bounces = NO;
    self.interfaceBase.showsVerticalScrollIndicator = NO;
    self.interfaceBase.showsHorizontalScrollIndicator = NO;
    self.interfaceBase.pagingEnabled = YES;
    self.interfaceBase.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.interfaceBase];
    
//    self.camView = [[UIView alloc] initWithFrame:self.appRect];
//    self.camView.backgroundColor = [UIColor redColor];
//    [self.interfaceBase addSubview:self.camView];
    
    // InputView
    self.inputView = [[KFView alloc] initWithFrame:CGRectMake(self.appRect.size.width, 0.0f, self.appRect.size.width, self.appRect.size.height)];
    self.inputView.touchToDismissKeyboardIsOn = YES;
    self.inputView.backgroundColor = [UIColor blueColor];
    [self.interfaceBase addSubview:self.inputView];
    self.bestBefore = [[UITextField alloc] initWithFrame:CGRectMake(5.0f, 5.0f, self.box.appRect.size.width - 10.0f, 44.0f)];
    self.bestBefore.backgroundColor = [UIColor whiteColor];
    self.bestBefore.placeholder = @"Best before: YYYY/MM/DD";
    [self refreshInputView];
    [self.inputView addSubview:self.bestBefore];
    self.notes = [[UITextView alloc] initWithFrame:CGRectMake(self.bestBefore.frame.origin.x, self.bestBefore.frame.origin.y * 2 + self.bestBefore.frame.size.height, self.box.appRect.size.width - 10.0f, 120.0f)];
    self.notes.backgroundColor = [UIColor whiteColor];
    self.addBtn = [[UIView alloc] initWithFrame:CGRectMake(self.bestBefore.frame.origin.x, 470.0f, self.bestBefore.frame.size.width, 44.0f)];
    self.addBtn.backgroundColor = [UIColor greenColor];
    self.addTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saveItem)];
    [self.addBtn addGestureRecognizer:self.addTap];
    [self.inputView addSubview:self.addBtn];
    [self.inputView addSubview:self.notes];
    self.notes.text = @"Take some notes here.";
    
    [self.box prepareDataSource];
    
    // ListViewCtl
    self.listViewCtl = [[KFTableViewController alloc] init];
    self.listViewCtl.box = self.box;
    self.listViewCtl.isForCard = NO;
    [self addChildViewController:self.listViewCtl];
    [self.interfaceBase addSubview:self.listViewCtl.tableView];
    [self.listViewCtl didMoveToParentViewController:self];
    [self.listViewCtl.tableView reloadData];
    
    // CardViewCtl
    self.cardViewCtl = [[KFTableViewController alloc] init];
    self.cardViewCtl.box = self.box;
    self.cardViewCtl.isForCard = YES;
    [self addChildViewController:self.cardViewCtl];
    [self.interfaceBase addSubview:self.cardViewCtl.tableView];
    [self.cardViewCtl didMoveToParentViewController:self];
    [self.cardViewCtl.tableView reloadData];
//    self.cardViewCtl.tableView.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showCard) name:@"rowSelected" object:nil];
    
}

- (void)saveItem
{
    [self addItem];
    [self.box saveToDb];
    [self.listViewCtl.tableView reloadData];
}

- (void)addItem
{
    KFItem *i = [NSEntityDescription insertNewObjectForEntityForName:@"KFItem" inManagedObjectContext:self.box.ctx];
    [i setValue:self.notes.text forKey:@"notes"];
    [i setValue:[self stringToDate:self.bestBefore.text] forKey:@"bestBefore"];
    [i setValue:[NSDate date] forKey:@"timeAdded"];
}

- (void)showCard
{
    [self.box prepareDataSource];
    [self.cardViewCtl.tableView reloadData];
    [self.cardViewCtl.tableView scrollToRowAtIndexPath:self.listViewCtl.tableView.indexPathForSelectedRow atScrollPosition:UITableViewScrollPositionTop animated:NO];
    self.cardViewCtl.tableView.hidden = NO;
    [self.cardViewCtl.tableView.superview bringSubviewToFront:self.cardViewCtl.tableView];
    [self.interfaceBase setContentOffset:CGPointMake(self.interfaceBase.contentSize.width * 3 / 4, 0.0f) animated:YES];
}

- (void)refreshInputView
{
    [self prepareForInput];
}

- (void)prepareForInput
{
    NSDateComponents *c = [[NSCalendar currentCalendar]
                                    components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                                    fromDate:[NSDate date]];
    self.bestBefore.text = [self combineToGetStringDate:c];
}



#pragma mark - validate input
- (BOOL)validateDateInput:(NSString *)input
{
    NSSet *n = [NSSet setWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", nil];
    if (input.length == 8) {
        for (NSUInteger i = 0; i < 8; i++) {
            NSString *x = [input substringWithRange:NSMakeRange(i, 1)];
            BOOL isNumber = NO;
            for (NSString *s in n) {
                if ([x isEqualToString:s]) {
                    isNumber = YES;
                    break;
                }
            }
            if (!isNumber) {
                break;
            }
            if (isNumber && i == 7) {
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)validateNotesInput:(NSString *)input
{
    if (input.length > 0 && input.length <= 144) {
        return YES;
    }
    return NO;
}

#pragma mark - warning display

- (void)showWarningWithText:(NSNotification *)note
{
    if (!self.warning) {
        self.warning = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 220.0f) * 0.5f, (self.view.frame.size.height - 90.0f) * 0.5f, 220.0f, 90.0f)];
        [self.view addSubview:self.warning];
        self.warning.textAlignment = NSTextAlignmentLeft;
    }
//    if ([note.name isEqualToString:tvFetchOrSaveErr]) {
//        self.warning.text = @"Something went wrong, please try later.";
//    } else {
//        self.warning.text = self.box.warning;
//    }
    
    if (self.warning.alpha == 0.0f) {
        self.warning.alpha = 1.0f;
        [self.view bringSubviewToFront:self.warning];
    }
    [UIView animateWithDuration:4 animations:^{
        self.warning.alpha = 0.0f;
    } completion:^(BOOL finished){
        self.warning.text = nil;
    }];
}

- (void)hideWarning
{
    self.warning.text = nil;
    if (self.warning.alpha == 1.0f) {
        self.warning.alpha = 0.0f;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end