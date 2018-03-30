//
//  MTPupaTableViewController.m
//  MTBaseObjects_Example
//
//  Created by Jason Li on 2018/3/29.
//  Copyright © 2018年 rstx_reg@aliyun.com. All rights reserved.
//

#import "MTPupaTableViewController.h"
#import "MTPupaViewModel.h"

@interface MTPupaTableViewController ()

@end

@implementation MTPupaTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.viewModel = [[MTPupaViewModel alloc] init];
    
    [self.viewModel toReloadDataSourceBeforeRequest:nil onFinished:nil onFailed:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: Table View Config Cell
- (UITableViewCell *)configNomarlCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath rowType:(NSUInteger)rowType {
    MTPupaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MTPupaRowTypeNomarl"];
    if (!cell) {
        cell = [[MTPupaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MTPupaRowTypeNomarl"];
    }
    
    cell.labelHead.text = @"HeadHeadHeadHeadHeadHeadHead";
    cell.labelBody.text = @"BodyBodyBodyBodyBodyBodyBody";
    cell.labelTail.text = @"TailTailTailTailTailTailTail";
    
    return cell;
}


- (UITableViewCell *)configVerticalCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath rowType:(NSUInteger)rowType {
    MTPupaVerticalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MTPupaVerticalCell"];
    if (!cell) {
        cell = [[MTPupaVerticalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"vMTPupaVerticalCell"];
    }
    
    cell.labelHead.text = @"HeadHeadHeadHeadHeadHeadHeadHeadHeadHeadHeadHeadHeadHeadHead";
    cell.labelBody.text = @"BodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBody";
    cell.labelTail.text = @"TailTailTailTailTailTailTailTailTailTailTailTailTailTailTailTailTailTail";
    
    return cell;
}

- (UITableViewCell *)configFixedHeadAndTailCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath rowType:(NSUInteger)rowType {
    MTPupaFixedHeadAndTailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MTPupaFixedHeadAndTailCell"];
    if (!cell) {
        cell = [[MTPupaFixedHeadAndTailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MTPupaFixedHeadAndTailCell"];
    }
    cell.labelHead.text = @"Head";
    cell.labelBody.text = @"BodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBody";
    cell.labelTail.text = @"TailTail";
    
    return cell;
}

- (UITableViewCell *)configVerticalFixedHeadAndTailCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath rowType:(NSUInteger)rowType {
    MTPupaVerticalFixedHeadAndTailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MTPupaVerticalFixedHeadAndTailCell"];
    if (!cell) {
        cell = [[MTPupaVerticalFixedHeadAndTailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MTPupaVerticalFixedHeadAndTailCell"];
    }
    cell.labelHead.text = @"Head";
    cell.labelBody.text = @"BodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBody";
    cell.labelTail.text = @"Tail\nTail";
    
    return cell;
}

- (UITableViewCell *)configFixedTailHeadAndBodyHalfOfRemainCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath rowType:(NSUInteger)rowType {
    MTPupaFixedTailHeadAndBodyHalfOfRemainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MTPupaFixedTailHeadAndBodyHalfOfRemainCell"];
    if (!cell) {
        cell = [[MTPupaFixedTailHeadAndBodyHalfOfRemainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MTPupaFixedTailHeadAndBodyHalfOfRemainCell"];
    }
    cell.labelHead.text = @"HeadHeadHeadHead";
    cell.labelHead.numberOfLines = 0;
    cell.labelBody.text = @"BodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBody";
    cell.labelTail.text = @"Tail";
    
    return cell;
}

- (UITableViewCell *)configVerticalFixedTailHeadAndBodyHalfOfRemainCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath rowType:(NSUInteger)rowType {
    MTPupaVerticalFixedTailHeadAndBodyHalfOfRemainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MTPupaVerticalFixedTailHeadAndBodyHalfOfRemainCell"];
    if (!cell) {
        cell = [[MTPupaVerticalFixedTailHeadAndBodyHalfOfRemainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MTPupaVerticalFixedTailHeadAndBodyHalfOfRemainCell"];
    }
    cell.labelHead.text = @"HeadHeadHeadHeadHeadHeadHeadHeadHeadHeadHeadHeadHeadHeadHeadHeadHeadHeadHeadHeadHeadHeadHeadHeadHeadHeadHeadHead";
    cell.labelHead.numberOfLines = 0;
    cell.labelBody.text = @"BodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBody";
    cell.labelTail.text = @"Tail";
    cell.labelTail.numberOfLines = 0;
    
    return cell;
}

//MARK: Table View DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)self.viewModel.dataSource[section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MTPupaRowType rowType = [tableView rowTypeFromArray:self.viewModel.dataSource indexPath:indexPath];
    UITableViewCell *cell = nil;
    if (rowType == MTPupaRowTypeNomarl) {
        cell = [self configNomarlCell:tableView indexPath:indexPath rowType:rowType];
    } else if (rowType == MTPupaRowTypeVertical) {
        cell = [self configVerticalCell:tableView indexPath:indexPath rowType:rowType];
    } else if (rowType == MTPupaRowTypeFixedHeadAndTail) {
        cell = [self configFixedHeadAndTailCell:tableView indexPath:indexPath rowType:rowType];
    } else if (rowType == MTPupaRowTypeVerticalFixedHeadAndTail) {
        cell = [self configVerticalFixedHeadAndTailCell:tableView indexPath:indexPath rowType:rowType];
    } else if (rowType == MTPupaRowTypeFixedTailHeadAndBodyHalfOfRemain) {
        cell = [self configFixedTailHeadAndBodyHalfOfRemainCell:tableView indexPath:indexPath rowType:rowType];
    } else if (rowType == MTPupaRowTypeVerticalFixedTailHeadAndBodyHalfOfRemain) {
        cell = [self configVerticalFixedTailHeadAndBodyHalfOfRemainCell:tableView indexPath:indexPath rowType:rowType];
    }
    
    MTPupaCell *pCell = (MTPupaCell *)cell;
    pCell.contentInsets = self.edgeInsets;
    
    pCell.labelHead.backgroundColor = [UIColor redColor];
    pCell.labelBody.backgroundColor = [UIColor blueColor];
    pCell.labelBody.numberOfLines = 0;
    pCell.labelTail.backgroundColor = [UIColor yellowColor];
    
    return cell;
}

//MARK: table view Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MTPupaRowType rowType = [tableView rowTypeFromArray:self.viewModel.dataSource indexPath:indexPath];
    if (rowType == MTPupaRowTypeVertical) {
        return self.rowHeight * 3;
    } else if (rowType == MTPupaRowTypeFixedHeadAndTail) {
        return self.rowHeight * 1.5;
    } else if (rowType == MTPupaRowTypeVerticalFixedHeadAndTail) {
        return self.rowHeight * 3;
    } else if (rowType == MTPupaRowTypeFixedTailHeadAndBodyHalfOfRemain) {
        return self.rowHeight * 1.5;
    } else if (rowType == MTPupaRowTypeVerticalFixedTailHeadAndBodyHalfOfRemain) {
        return self.rowHeight * 3;
    }
    return self.rowHeight;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsMake(0, CGRectGetWidth(self.view.bounds), 0, 0)];
//    }
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsMake(0, CGRectGetWidth(self.view.bounds), 0, 0)];
//    }
//}



@end
