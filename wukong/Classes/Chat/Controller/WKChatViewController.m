//
//  ChatViewController.m
//  wukong
//
//  Created by liuweiqing on 16/4/1.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKChatViewController.h"
#import "UIViewController+navBar.h"
#import <RongIMKit/RongIMKit.h>
#import "WKAddBackView.h"

#define kSCNavBarImageTag 10
@interface WKChatViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *chatTableView;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) WKAddBackView *addBackView;
@property (nonatomic, assign) BOOL expand;

@end

@implementation WKChatViewController


#pragma mark --life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupRightItem];
    [self setnavigationWithTitle:@"微信"];
    
    [self.view addSubview:self.chatTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)setupRightItem
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.addButton];
}

#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = @"测试";
    return cell;
}

#pragma mark --UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = @"570613076703c0427f3ac21d";
    //设置聊天会话界面要显示的标题
    chat.title = @"悟空";
    //显示聊天会话界面
    [self.navigationController pushViewController:chat animated:YES];
}

#pragma mark --event response
- (void)addButtonClick
{
    if (self.expand) {
        self.expand = NO;
        [self.addBackView removeFromSuperview];
        
    }else
    {
        self.expand = YES;
        [self.view addSubview:self.addBackView];
    }
    
}

#pragma mark --getter&setter
- (UITableView *)chatTableView
{
    if (_chatTableView == nil) {
        _chatTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _chatTableView.delegate = self;
        _chatTableView.dataSource = self;
    }
    return _chatTableView;
}

- (UIButton *)addButton
{
    if (_addButton == nil) {
        _addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [_addButton setBackgroundImage:[UIImage imageNamed:@"barbuttonicon_add"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (WKAddBackView *)addBackView
{
    if (_addBackView == nil) {
        _addBackView = [[WKAddBackView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64-49)];
        [_addBackView addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _addBackView.backgroundColor = [UIColor clearColor];
    }
    return _addBackView;
}

@end
