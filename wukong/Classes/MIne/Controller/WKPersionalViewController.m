//
//  WKPersionalViewController.m
//  wukong
//
//  Created by liuweiqing on 16/4/18.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKPersionalViewController.h"
#import "UIViewController+navBar.h"
#import "WKAccountInfo.h"
#import <UIImageView+WebCache.h>
#import "WKAvatarViewController.h"
#import "WKNameViewController.h"
#import "WKSignatureViewController.h"

@interface WKPersionalViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *formTableView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *wechatLabel;
@property (nonatomic, strong) UILabel *QRcodeLabel;
@property (nonatomic, strong) UILabel *sexLabel;
@property (nonatomic, strong) UILabel *signatureLabel;
@property (nonatomic, strong) UIImageView *QRcodeView;

@end

@implementation WKPersionalViewController

#pragma mark --life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setnavigationWithTitle:@"个人信息"];
    [self.view addSubview:self.formTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.formTableView reloadData];
}


#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
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
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"头像";
            [cell addSubview:self.iconView];
            [self.iconView sd_setImageWithURL:[NSURL URLWithString:[WKAccountInfo sharedInstance].avatar]];
        }else if (indexPath.row == 1)
        {
            cell.textLabel.text = @"名字";
            [cell addSubview:self.nameLabel];
            self.nameLabel.text = [WKAccountInfo sharedInstance].nikeName;
        }else if (indexPath.row == 2)
        {
            cell.textLabel.text = @"微信号";
            [cell addSubview:self.wechatLabel];
            self.wechatLabel.text = [WKAccountInfo sharedInstance].uniqueName;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else if (indexPath.row == 3)
        {
            cell.textLabel.text = @"我的二维码";
            [cell addSubview:self.QRcodeView];
        }
    }else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"性别";
            [cell addSubview:self.sexLabel];
            self.sexLabel.text = [WKAccountInfo sharedInstance].sex;
        }else if (indexPath.row == 1)
        {
            cell.textLabel.text = @"个性签名";
            [cell addSubview:self.signatureLabel];
            self.signatureLabel.text = [WKAccountInfo sharedInstance].signature;
        }
    }
    return cell;
}

#pragma mark --UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            WKAvatarViewController *avatarViewController = [[WKAvatarViewController alloc] init];
            [self.navigationController pushViewController:avatarViewController animated:YES];
        }else if (indexPath.row == 1)
        {
            WKNameViewController *nameViewController = [[WKNameViewController alloc] init];
            [self.navigationController pushViewController:nameViewController animated:YES];
        }
    }else if (indexPath.section == 1)
    {
        if (indexPath.row == 1) {
            WKSignatureViewController *signatureViewController = [[WKSignatureViewController alloc] init];
            [self.navigationController pushViewController:signatureViewController animated:YES];
        }
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

- (UIImageView *)iconView
{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-60-40, 10, 60, 60)];
        _iconView.layer.cornerRadius = 4.0;
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.borderWidth = 0.5;
        _iconView.layer.borderColor = [UIColor grayColor].CGColor;
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, UI_SCREEN_WIDTH-100-40, 44)];
        _nameLabel.textColor = [UIColor grayColor];
        _nameLabel.textAlignment = NSTextAlignmentRight;
        _nameLabel.font = [UIFont systemFontOfSize:15];
        
    }
    return _nameLabel;
}

- (UILabel *)wechatLabel
{
    if (_wechatLabel == nil) {
        _wechatLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, UI_SCREEN_WIDTH-100-40, 44)];
        _wechatLabel.textColor = [UIColor grayColor];
        _wechatLabel.textAlignment = NSTextAlignmentRight;
        _wechatLabel.font = [UIFont systemFontOfSize:15];
        
    }
    return _wechatLabel;
}

- (UILabel *)sexLabel
{
    if (_sexLabel == nil) {
        _sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, UI_SCREEN_WIDTH-100-40, 44)];
        _sexLabel.textColor = [UIColor grayColor];
        _sexLabel.textAlignment = NSTextAlignmentRight;
        _sexLabel.font = [UIFont systemFontOfSize:15];
        
    }
    return _sexLabel;
}

- (UILabel *)signatureLabel
{
    if (_signatureLabel == nil) {
        _signatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, UI_SCREEN_WIDTH-100-40, 44)];
        _signatureLabel.textColor = [UIColor grayColor];
        _signatureLabel.textAlignment = NSTextAlignmentRight;
        _signatureLabel.font = [UIFont systemFontOfSize:15];
        
    }
    return _signatureLabel;
}

- (UIImageView *)QRcodeView
{
    if (_QRcodeView == nil) {
        UIImage *image = [UIImage imageNamed:@"setting_myQR"];
        _QRcodeView = [[UIImageView alloc] initWithImage:image];
        _QRcodeView.frame = CGRectMake(UI_SCREEN_WIDTH-image.size.width-30, (44-image.size.height)/2, image.size.width, image.size.height);
        
    }
    return _QRcodeView;
}

@end
