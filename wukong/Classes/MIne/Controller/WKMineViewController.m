//
//  MineViewController.m
//  wukong
//
//  Created by liuweiqing on 16/4/1.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKMineViewController.h"
#import "UIViewController+navBar.h"
#import "UserInfoViewCell.h"
#import "WKSettingViewController.h"
#import <LCActionSheet.h>
#import <QiniuSDK.h>
#import "WKPersionalViewController.h"

@interface WKMineViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,LCActionSheetDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *formTableView;

@end

@implementation WKMineViewController

#pragma mark --life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setnavigationWithTitle:@"我"];
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
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    if (indexPath.section == 0) {
        return 80;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UserInfoViewCell *cell = [[UserInfoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        return cell;
    }else
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.imageView.image = [UIImage imageNamed:@"MoreSetting"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"设置";
        return cell;
    }
    return nil;
}

#pragma mark --UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        WKSettingViewController *settingViewController = [[WKSettingViewController alloc] init];
        [self.navigationController pushViewController:settingViewController animated:YES];
    }else if (indexPath.section == 0)
    {
//        LCActionSheet *sheet = [[LCActionSheet alloc] initWithTitle:@"选择照片" buttonTitles:@[@"拍照",@"相册选择"] redButtonIndex:10 delegate:self];
//        [sheet show];
        WKPersionalViewController *persionalViewController = [[WKPersionalViewController alloc] init];
        [self.navigationController pushViewController:persionalViewController animated:YES];
    }
}

#pragma mark --LCActionSheetDelegate
- (void)actionSheet:(LCActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else if(buttonIndex == 1)
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    
}

#pragma UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%@",info);
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
