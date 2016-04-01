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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+ (void)initialize
{
    /**
     *  设置导航栏的title
     */
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.tintColor = [UIColor whiteColor];
    
//    [bar setTranslucent:YES];
    
    //bar.backItem.title = @"333";
//    [bar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:(UIBarMetricsDefault)];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[UITextAttributeTextColor] = [UIColor whiteColor];
    dict[UITextAttributeFont] = [UIFont systemFontOfSize:16];
    
    [bar setTitleTextAttributes:dict];
    
    /**
     *  设置导航栏的按钮样式
     */
    UIBarButtonItem *item = [UIBarButtonItem  appearance];
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    dict1[UITextAttributeTextColor] = [UIColor whiteColor];
    dict1[UITextAttributeFont] = [UIFont systemFontOfSize:14];
    //item.image.
    
    [item setTitleTextAttributes:dict1 forState:(UIControlStateNormal)];
    
}

@end
