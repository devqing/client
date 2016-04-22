//
//  NetworkErrorView.m
//  customer-ios
//
//  Created by liuweiqing on 15/12/7.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import "NetworkErrorView.h"

@interface NetworkErrorView()

@property (nonatomic, strong) UIView *errorView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;

@end

@implementation NetworkErrorView

#pragma mark --public method
+ (void)showNetworkErrorWithTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    NetworkErrorView *errorView = [[NetworkErrorView alloc] initWithFrame:[UIScreen mainScreen].bounds title:title subTitle:subTitle];
    
    UIWindow* windows = [[UIApplication sharedApplication].windows lastObject];
    [windows addSubview:errorView];
    errorView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        errorView.alpha = 1;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            errorView.alpha = 0;
            [errorView removeFromSuperview];
        }];
    });
}

+ (void)showNetworkErrorWithTitle:(NSString *)title subTitle:(NSString *)subTitle ToView:(UIView *)view
{
    NetworkErrorView *errorView = [[NetworkErrorView alloc] initWithFrame:view.frame title:title subTitle:subTitle];
    [view addSubview:errorView];
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

#pragma mark --life cycle
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title subTitle:(NSString *)subTitle
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.title = title;
        self.subTitle = subTitle;
        [self addSubview:self.errorView];
        [self.errorView addSubview:self.titleLabel];
        [self.errorView addSubview:self.subTitleLabel];
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
        _errorView.frame = CGRectMake((UI_SCREEN_WIDTH-150)/2, (UI_SCREEN_HEIGHT-50)/2, 150, 80);
        _errorView.layer.cornerRadius = 4.0;
        _errorView.layer.masksToBounds = YES;
    }
    return _errorView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 150, 25)];
        _titleLabel.text = self.title;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel
{
    if (_subTitleLabel == nil) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 150, 25)];
        _subTitleLabel.textColor = [UIColor whiteColor];
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.text = self.subTitle;
        _subTitleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _subTitleLabel;
}

@end
