//
//  MTViewController.m
//  MTBaseObjects
//
//  Created by rstx_reg@aliyun.com on 03/12/2018.
//  Copyright (c) 2018 rstx_reg@aliyun.com. All rights reserved.
//

#import "MTViewController.h"
#import "MTPupaTableViewController.h"

@import Masonry;
@import JLFramework;

@interface MTViewController ()
@property (nonatomic, strong) MTPupaTableViewController *tableVC;

@end

@implementation MTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self addChildController:self.tableVC];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupLayoutConstraint {
    __weak typeof(self) weakSelf = self;
    [self.tableVC.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
}

//MARK: - Getter And Setter
- (MTPupaTableViewController *)tableVC {
    if (_tableVC) return _tableVC;
    _tableVC = [[MTPupaTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    return _tableVC;
}


@end
