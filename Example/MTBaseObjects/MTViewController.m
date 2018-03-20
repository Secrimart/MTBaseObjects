//
//  MTViewController.m
//  MTBaseObjects
//
//  Created by rstx_reg@aliyun.com on 03/12/2018.
//  Copyright (c) 2018 rstx_reg@aliyun.com. All rights reserved.
//

#import "MTViewController.h"

@interface MTViewController ()

@end

@implementation MTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    self.webView.backgroundColor = [UIColor blueColor];
//    [self.navigationController setNavigationBarHidden:YES];
//    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self toLoadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.apple.com"]]];
}

@end
