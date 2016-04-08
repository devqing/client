//
//  UIViewController+navBar.m
//  wukong
//
//  Created by liuweiqing on 16/4/7.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "UIViewController+navBar.h"

@implementation UIViewController (navBar)

- (void)setnavigationWithTitle:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 375-200, 40)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.text = title;
    self.navigationItem.titleView = titleLabel;

}

@end
