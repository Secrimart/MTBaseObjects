//
//  MTBaseTableViewController.h
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/12.
//

#import <UIKit/UIKit.h>

#import "MTBaseVCProtocol.h"

@import MTFramework;
@import Masonry;
@import BackButtonHandler;

@interface MTBaseTableViewController : UITableViewController<MTBaseVCProtocol,UIGestureRecognizerDelegate>

@end
