//
//  PromptView.m
//  customer-ios
//
//  Created by liuweiqing on 15/12/27.
//  Copyright © 2015年 Leoc O'Cear. All rights reserved.
//

#import "PromptView.h"

@interface PromptView ()

@property (nonatomic, strong) UIView      *errorView;
@property (nonatomic, strong) UILabel     *errorTitleLabel;
@property (nonatomic, strong) NSString    *errorTitle;
@property (nonatomic, strong) UIView      *successView;
@property (nonatomic, strong) UILabel     *successTitleLabel;
@property (nonatomic, strong) NSString    *successTitle;
@property (nonatomic, strong) UIImageView *errorImageView;
@property (nonatomic, strong) UIImageView *successImageView;

@end

@implementation PromptView

#pragma mark --public method


+ (void)showErrorWithTitle:(NSString *)title
{
    PromptView *errorView = [[PromptView alloc] initWithFrame:[UIScreen mainScreen].bounds errorTitle:title];
    
    UIWindow* windows = [[UIApplication sharedApplication].windows lastObject];
    [windows addSubview:errorView];
    errorView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        errorView.alpha = 1;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            errorView.alpha = 0;
            [errorView removeFromSuperview];
        }];
    });
}

+ (void)showSuccessWithTitle:(NSString *)title
{
    PromptView *successView = [[PromptView alloc] initWithFrame:[UIScreen mainScreen].bounds successTitle:title];
    
    UIWindow* windows = [[UIApplication sharedApplication].windows lastObject];
    [windows addSubview:successView];
    successView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        successView.alpha = 1;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            successView.alpha = 0;
            [successView removeFromSuperview];
        }];
    });
}

#pragma mark --life cycle

- (instancetype)initWithFrame:(CGRect)frame successTitle:(NSString *)title
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.successTitle = title;
        [self addSubview:self.successView];
        [self.successView addSubview:self.successTitleLabel];
        [self.successView addSubview:self.successImageView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame errorTitle:(NSString *)title
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.errorTitle = title;
        [self addSubview:self.errorView];
        [self.errorView addSubview:self.errorTitleLabel];
        [self.errorView addSubview:self.errorImageView];
    }
    return self;
}


#pragma mark --getter&setter
- (UIView *)errorView
{
    if (_errorView == nil) {
        
        if (IOS8_LATER) {
            UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            _errorView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        }else
        {
            _errorView = [[UIView alloc] init];
            _errorView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
        }
        _errorView.frame = CGRectMake((UI_SCREEN_WIDTH-200)/2, (UI_SCREEN_HEIGHT-100)/2, 200, 100);
        _errorView.layer.cornerRadius = 5.0;
        _errorView.layer.masksToBounds = YES;
        _errorView.layer.shadowColor = [UIColor blackColor].CGColor;
    }
    return _errorView;
}

- (UIView *)successView
{
    if (_successView == nil) {
        
        if (IOS8_LATER) {
            UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            _successView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        }else
        {
            _successView = [[UIView alloc] init];
            _successView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
        }
        _successView.frame = CGRectMake((UI_SCREEN_WIDTH-80)/2, (UI_SCREEN_HEIGHT-90)/2, 80, 90);
        _successView.layer.cornerRadius = 7.0;
        _successView.layer.masksToBounds = YES;
        _successView.layer.shadowColor = [UIColor blackColor].CGColor;
    }
    return _successView;
}

- (UILabel *)errorTitleLabel
{
    if (_errorTitleLabel == nil) {
        _errorTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100-45, 200, 35)];
        _errorTitleLabel.text = self.errorTitle;
        _errorTitleLabel.numberOfLines = 0;
        _errorTitleLabel.font = [UIFont systemFontOfSize:13];
        _errorTitleLabel.textColor = [UIColor whiteColor];
        _errorTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _errorTitleLabel;
}

- (UILabel *)successTitleLabel
{
    if (_successTitleLabel == nil) {
        _successTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 90-35, 80, 30)];
        _successTitleLabel.text = self.successTitle;
        _successTitleLabel.font = [UIFont systemFontOfSize:15];
        _successTitleLabel.textColor = [UIColor whiteColor];
        _successTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _successTitleLabel;
}

- (UIImageView *)errorImageView
{
    if (_errorImageView == nil) {
        UIImage *image = [UIImage imageNamed:@"error_icon"];
        _errorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error_icon"]];
        _errorImageView.center = CGPointMake(200/2, image.size.height/2 + 10);
    }
    return _errorImageView;
}
- (UIImageView *)successImageView
{
    if (_successImageView == nil) {
        UIImage *image = [UIImage imageNamed:@"success_icon"];
        _successImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success_icon"]];
        _successImageView.center = CGPointMake(80/2, image.size.height/2 + 10);
    }
    return _successImageView;
}

@end
