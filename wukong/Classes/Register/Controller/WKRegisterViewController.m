//
//  WKRegisterViewController.m
//  wukong
//
//  Created by liuweiqing on 16/4/7.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKRegisterViewController.h"
#import "WKApiRegisterManager.h"
#import <MBProgressHUD.h>
#import "WKAccountInfo.h"
#import "WKTools.h"

@interface WKRegisterViewController ()<RTAPIManagerApiCallBackDelegate,RTAPIManagerParamSourceDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *accountLabel;
@property (nonatomic, strong) UITextField *accountTextField;
@property (nonatomic, strong) UILabel *passwordLabel;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIView *bottomLine1;
@property (nonatomic, strong) UIView *bottomLine2;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) WKApiRegisterManager *apiManager;


@end

@implementation WKRegisterViewController

#pragma mark --life cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.accountLabel];
    [self.view addSubview:self.accountTextField];
    [self.view addSubview:self.bottomLine1];
    [self.view addSubview:self.passwordLabel];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.bottomLine2];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.cancelButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.userInteractionEnabled = YES;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)]];
    
    if (self.accountTextField.text.length > 0&&self.passwordTextField.text.length > 0) {
        self.loginButton.enabled = YES;
    }else
    self.loginButton.enabled = NO;
}

#pragma mark --RTAPIManagerApiCallBackDelegate
- (void)managerCallAPIDidFailed:(RTApiBaseManager *)manager
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)managerCallAPIDidSuccess:(RTApiBaseManager *)manager
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"%@",[manager fetchDataWithReformer:nil]);
    NSDictionary *response = [manager fetchDataWithReformer:nil];
    [[WKAccountInfo sharedInstance] setAccount:response[@"data"]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SIGNUP_SUCCUSS" object:nil];
}

#pragma mark --RTAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(RTApiBaseManager *)manager
{
    return @{
             @"mobile":self.accountTextField.text,
             @"password":[WKTools md5:self.passwordTextField.text]
             };
}

#pragma mark --event response
- (void)hideKeyboard
{
    [self.view endEditing:YES];
}

- (void)loginButtonClick
{
    [self hideKeyboard];
    NSString *mobileNum = self.accountTextField.text;
    NSString *mobileNumRegex = @"^((13[0-9])|(17[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSPredicate *mobileNumPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNumRegex];
    if ([mobileNumPredicate evaluateWithObject:mobileNum]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self.apiManager loadData];
    } else {
        UIAlertView *wrongNumFormateAlert = [[UIAlertView alloc] initWithTitle:nil message:@"手机号不正确" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [wrongNumFormateAlert show];
    }
    
}

- (void)cancelButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textFieldDidChange:(UITextField *)theTextField{
    if (self.accountTextField.text.length > 0&&self.passwordTextField.text.length > 0) {
        self.loginButton.enabled = YES;
    }else
    self.loginButton.enabled = NO;
}
#pragma mark --getter&setter
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64+10, UI_SCREEN_WIDTH, 44)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:25];
        _titleLabel.text = @"使用手机号进行注册";
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UILabel *)accountLabel
{
    if (_accountLabel == nil) {
        _accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.titleLabel.frame)+40, 100, 30)];
        _accountLabel.textAlignment = NSTextAlignmentLeft;
        _accountLabel.textColor = [UIColor blackColor];
        _accountLabel.backgroundColor = [UIColor clearColor];
        _accountLabel.font = [UIFont systemFontOfSize:18];
        _accountLabel.text = @"账号";
    }
    return _accountLabel;
}

- (UILabel *)passwordLabel
{
    if (_passwordLabel == nil) {
        _passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.bottomLine1.frame)+10, 100, 30)];
        _passwordLabel.textAlignment = NSTextAlignmentLeft;
        _passwordLabel.textColor = [UIColor blackColor];
        _passwordLabel.backgroundColor = [UIColor clearColor];
        _passwordLabel.font = [UIFont systemFontOfSize:18];
        _passwordLabel.text = @"密码";
    }
    return _passwordLabel;
}

- (UITextField *)accountTextField
{
    if (_accountTextField == nil) {
        _accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.accountLabel.frame), CGRectGetMaxY(self.titleLabel.frame)+40, UI_SCREEN_WIDTH-CGRectGetMaxX(self.accountLabel.frame)-20, 30)];
        _accountTextField.backgroundColor = [UIColor clearColor];
        _accountTextField.font = [UIFont systemFontOfSize:18];
        _accountTextField.placeholder = @"请填写手机号";
        _accountTextField.clearButtonMode = UITextFieldViewModeAlways;
        _accountTextField.textColor = [UIColor blackColor];
        [_accountTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _accountTextField;
}

- (UITextField *)passwordTextField
{
    if (_passwordTextField == nil) {
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.passwordLabel.frame), CGRectGetMaxY(self.bottomLine1.frame)+10, UI_SCREEN_WIDTH-CGRectGetMaxX(self.accountLabel.frame)-20, 30)];
        _passwordTextField.backgroundColor = [UIColor clearColor];
        _passwordTextField.font = [UIFont systemFontOfSize:18];
        _passwordTextField.placeholder = @"请填写密码";
        _passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
        _passwordTextField.textColor = [UIColor blackColor];
        _passwordTextField.secureTextEntry = YES;
        [_passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _passwordTextField;
}

- (UIView *)bottomLine1
{
    if (_bottomLine1 == nil) {
        _bottomLine1 = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.accountLabel.frame)+7, UI_SCREEN_WIDTH-20, 0.5)];
        _bottomLine1.backgroundColor = UIColorFromRGB(UI_COLOR_SEPRATOR_LINE);
    }
    return _bottomLine1;
}
- (UIView *)bottomLine2
{
    if (_bottomLine2 == nil) {
        _bottomLine2 = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.passwordLabel.frame)+7, UI_SCREEN_WIDTH-20, 0.5)];
        _bottomLine2.backgroundColor = UIColorFromRGB(UI_COLOR_SEPRATOR_LINE);
    }
    return _bottomLine2;
}

- (UIButton *)loginButton
{
    if (_loginButton == nil) {
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.bottomLine2.frame)+40, UI_BUTTON_WIDTH, UI_BUTTON_HEIGHT)];
        UIImage *image = [UIImage imageNamed:@"GreenBigBtn"];
        NSInteger leftCapWidth = image.size.width * 0.5f;
        NSInteger topCapHeight = image.size.height * 0.5f;
        
        image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
        [_loginButton setBackgroundImage:image forState:UIControlStateNormal];
        
        UIImage *image1 = [UIImage imageNamed:@"GreenBigBtnDisable"];
        NSInteger leftCapWidth1 = image1.size.width * 0.5f;
        NSInteger topCapHeight1 = image1.size.height * 0.5f;
        
        image1 = [image1 stretchableImageWithLeftCapWidth:leftCapWidth1 topCapHeight:topCapHeight1];
        [_loginButton setBackgroundImage:image1 forState:UIControlStateDisabled];
        
        UIImage *image2 = [UIImage imageNamed:@"GreenBigBtnHighlight"];
        NSInteger leftCapWidth2 = image2.size.width * 0.5f;
        NSInteger topCapHeight2 = image2.size.height * 0.5f;
        
        image2 = [image2 stretchableImageWithLeftCapWidth:leftCapWidth2 topCapHeight:topCapHeight2];
        [_loginButton setBackgroundImage:image2 forState:UIControlStateHighlighted];
        
        [_loginButton setTitle:@"注册" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)cancelButton
{
    if (_cancelButton == nil) {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, 40, 30)];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:UIColorFromRGB(UI_COLOR_TABBAR_TEXT_HL) forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (WKApiRegisterManager *)apiManager
{
    if (_apiManager == nil) {
        _apiManager = [[WKApiRegisterManager alloc] init];
        _apiManager.delegate = self;
        _apiManager.paramSource = self;
    }
    return _apiManager;
}

@end
