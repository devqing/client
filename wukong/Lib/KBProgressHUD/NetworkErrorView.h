//
//  NetworkErrorView.h
//  customer-ios
//
//  Created by liuweiqing on 15/12/7.
//  Copyright (c) 2015年 Leoc O'Cear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetworkErrorView : UIView

+ (void)showNetworkErrorWithTitle:(NSString *)title subTitle:(NSString *)subTitle ToView:(UIView *)view;
+ (void)showNetworkErrorWithTitle:(NSString *)title subTitle:(NSString *)subTitle;

@end
