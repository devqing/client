//
//  FindViewController.m
//  wukong
//
//  Created by liuweiqing on 16/4/1.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKFindViewController.h"
#import "UIViewController+navBar.h"

@interface WKFindViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *formTableView;

@end

@implementation WKFindViewController

#pragma mark --life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setnavigationWithTitle:@"发现"];
    [self.view addSubview:self.formTableView];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark --UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"ff_IconShowAlbum"];
        cell.textLabel.text = @"好友动态";
        
    }
    if (indexPath.section == 1) {
        cell.imageView.image = [UIImage imageNamed:@"ff_IconShowAlbum"];
        cell.textLabel.text = @"其他";
    }
    return cell;
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
