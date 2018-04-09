//
//  MTFinderViewController.m
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/12.
//

#import "MTFinderViewController.h"

#import "MTLocalRecordVM.h"
#import "UIColor+mtBase.h"
#import "UIFont+mtBase.h"
#import "UITextField+mtBase.h"
#import "MTButtonsView.h"

@interface MTFinderViewController ()<UITextFieldDelegate>
@property (nonatomic, copy) ToSearchingBlock blockSearch;

@property (nonatomic, strong) MTButtonsView *viewFooter; // 清空历史

@property (nonatomic, strong) MTLocalRecordVM *viewModel; // 视图模型 处理数据

@end

@implementation MTFinderViewController
- (void)toShowFinderOnViewController:(UIViewController *)viewController {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    [nav.navigationBar setShadowImage:[UIImage new]];
    nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [viewController presentViewController:nav animated:YES completion:nil];
}

- (void)toStartSearchingOnBlock:(ToSearchingBlock)search {
    self.blockSearch = search;
}

- (void)toDealSearchString:(NSString *)string {
    if (string.length > 0) {
        [self.viewModel toAddRecord:string];
        [self.fieldSearch endEditing:YES];
        
        [self dismissViewControllerAnimated:NO completion:nil];
        if (self.blockSearch) self.blockSearch(string);
    }
}

- (void)toReloadData {
    __weak typeof(self) weakSelf = self;
    [self.viewModel toReloadDataSourceBeforeRequest:nil onFinished:^(DataSourceStatus status) {
        if (((NSArray *)weakSelf.viewModel.dataSource.firstObject).count > 0) {
            [weakSelf.tableView setTableFooterView:self.viewFooter];
        } else {
            [weakSelf.tableView setTableFooterView:nil];
        }
        [weakSelf.tableView reloadData];
    } onFailed:nil];
}

- (void)toClearAllRecord {
    [self.viewModel toClearAllRecord];
    [self toReloadData];
}

//MARK: - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.contentInsets = self.edgeInsets;
    
    [self.navigationItem setTitleView:self.fieldSearch];
    [self toSetupNavgationItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.fieldSearch.text = self.searchString;
    [self.fieldSearch becomeFirstResponder];
    
    [self toReloadData];
}

- (CGRect)rectFooterView {
    CGRect rect = self.view.bounds;
    rect.size.height = self.rowHeight*2.1f;
    return rect;
}

- (CGRect)rectFieldSearch {
    CGRect rect = self.view.bounds;
    rect.size.height = self.rowHeight*0.7f;
    return rect;
}

- (MTButtonsView *)viewFooter {
    if (_viewFooter) return _viewFooter;
    _viewFooter = [[MTButtonsView alloc] initWithFrame:[self rectFooterView]];
    _viewFooter.contentInsets = UIEdgeInsetsMake(self.rowHeight*.5f, self.edgeInsets.left*3.f, self.rowHeight*.7f, self.edgeInsets.right*3.f);
    
    [_viewFooter toAddButtonWithTitle:@"清空历史" withTag:0 withStyle:ButtonStyleCustom target:self action:@selector(toClearAllRecord)];
    
    UIButton *button = [_viewFooter buttonWithTag:0];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTintColor:[UIColor grayDataColor]];
    [button.titleLabel setFont:[UIFont contentFont]];
    
    button.layer.cornerRadius = self.cornerRadius;
    button.layer.borderColor = [UIColor grayDataColor].CGColor;
    button.layer.borderWidth = .5f;
    
    return _viewFooter;
}

//MARK: - Getter And Setter
- (MTLocalRecordVM *)viewModel {
    if (_viewModel) return _viewModel;
    _viewModel = [[MTLocalRecordVM alloc] init];
    _viewModel.maxRecord = 20;
    _viewModel.recordKey = @"Finder";
    
    return _viewModel;
}

- (MTTextField *)fieldSearch {
    if (_fieldSearch) return _fieldSearch;
    _fieldSearch = [[MTTextField alloc] initWithFrame:[self rectFieldSearch]];
    _fieldSearch.font = [UIFont descFont];
    _fieldSearch.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.05f];
    _fieldSearch.placeholder = self.placeholder;
    
    _fieldSearch.layer.cornerRadius = self.cornerRadius;
    _fieldSearch.textColor = [UIColor dataColor];
    _fieldSearch.tintColor = [UIColor grayDataColor];
    [_fieldSearch setLeftImage:self.fieldSearchIcon];
    
    _fieldSearch.returnKeyType = UIReturnKeySearch;
    _fieldSearch.delegate = self;
    
    return _fieldSearch;
}

- (void)setFinderKey:(NSString *)finderKey {
    _finderKey = finderKey;
    self.viewModel.recordKey = finderKey;
}

//MARK: - Action
- (void)toSetupNavgationItem {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(toDealCancelBatItem)];
    
    [rightItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont descFont],NSFontAttributeName,[UIColor grayDataColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    [rightItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont descFont],NSFontAttributeName,[UIColor grayDataColor],NSForegroundColorAttributeName, nil] forState:UIControlStateHighlighted];
    
    [self.navigationItem setRightBarButtonItem:rightItem];
}

- (void)toDealCancelBatItem {
    [self.fieldSearch endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//MARK: -  Table View
//MARK: Table View DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)self.viewModel.dataSource[section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *FinderViewControllerCellIdentifier = @"FinderViewControllerCellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:FinderViewControllerCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FinderViewControllerCellIdentifier];
        cell.textLabel.textColor = [UIColor grayDataColor];
        cell.textLabel.font = [UIFont descFont];
    }
    
    cell.textLabel.text = [self.viewModel recordAtIndexPath:indexPath];
    
    return cell;
}
//MARK: table view Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *hisCell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [self toDealSearchString:hisCell.textLabel.text];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

//MARK: - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *searchString = [[textField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [self toDealSearchString:searchString];
    return YES;
}
@end
