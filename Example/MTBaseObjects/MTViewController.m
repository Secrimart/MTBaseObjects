//
//  MTViewController.m
//  MTBaseObjects
//
//  Created by rstx_reg@aliyun.com on 03/12/2018.
//  Copyright (c) 2018 rstx_reg@aliyun.com. All rights reserved.
//

#import "MTViewController.h"

@interface MTViewController ()

@property (nonatomic, strong) MTFinderViewController *finderVC; // 搜索历史

@end

@implementation MTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor redColor];
    self.webView.backgroundColor = [UIColor blueColor];
    
    UIBarButtonItem *findItem = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStyleDone target:self action:@selector(toShowFinderViewController)];
    [self.navigationItem setRightBarButtonItem:findItem];
    [[MTBlankView sharedManager] setImageBlank:[UIImage imageNamed:@"blankView"]];
    
    [MTBlankView blankViewAddTo:self.view message:@"暂时没有内容"];
    
}

- (void)toShowFinderViewController {
//    [self.finderVC toShowFinderOnViewController:self];
    MTWebViewController *web = [[MTWebViewController alloc] init];
    [web toLoadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://blog.csdn.net/MyKingSaber/article/details/54021433"]]];
    [self.navigationController pushViewController:web animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self toLoadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.apple.com"]]];
    
}

//MARK: - Getter And Setter
- (MTFinderViewController *)finderVC {
    if (_finderVC) return _finderVC;
    _finderVC = [[MTFinderViewController alloc] initWithStyle:UITableViewStylePlain];
    
    return _finderVC;
}

@end
