//
//  WKSexViewController.m
//  wukong
//
//  Created by liuweiqing on 16/4/22.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKSexViewController.h"

@interface WKSexViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *formTableView;

@end

@implementation WKSexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.formTableView];
}

#pragma mark --UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark --UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor = [UIColor blackColor];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"男";
    }
    if (indexPath.row == 1)
    {
        cell.textLabel.text = @"女";
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
