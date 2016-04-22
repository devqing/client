//
//  WKNameViewController.m
//  wukong
//
//  Created by liuweiqing on 16/4/22.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKNameViewController.h"
#import "WKAccountInfo.h"
#import "WKApiUpdateUserinfoManager.h"

@interface WKNameViewController ()<UITableViewDataSource,UITableViewDelegate,RTAPIManagerApiCallBackDelegate,RTAPIManagerParamSourceDelegate>

@property (nonatomic, strong) UITableView *formTableView;
@property (nonatomic, strong) UITextField *nameTextField;

@property (nonatomic, strong) WKApiUpdateUserinfoManager *apiManager;

@end

@implementation WKNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftItem =  [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelButtonClick)];
    NSMutableDictionary *leftattrs = [NSMutableDictionary dictionary];
    leftattrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    leftattrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [leftItem setTitleTextAttributes:leftattrs forState:UIControlStateNormal];
    
    
    UIBarButtonItem *rightItem =  [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveButtonClick)];
    NSMutableDictionary *rightattrs = [NSMutableDictionary dictionary];
    rightattrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    rightattrs[NSForegroundColorAttributeName] = UIColorFromRGB(UI_COLOR_SAVE_ENABLE);
    [rightItem setTitleTextAttributes:rightattrs forState:UIControlStateNormal];
    
    NSMutableDictionary *disabledAttrs = [NSMutableDictionary dictionary];
    disabledAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    disabledAttrs[NSForegroundColorAttributeName] = UIColorFromRGB(UI_COLOR_SAVE_NO_ENABLE);
    [rightItem setTitleTextAttributes:disabledAttrs forState:UIControlStateDisabled];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.view addSubview:self.formTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.nameTextField becomeFirstResponder];
}

#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addSubview:self.nameTextField];
    
    return cell;
}

#pragma mark --RTAPIManagerApiCallBackDelegate
- (void)managerCallAPIDidFailed:(RTApiBaseManager *)manager
{
    NSLog(@"%@",[manager fetchDataWithReformer:nil]);
}

- (void)managerCallAPIDidSuccess:(RTApiBaseManager *)manager
{
    NSDictionary *response = [manager fetchDataWithReformer:nil];
    
    [[WKAccountInfo sharedInstance] setAccount:response[@"data"]];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --RTAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(RTApiBaseManager *)manager
{
    return @{
             @"uid":[WKAccountInfo sharedInstance].uid,
             @"nike_name":self.nameTextField.text
             };
}

#pragma mark --event response
- (void)cancelButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldDidChange:(UITextField *)theTextField{
    if (theTextField.text.length > 0 && (![theTextField.text isEqualToString:[WKAccountInfo sharedInstance].nikeName])) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }else
        self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)saveButtonClick
{
    [self.nameTextField resignFirstResponder];
    [self.apiManager loadData];
}

#pragma mark --getter&setter
- (UITableView *)formTableView
{
    if (_formTableView == nil) {
        _formTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _formTableView.delegate = self;
        _formTableView.dataSource = self;
    }
    return _formTableView;
}

- (UITextField *)nameTextField
{
    if (_nameTextField == nil) {
        _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, UI_SCREEN_WIDTH-20, 50)];
        _nameTextField.font = [UIFont systemFontOfSize:17];
        _nameTextField.textColor = [UIColor blackColor];
        _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameTextField.text = [WKAccountInfo sharedInstance].nikeName;
        [_nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _nameTextField;
}

- (WKApiUpdateUserinfoManager *)apiManager
{
    if (_apiManager == nil) {
        _apiManager = [[WKApiUpdateUserinfoManager alloc] init];
        _apiManager.delegate = self;
        _apiManager.paramSource = self;
    }
    return _apiManager;
}

@end
