//
//  MTBaseViewController.m
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/12.
//

#import "MTBaseViewController.h"

@interface MTBaseViewController ()

@end

@implementation MTBaseViewController

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

- (void)initController {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
