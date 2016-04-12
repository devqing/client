//
//  WKSearchFriendViewController.m
//  wukong
//
//  Created by liuweiqing on 16/4/12.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKSearchFriendViewController.h"
#import "WKApiSearchFriendManager.h"
#import "WKAddFriendViewController.h"
#import "SearchFriendsCell.h"

@interface WKSearchFriendViewController()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating,RTAPIManagerApiCallBackDelegate,RTAPIManagerParamSourceDelegate>

@property (nonatomic, strong) UISearchController *searchVc;
@property (nonatomic, strong) WKApiSearchFriendManager *apiManager;
@property (nonatomic, strong) NSString *keyWords;
@property (nonatomic, strong) NSMutableArray *searchArray;

@end

@implementation WKSearchFriendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.definesPresentationContext = YES;
    self.tableView.tableHeaderView = self.searchVc.searchBar;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchVc.active) {
        return self.searchArray.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchVc.active) {
        SearchFriendsCell *cell = [[SearchFriendsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchFriendsCell"];
        [cell configWithData:self.searchArray[indexPath.row]];
        return cell;
    }
    return nil;
}

#pragma mark --UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.searchVc.active) {
        WKAddFriendViewController *addfriend = [[WKAddFriendViewController alloc] init];
        addfriend.userInfo = self.searchArray[indexPath.row];
        [self.navigationController pushViewController:addfriend animated:YES];
    }
}


#pragma mark --UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    [self.searchArray removeAllObjects];
    self.keyWords = searchController.searchBar.text;
    if (self.keyWords.length > 0) {
        [self.apiManager loadData];
    }
}

#pragma mark --RTAPIManagerApiCallBackDelegate

- (void)managerCallAPIDidFailed:(RTApiBaseManager *)manager
{
    
}


- (void)managerCallAPIDidSuccess:(RTApiBaseManager *)manager
{
    NSLog(@"%@---",[manager fetchDataWithReformer:nil]);
    NSDictionary *response = [manager fetchDataWithReformer:nil];
    if ([response[@"data"] allKeys].count > 0) {
        [self.searchArray addObject:response[@"data"]];
    }
    
    [self.tableView reloadData];
}

#pragma mark --RTAPIManagerParamSourceDelegate

- (NSDictionary *)paramsForApi:(RTApiBaseManager *)manager
{
    return @{
             @"mobile":self.keyWords
             };
}

#pragma mark --getter&setter
- (UISearchController *)searchVc
{
    if (_searchVc == nil) {
        _searchVc = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchVc.searchResultsUpdater = self;
        _searchVc.dimsBackgroundDuringPresentation = NO;
        _searchVc.hidesNavigationBarDuringPresentation = YES;
        _searchVc.searchBar.placeholder = @"输入手机号查找";
        [_searchVc.searchBar sizeToFit];
    }
    return _searchVc;
}

- (WKApiSearchFriendManager *)apiManager
{
    if (_apiManager == nil) {
        _apiManager = [[WKApiSearchFriendManager alloc] init];
        _apiManager.delegate = self;
        _apiManager.paramSource = self;
    }
    return _apiManager;
}

- (NSMutableArray *)searchArray
{
    if (_searchArray == nil) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}

@end
