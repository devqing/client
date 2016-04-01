//
//  ChatViewController.m
//  wukong
//
//  Created by liuweiqing on 16/4/1.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "ChatViewController.h"
#define kSCNavBarImageTag 10
@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *image = [UIImage imageNamed:@"NavBar64"];
    
    NSInteger leftCapWidth = image.size.width * 0.5f;
    // 顶端盖高度
    NSInteger topCapHeight = image.size.height * 0.5f;
    // 重新赋值
    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.textLabel.text = @"哈哈哈";
    cell.imageView.image = [UIImage imageNamed:@"tabbar_badge"];
    return cell;
}


@end
