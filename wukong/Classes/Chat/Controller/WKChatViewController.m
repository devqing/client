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
#import "WKSearchFriendViewController.h"
#import "RCDChatListCell.h"
#import <UIImageView+WebCache.h>

#define kSCNavBarImageTag 10
@interface WKChatViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) WKAddBackView *addBackView;
@property (nonatomic, assign) BOOL expand;

@end

@implementation WKChatViewController


#pragma mark --life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION), @(ConversationType_APPSERVICE), @(ConversationType_PUBLICSERVICE),@(ConversationType_GROUP),@(ConversationType_SYSTEM)]];
    
    //聚合会话类型
    [self setCollectionConversationType:@[@(ConversationType_GROUP),@(ConversationType_DISCUSSION)]];
    [self setupRightItem];
    [self setnavigationWithTitle:@"微信"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.conversationListTableView reloadData];
}

- (void)setupRightItem
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.addButton];
}

//#pragma mark --UITableViewDataSource

//左滑删除
-(void)rcConversationListTableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //可以从数据库删除数据
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
    [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_SYSTEM targetId:model.targetId];
    [self.conversationListDataSource removeObjectAtIndex:indexPath.row];
    [self.conversationListTableView reloadData];
}


-(CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 67.0f;
}

-(NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource
{
    for (int i=0; i<dataSource.count; i++) {
        RCConversationModel *model = dataSource[i];
        if(model.conversationType == ConversationType_SYSTEM && [model.lastestMessage isMemberOfClass:[RCContactNotificationMessage class]])
        {
            model.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
        }
    }
    
    return dataSource;
}

-(RCConversationBaseCell *)rcConversationListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
    
    NSString *userName    = nil;
    NSString *portraitUri = nil;
    
    
    if(model.conversationType == ConversationType_SYSTEM && [model.lastestMessage isMemberOfClass:[RCContactNotificationMessage class]])
    {
        RCContactNotificationMessage *_contactNotificationMsg = (RCContactNotificationMessage *)model.lastestMessage;
        
        NSDictionary *_cache_userinfo = [[NSUserDefaults standardUserDefaults]objectForKey:_contactNotificationMsg.sourceUserId];
        userName = _cache_userinfo[@"username"];
        portraitUri = _cache_userinfo[@"portraitUri"];
    }
    
    RCDChatListCell *cell = [[RCDChatListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    cell.lblDetail.text =[NSString stringWithFormat:@"来自%@的好友请求",userName];
    [cell.ivAva sd_setImageWithURL:[NSURL URLWithString:portraitUri] placeholderImage:[UIImage imageNamed:@"system_notice"]];
    //    cell.labelTime.text = [self ConvertMessageTime:model.sentTime / 1000];
    cell.model = model;
    return cell;
}

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    
    RCConversationViewController *_conversationVC = [[RCConversationViewController alloc]init];
    _conversationVC.conversationType = model.conversationType;
    _conversationVC.targetId = model.targetId;
    _conversationVC.userName = model.conversationTitle;
    _conversationVC.title = model.conversationTitle;
    //            _conversationVC.conversation = model;
    _conversationVC.unReadMessage = model.unreadMessageCount;
    _conversationVC.enableNewComingMessageIcon=YES;//开启消息提醒
    _conversationVC.enableUnreadMessageIcon=YES;
    
    [self.navigationController pushViewController:_conversationVC animated:YES];
}

#pragma mark --event response
- (void)addButtonClick
{
    //    if (self.expand) {
    //        self.expand = NO;
    //        [self.addBackView removeFromSuperview];
    //        
    //    }else
    //    {
    //        self.expand = YES;
    //        [self.view addSubview:self.addBackView];
    //    }
    
    WKSearchFriendViewController *search = [[WKSearchFriendViewController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}

#pragma mark --getter&setter

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
