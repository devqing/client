//
//  ContactsViewController.m
//  wukong
//
//  Created by liuweiqing on 16/4/1.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKContactsViewController.h"
#import "UIViewController+navBar.h"
#import "WKApiGetFriendsManager.h"
#import "FriendViewCell.h"
#import "WKAccountInfo.h"

@interface WKContactsViewController ()<UITableViewDataSource,UITableViewDelegate,RTAPIManagerApiCallBackDelegate,RTAPIManagerParamSourceDelegate>

@property (nonatomic, strong) UITableView *formTableView;
@property (nonatomic, strong) WKApiGetFriendsManager *apiManager;
@property (nonatomic, strong) NSArray *friendsArray;

@end

@implementation WKContactsViewController

#pragma mark --life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setnavigationWithTitle:@"通讯录"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.formTableView];
    
    [self.apiManager loadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark --RTAPIManagerApiCallBackDelegate

- (void)managerCallAPIDidFailed:(RTApiBaseManager *)manager
{
    
}

- (void)managerCallAPIDidSuccess:(RTApiBaseManager *)manager
{
    NSDictionary *response = [manager fetchDataWithReformer:nil];
    self.friendsArray = [NSArray arrayWithArray:response[@"data"][@"friends"]];
    [self.formTableView reloadData];
}
#pragma mark --RTAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(RTApiBaseManager *)manager
{
    return @{
             @"uid":[WKAccountInfo sharedInstance].uid
             };
}

#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.friendsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendViewCell"];
    if (cell == nil) {
        cell = [[FriendViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FriendViewCell"];
    }
    [cell configWithData:self.friendsArray[indexPath.row]];
    
    return cell;
}

#pragma mark --UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark --getter&setter
- (UITableView *)formTableView
{
    if (_formTableView == nil) {
        _formTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
        _formTableView.delegate = self;
        _formTableView.dataSource = self;
        _formTableView.tableFooterView = [[UIView alloc] init];
    }
    return _formTableView;
}

- (WKApiGetFriendsManager *)apiManager
{
    if (_apiManager ==nil) {
        _apiManager = [[WKApiGetFriendsManager alloc] init];
        _apiManager.delegate = self;
        _apiManager.paramSource = self;
    }
    return _apiManager;
}

@end
