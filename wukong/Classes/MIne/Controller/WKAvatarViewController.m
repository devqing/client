//
//  WKAvatarViewController.m
//  wukong
//
//  Created by liuweiqing on 16/4/20.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKAvatarViewController.h"
#import "UIViewController+navBar.h"
#import <UIImageView+WebCache.h>
#import "WKAccountInfo.h"
#import <LCActionSheet.h>
#import <QiniuSDK.h>
#import <MBProgressHUD.h>
#import "PromptView.h"
#import "WKApiGetUploadTokenManager.h"
#import "WKApiUpdateUserinfoManager.h"

@interface WKAvatarViewController ()<LCActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,RTAPIManagerApiCallBackDelegate,RTAPIManagerParamSourceDelegate>

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIButton *barMoreButton;
@property (nonatomic, strong) WKApiGetUploadTokenManager *uploadTokenManager;
@property (nonatomic, strong) WKApiUpdateUserinfoManager *updateManager;
@property (nonatomic, strong) NSString *avatarKey;
@property (nonatomic, strong) UIImage *avatarImage;
@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation WKAvatarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.barMoreButton];
    self.view.backgroundColor = [UIColor blackColor];
    [self setnavigationWithTitle:@"个人头像"];
    [self.view addSubview:self.avatarImageView];
}

#pragma mark --event respnse
- (void)barMoreButtonClick
{
    LCActionSheet *sheet = [[LCActionSheet alloc] initWithTitle:@"头像选择" buttonTitles:@[@"拍照",@"相册选择"] redButtonIndex:10 delegate:self];
    [sheet show];
}

#pragma mark --LCActionSheetDelegate
- (void)actionSheet:(LCActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.allowsEditing = YES;
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }else if(buttonIndex == 1)
    {
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.allowsEditing = YES;
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }
}
#pragma UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%@",info);
    self.avatarImage = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.uploadTokenManager loadData];
    //    self.avatarImageView.image = img;
    //    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --RTAPIManagerApiCallBackDelegate

- (void)managerCallAPIDidFailed:(RTApiBaseManager *)manager
{
    
}

- (void)managerCallAPIDidSuccess:(RTApiBaseManager *)manager
{
    if (manager == self.uploadTokenManager) {
        NSDictionary *response = [manager fetchDataWithReformer:nil];
        QNUploadManager *upManager = [[QNUploadManager alloc] init];
        NSString *key = response[@"data"][@"key"];
        [upManager putData:UIImageJPEGRepresentation(self.avatarImage,0.05) key:key token:response[@"data"][@"token"] complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            NSLog(@"%@",info);
            NSLog(@"%@",resp);
            NSLog(@"%@",key);
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([resp allKeys].count > 0) {
                    self.avatarKey = key;
                    [self.updateManager loadData];
                }else
                {
                    [PromptView showErrorWithTitle:@"上传失败，请重试"];
                    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
                }
            });
            
            
        } option:nil];
    }else if (manager == self.updateManager)
    {
        [PromptView showSuccessWithTitle:@"上传成功"];
        [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark --RTAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(RTApiBaseManager *)manager
{
    if (manager == self.updateManager) {
        return @{
                 @"uid":[WKAccountInfo sharedInstance].uid,
                 @"avatar":self.avatarKey
                 };
    }else
    {
        return @{
                 @"uid":[WKAccountInfo sharedInstance].uid
                 };
    }
    return nil;
}

#pragma mark --getter&setter
- (UIImageView *)avatarImageView
{
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (UI_SCREEN_HEIGHT-UI_SCREEN_WIDTH)/2, UI_SCREEN_WIDTH, UI_SCREEN_WIDTH)];
        [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:[WKAccountInfo sharedInstance].avatar]];
    }
    return _avatarImageView;
}

- (UIButton *)barMoreButton
{
    if (_barMoreButton == nil) {
        _barMoreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [_barMoreButton setBackgroundImage:[UIImage imageNamed:@"barbuttonicon_more"] forState:UIControlStateNormal];
        [_barMoreButton addTarget:self action:@selector(barMoreButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _barMoreButton;
}
- (WKApiGetUploadTokenManager *)uploadTokenManager
{
    if (_uploadTokenManager == nil) {
        _uploadTokenManager = [[WKApiGetUploadTokenManager alloc] init];
        _uploadTokenManager.delegate = self;
        _uploadTokenManager.paramSource = self;
    }
    return _uploadTokenManager;
}
- (WKApiUpdateUserinfoManager *)updateManager
{
    if (_updateManager == nil) {
        _updateManager = [[WKApiUpdateUserinfoManager alloc] init];
        _updateManager.delegate = self;
        _updateManager.paramSource = self;
    }
    return _updateManager;
}

@end
