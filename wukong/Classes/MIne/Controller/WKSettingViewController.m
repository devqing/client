//
//  WKSettingViewController.m
//  wukong
//
//  Created by liuweiqing on 16/4/18.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKSettingViewController.h"
#import "UIViewController+navBar.h"
#import <LCActionSheet.h>
#import "WKAccountInfo.h"

@interface WKSettingViewController ()<UITableViewDataSource,UITableViewDelegate,LCActionSheetDelegate>

@property (nonatomic, strong) UITableView *formTableView;

@end

@implementation WKSettingViewController

#pragma mark --life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setnavigationWithTitle:@"设置"];
    [self.view addSubview:self.formTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1)
    {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        cell.textLabel.text = @"账户与安全";
    }else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"帮助与反馈";
        }else if (indexPath.row == 1)
        {
            cell.textLabel.text = @"关于";
        }
    }else if (indexPath.section == 2)
    {
        cell.textLabel.text = @"退出登录";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

#pragma mark --UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        LCActionSheet *sheet = [[LCActionSheet alloc] initWithTitle:@"确认退出?" buttonTitles:@[@"确认"] redButtonIndex:0 delegate:self];
        [sheet show];
    }
}

#pragma mark --LCActionSheetDelegate
- (void)actionSheet:(LCActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[WKAccountInfo sharedInstance] loginOut];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGOUT_SUCCUSS" object:nil];
    }
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

@end
