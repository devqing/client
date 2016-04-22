//
//  WKNameViewController.m
//  wukong
//
//  Created by liuweiqing on 16/4/22.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKSignatureViewController.h"
#import "WKAccountInfo.h"
#import "WKApiUpdateUserinfoManager.h"

@interface WKSignatureViewController ()<UITableViewDataSource,UITableViewDelegate,RTAPIManagerApiCallBackDelegate,RTAPIManagerParamSourceDelegate,UITextViewDelegate>

@property (nonatomic, strong) UITableView *formTableView;
@property (nonatomic, strong) UITextView *nameTextView;
@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) WKApiUpdateUserinfoManager *apiManager;
@property (nonatomic, strong) NSString *content;

@end

@implementation WKSignatureViewController

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
    
    [self.nameTextView becomeFirstResponder];
}

#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
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
    [cell addSubview:self.nameTextView];
    [cell addSubview:self.numberLabel];
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
             @"signature":self.nameTextView.text
             };
}

#pragma mark --event response
- (void)cancelButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length >= 30) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        textView.text = [textView.text substringToIndex:30];
    }else
    {
        if (textView.text.length <= 0) {
            self.navigationItem.rightBarButtonItem.enabled = NO;
        }else
            self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    
    self.numberLabel.text = [NSString stringWithFormat:@"%d",30-textView.text.length];
}

- (void)saveButtonClick
{
    [self.nameTextView resignFirstResponder];
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

- (UITextView *)nameTextView
{
    if (_nameTextView == nil) {
        _nameTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 0, UI_SCREEN_WIDTH-20, 60)];
        _nameTextView.font = [UIFont systemFontOfSize:16];
        _nameTextView.textColor = [UIColor blackColor];
        _nameTextView.text = [WKAccountInfo sharedInstance].signature;
        _nameTextView.delegate = self;
        _nameTextView.scrollEnabled = NO;
    }
    return _nameTextView;
}

- (UILabel *)numberLabel
{
    if (_numberLabel == nil) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-30, 60, 30, 20)];
        _numberLabel.textColor = [UIColor grayColor];
        _numberLabel.font = [UIFont systemFontOfSize:14];
        _numberLabel.text = [NSString stringWithFormat:@"%d",(int)(30-[WKAccountInfo sharedInstance].signature.length)];
    }
    return _numberLabel;
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
