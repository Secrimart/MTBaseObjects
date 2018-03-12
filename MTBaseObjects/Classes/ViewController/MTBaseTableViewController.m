//
//  MTBaseTableViewController.m
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/12.
//

#import "MTBaseTableViewController.h"

@interface MTBaseTableViewController ()

@end

@implementation MTBaseTableViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initController];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initController];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initController];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        [self initController];
    }
    return self;
}

- (void)initController {
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

- (BOOL)navigationShouldPopOnBackButton {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.rowHeight;
}

//MARK: Section Header Footer Height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView.style == UITableViewStylePlain) return 0;
    if (section == 0) {
        return self.controlInterval;
    }
    return self.controlHalfInterval;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (![tableView.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) return 0;
    if (tableView.style == UITableViewStylePlain) return 0;
    if (section == ([tableView.dataSource numberOfSectionsInTableView:tableView] - 1)) {
        return self.controlInterval;
    }
    return self.controlHalfInterval;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGRect frame = CGRectZero;
    frame.size.width = CGRectGetWidth([UIScreen mainScreen].bounds);
    frame.size.height = [self tableView:tableView heightForHeaderInSection:section];
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CGRect frame = CGRectZero;
    frame.size.width = CGRectGetWidth([UIScreen mainScreen].bounds);
    frame.size.height = [self tableView:tableView heightForFooterInSection:section];
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}


//MARK: - UIGestureRecognizerDelegate
//WorkAround UIViewController+BackButtonHandler for NavigationController.interactivePopGestureRecognizer
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)] &&gestureRecognizer == self.navigationController.interactivePopGestureRecognizer) {
        BOOL shouldPop = YES;
        if([self respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
            shouldPop = [self navigationShouldPopOnBackButton];
        }
        return shouldPop;
    }
    
    return YES;
}

@end
