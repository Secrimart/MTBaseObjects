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

@end

@implementation MTFinderViewController
- (void)toShowFinderOnViewController:(UIViewController *)viewController {
    [viewController presentViewController:self.navigationController animated:YES completion:nil];
}

- (void)toStartSearchingOnBlock:(ToSearchingBlock)search {
    self.blockSearch = search;
}

- (void)toDealSearchString:(NSString *)string {
    if (string.length > 0) {
        [self.recordVM toAddRecord:string];
        [self.fieldSearch endEditing:YES];
        
        [self dismissViewControllerAnimated:NO completion:nil];
        if (self.blockSearch) self.blockSearch(string);
    }
}

//MARK: - Life Cycle
- (void)initController {
    self.viewModel = [[MTLocalRecordVM alloc] init];
    self.recordVM.maxRecord = 20;
    self.recordVM.recordKey = @"Finder";
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    __weak typeof(self) weakSelf = self;
    [self.recordVM toReloadDataSourceBeforeRequest:nil onFinished:^(DataSourceStatus status) {
        if (weakSelf.recordVM.dataSource.count > 0) {
            [weakSelf.tableView setTableFooterView:self.viewFooter];
        } else {
            [weakSelf.tableView setTableFooterView:nil];
        }
    } onFailed:nil];
}

- (void)setupLayoutConstraint {
    __weak typeof(self) weakSelf = self;
    [self.fieldSearch mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.fieldSearch.superview);
    }];
}

- (CGRect)rectFooterView {
    CGRect rect = self.view.bounds;
    rect.size.height = self.rowHeight*2.1f;
    return rect;
}

- (MTButtonsView *)viewFooter {
    if (_viewFooter) return _viewFooter;
    _viewFooter = [[MTButtonsView alloc] initWithFrame:[self rectFooterView]];
    _viewFooter.contentInsets = UIEdgeInsetsMake(self.rowHeight*.5f, self.edgeInsets.left*3.f, self.rowHeight*.7f, self.edgeInsets.right*3.f);
    
    [_viewFooter toAddButtonWithTitle:@"清空历史" withTag:0 withStyle:ButtonStyleCustom target:[self recordVM] action:@selector(toClearAllRecord)];
    
    UIButton *button = [_viewFooter buttonWithTag:0];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTintColor:[UIColor grayDataColor]];
    
    button.layer.cornerRadius = self.cornerRadius;
    button.layer.borderColor = [UIColor grayDataColor].CGColor;
    button.layer.borderWidth = .5f;
    
    return _viewFooter;
}

//MARK: - Getter And Setter
- (MTLocalRecordVM *)recordVM {
    return (MTLocalRecordVM *)self.viewModel;
}

- (UINavigationController *)navigationController {
    if (_navigationController) return _navigationController;
    _navigationController = [[UINavigationController alloc] initWithRootViewController:self];
    [_navigationController.navigationBar setShadowImage:[UIImage new]];
    _navigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    return _navigationController;
}

- (MTTextField *)fieldSearch {
    if (_fieldSearch) return _fieldSearch;
    _fieldSearch = [[MTTextField alloc] initWithFrame:CGRectZero];
    _fieldSearch.font = [UIFont descFont];
    _fieldSearch.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.05f];
    _fieldSearch.placeholder = self.placeholder;
    
    _fieldSearch.layer.cornerRadius = self.cornerRadius;
    _fieldSearch.textColor = [UIColor dataColor];
    [_fieldSearch setLeftImage:[[UIImage imageNamed:@"searchicon"] imageWithTintColor:[UIColor lightGrayColor]]];
    
    _fieldSearch.returnKeyType = UIReturnKeySearch;
    _fieldSearch.delegate = self;
    
    return _fieldSearch;
}

- (void)setFinderKey:(NSString *)finderKey {
    _finderKey = finderKey;
    self.recordVM.recordKey = finderKey;
}

//MARK: - Action
- (void)toSetupNavgationItem {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(toDealCancelBatItem)];
    
    [rightItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont descFont],NSFontAttributeName,[UIColor grayDataColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
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
    
    cell.textLabel.text = [[self recordVM] recordAtIndexPath:indexPath];
    
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
