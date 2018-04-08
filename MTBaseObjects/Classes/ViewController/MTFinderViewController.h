//
//  MTFinderViewController.h
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/12.
//

#import "MTBaseTableViewController.h"
#import "MTTextField.h"

typedef void(^ToSearchingBlock) (NSString *searchContext);
@interface MTFinderViewController : MTBaseTableViewController

@property (nonatomic, strong) NSString *finderKey; // 查询组标识
@property (nonatomic, strong) NSString *placeholder; // 搜索框提示描述

@property (nonatomic, strong) MTTextField *fieldSearch; // 查询内容输入框
@property (nonatomic, strong) NSString *searchString; // 查询的内容
@property (nonatomic, strong) UIImage *fieldSearchIcon; // 输入文本框中的查询图标

/**
 查询控制器的使用者通过该方法接收需要查询的内容后，进行查询处理
 
 @param search 需要查询内容
 */
- (void)toStartSearchingOnBlock:(ToSearchingBlock)search;

/**
 模态方式显示查询控制器
 
 @param viewController 在这个控制器之上进行模态打开查询控制器
 */
- (void)toShowFinderOnViewController:(UIViewController *)viewController;

/**
 设置导航条右侧按钮，默认提供取消按钮，子类可以重写
 */
- (void)toSetupNavgationItem;

/**
 搜索框输入完毕出发搜索时，调用该方法对查询内容进行处理，例如：记录历史、触发查询等
 
 @param string 待处理的查询内容
 */
- (void)toDealSearchString:(NSString *)string;

@end
