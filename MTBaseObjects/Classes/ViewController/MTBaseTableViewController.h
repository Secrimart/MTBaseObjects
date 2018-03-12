//
//  MTBaseTableViewController.h
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/12.
//

#import <UIKit/UIKit.h>

#import "MTBaseViewModel.h"
#import "MTBaseVCProtocol.h"

@import JLFramework;
@import Masonry;
@import BackButtonHandler;

@interface MTBaseTableViewController : UITableViewController<MTBaseVCProtocol,UIGestureRecognizerDelegate>
@property (nonatomic, strong) MTBaseViewModel *viewModel; // 使用视图模型存储数据

@end
