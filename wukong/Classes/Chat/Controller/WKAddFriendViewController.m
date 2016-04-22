//
//  WKAddFriendViewController.m
//  wukong
//
//  Created by liuweiqing on 16/4/12.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKAddFriendViewController.h"
#import "WKApiApplyFriendManager.h"
#import "WKAccountInfo.h"
#import <UIImageView+WebCache.h>
#import "NetworkErrorView.h"
#import "PromptView.h"

@interface WKAddFriendViewController ()<UITableViewDataSource,UITableViewDelegate,RTAPIManagerApiCallBackDelegate,RTAPIManagerParamSourceDelegate>

@property (nonatomic, strong) UITableView *formTableView;

@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) WKApiApplyFriendManager *apiManager;

@end

@implementation WKAddFriendViewController

#pragma mark --life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.formTableView];
}

#pragma mark --UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView *avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 60, 60)];
    [avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.userInfo[@"avatar"]]];
    [cell addSubview:avatarImageView];
    UILabel *nikeNameLable = [[UILabel alloc] initWithFrame:CGRectMake(85, 15, UI_SCREEN_WIDTH-85-20, 20)];
    nikeNameLable.textColor = [UIColor blackColor];
    nikeNameLable.font = [UIFont systemFontOfSize:15];
    nikeNameLable.text = self.userInfo[@"nike_name"];
    [cell addSubview:nikeNameLable];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

#pragma mark --RTAPIManagerApiCallBackDelegate
- (void)managerCallAPIDidFailed:(RTApiBaseManager *)manager
{
    self.addButton.userInteractionEnabled = YES;
    if (manager.errorType == RTAPIManagerErrorTypeTimeout) {
        // 请求超时
        [NetworkErrorView showNetworkErrorWithTitle:@"请求超时" subTitle:@"请稍后重试"];
    }else if (manager.errorType == RTAPIManagerErrorTypeNoNetWork){
        [NetworkErrorView showNetworkErrorWithTitle:@"无网路连接" subTitle:@"请检查您的网络连接"];
        // 无网络
    }else if (manager.errorType == RTAPIManagerErrorTypeParamsError){
        [NetworkErrorView showNetworkErrorWithTitle:@"请求参数错误" subTitle:@"请检查您的请求参数"];
        // 请求参数错误
    }else if (manager.errorType == RTAPIManagerErrorTypeNoContent){
        // response错误
        NSDictionary *reformerData = [manager fetchDataWithReformer:nil];
        [PromptView showErrorWithTitle:reformerData[@"reason"]];
    }else if (manager.errorType == RTAPIManagerErrorTypeDefault){
        [NetworkErrorView showNetworkErrorWithTitle:@"请求错误" subTitle:@"请稍后重试"];
    }
}
- (void)managerCallAPIDidSuccess:(RTApiBaseManager *)manager
{
    self.addButton.userInteractionEnabled = YES;
    NSLog(@"%@",[manager fetchDataWithReformer:nil]);
    [PromptView showSuccessWithTitle:@"发送成功"];
}

#pragma mark --RTAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(RTApiBaseManager *)manager
{
    return @{
             @"from_id":[WKAccountInfo sharedInstance].uid,
             @"to_id":self.userInfo[@"_id"]
             };
}

#pragma mark --event response
- (void)addButtonClick
{
    self.addButton.userInteractionEnabled = NO;
    [self.apiManager loadData];
}


#pragma mark --getter&setter
- (UITableView *)formTableView
{
    if (_formTableView == nil) {
        _formTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _formTableView.delegate = self;
        _formTableView.dataSource = self;
        _formTableView.tableFooterView = self.footerView;
    }
    return _formTableView;
}

- (UIButton *)addButton
{
    if (_addButton == nil) {
        _addButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, UI_BUTTON_WIDTH, UI_BUTTON_HEIGHT)];
        UIImage *image = [UIImage imageNamed:@"GreenBigBtn"];
        NSInteger leftCapWidth = image.size.width * 0.5f;
        NSInteger topCapHeight = image.size.height * 0.5f;
        
        image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
        [_addButton setBackgroundImage:image forState:UIControlStateNormal];
        [_addButton setTitle:@"添加到通讯录" forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (UIView *)footerView
{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 60)];
        [_footerView addSubview:self.addButton];
    }
    return _footerView;
}

- (WKApiApplyFriendManager *)apiManager
{
    if (_apiManager == nil) {
        _apiManager = [[WKApiApplyFriendManager alloc] init];
        _apiManager.delegate = self;
        _apiManager.paramSource = self;
    }
    return _apiManager;
}

@end
