//
//  WKNavigationViewController.m
//  wukong
//
//  Created by liuweiqing on 16/4/1.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKNavigationViewController.h"

@interface WKNavigationViewController ()

@end

@implementation WKNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.tintColor = [UIColor whiteColor];
    
    UIImage *image = [UIImage imageNamed:@"background.png"];
    
    NSInteger leftCapWidth = image.size.width * 0.5f;
    NSInteger topCapHeight = image.size.height * 0.5f;

    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    
    [bar setTranslucent:YES];
    [bar setBackgroundImage:image forBarMetrics:(UIBarMetricsDefault)];
    
    

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
