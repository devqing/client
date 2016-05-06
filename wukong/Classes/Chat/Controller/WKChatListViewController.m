//
//  ChatViewController.m
//  wukong
//
//  Created by liuweiqing on 16/4/1.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKChatListViewController.h"
#import "UIViewController+navBar.h"
#import <RongIMKit/RongIMKit.h>
#import "WKAddBackView.h"
#import "WKSearchFriendViewController.h"
#import "RCDChatListCell.h"
#import <UIImageView+WebCache.h>
#import "WKFriendInvitationTableViewController.h"
#import "WKChatViewController.h"
#import "WKApiUserInfoManager.h"
#import <JGProgressHUD.h>

@interface WKChatListViewController ()<UITableViewDataSource,UITableViewDelegate,RTAPIManagerApiCallBackDelegate,RTAPIManagerParamSourceDelegate>

@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) WKAddBackView *addBackView;
@property (nonatomic, assign) BOOL expand;
@property (nonatomic, strong) WKApiUserInfoManager *apiManager;
@property (nonatomic, strong) WKApiUserInfoManager *newApplyManager;
@property (nonatomic, strong) NSString *sourceId;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) RCContactNotificationMessage *message;

@end

@implementation WKChatListViewController


#pragma mark --life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION), @(ConversationType_APPSERVICE), @(ConversationType_PUBLICSERVICE),@(ConversationType_GROUP),@(ConversationType_SYSTEM)]];
    
    self.conversationListTableView.tableFooterView = [[UIView alloc] init];
    //聚合会话类型
    [self setCollectionConversationType:@[@(ConversationType_GROUP),@(ConversationType_DISCUSSION)]];
    [self setupRightItem];
    [self setnavigationWithTitle:@"微信"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
#pragma mark --new message
-(void)didReceiveMessageNotification:(NSNotification *)notification
{
    //处理好友请求
    RCMessage *message = notification.object;
    if ([message.content isMemberOfClass:[RCContactNotificationMessage class]]) {
        
        if (message.conversationType != ConversationType_SYSTEM) {
            NSLog(@"好友消息要发系统消息！！！");
#if DEBUG
            @throw  [[NSException alloc] initWithName:@"error" reason:@"好友消息要发系统消息！！！" userInfo:nil];
#endif
        }
        RCContactNotificationMessage *_contactNotificationMsg = (RCContactNotificationMessage *)message.content;
        self.message = _contactNotificationMsg;
        if (_contactNotificationMsg.sourceUserId == nil || _contactNotificationMsg.sourceUserId .length ==0) {
            return;
        }
        self.sourceId = _contactNotificationMsg.sourceUserId;
        [self.newApplyManager loadData];
        
        
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            //调用父类刷新未读消息数
            [super didReceiveMessageNotification:notification];
        });
    }
}


- (void)setupRightItem
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.addButton];
}

#pragma mark --UITableViewDataSource
-(void)rcConversationListTableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
        if (_cache_userinfo) {
            userName = _cache_userinfo[@"nike_name"];
            portraitUri = _cache_userinfo[@"avatar"];
        }else
        {
            self.indexPath = indexPath;
            self.sourceId = _contactNotificationMsg.sourceUserId;
            [self.apiManager loadData];
        }
        
    }
    
    RCDChatListCell *cell = [[RCDChatListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    cell.lblDetail.text =[NSString stringWithFormat:@"来自%@的好友请求",userName];
    [cell.ivAva sd_setImageWithURL:[NSURL URLWithString:portraitUri] placeholderImage:[UIImage imageNamed:@"fts_default_headimage"]];
    //    cell.labelTime.text = [self ConvertMessageTime:model.sentTime / 1000];
    cell.model = model;
    return cell;
}

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    if (model.conversationModelType == RC_CONVERSATION_MODEL_TYPE_PUBLIC_SERVICE) {
        WKChatViewController *_conversationVC = [[WKChatViewController alloc] init];
        _conversationVC.conversationType = model.conversationType;
        _conversationVC.targetId = model.targetId;
        _conversationVC.title = model.conversationTitle;
        _conversationVC.conversation = model;
        _conversationVC.unReadMessage = model.unreadMessageCount;
        [self.navigationController pushViewController:_conversationVC animated:YES];
    }
    
    if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_NORMAL) {
        WKChatViewController *_conversationVC = [[WKChatViewController alloc]init];
        _conversationVC.conversationType = model.conversationType;
        _conversationVC.targetId = model.targetId;
        _conversationVC.title = model.conversationTitle;
        _conversationVC.conversation = model;
        _conversationVC.unReadMessage = model.unreadMessageCount;
        _conversationVC.enableNewComingMessageIcon=YES;//开启消息提醒
        _conversationVC.enableUnreadMessageIcon=YES;
        if (model.conversationType == ConversationType_SYSTEM) {
            _conversationVC.title = @"系统消息";
        }
        [self.navigationController pushViewController:_conversationVC animated:YES];
    }
    
    //自定义会话类型
    if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION) {
        RCConversationModel *model = self.conversationListDataSource[indexPath.row];
        
        WKFriendInvitationTableViewController *temp = [[WKFriendInvitationTableViewController alloc] init];
        temp.conversationType = model.conversationType;
        temp.targetId = model.targetId;
        temp.userName = model.conversationTitle;
        temp.title = model.conversationTitle;
        temp.conversation = model;
        [self.navigationController pushViewController:temp animated:YES];
    }
    
}

#pragma mark --RTAPIManagerApiCallBackDelegate

- (void)managerCallAPIDidFailed:(RTApiBaseManager *)manager
{
    
}

- (void)managerCallAPIDidSuccess:(RTApiBaseManager *)manager
{
    if (manager == self.apiManager) {
        
        NSLog(@"%@",[manager fetchDataWithReformer:nil]);
        NSDictionary *response = [manager fetchDataWithReformer:nil][@"data"];
        [[NSUserDefaults standardUserDefaults] setObject:response forKey:self.sourceId];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.conversationListTableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else if (manager == self.newApplyManager)
    {
        NSLog(@"%@",[manager fetchDataWithReformer:nil]);
        NSDictionary *response = [manager fetchDataWithReformer:nil][@"data"];
        [[NSUserDefaults standardUserDefaults] setObject:response forKey:self.sourceId];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        RCUserInfo *rcduserinfo_ = [RCUserInfo new];
        rcduserinfo_.name = response[@"nike_name"];
        rcduserinfo_.userId = response[@"_id"];
        rcduserinfo_.portraitUri = response[@"avatar"];
        
        RCConversationModel *customModel = [RCConversationModel new];
        customModel.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
        customModel.extend = rcduserinfo_;
        customModel.conversationType = ConversationType_SYSTEM;
        customModel.senderUserId = self.sourceId;
        customModel.lastestMessage = self.message;
        
        [self refreshConversationTableViewWithConversationModel:customModel];
        //        [self notifyUpdateUnreadMessageCount];
        [self refreshConversationTableViewIfNeeded];
    }
}

#pragma mark --RTAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(RTApiBaseManager *)manager
{
    return @{
             @"uid":self.sourceId
             };
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

- (WKApiUserInfoManager *)apiManager
{
    if (_apiManager == nil) {
        _apiManager = [[WKApiUserInfoManager alloc] init];
        _apiManager.delegate = self;
        _apiManager.paramSource = self;
    }
    return _apiManager;
}

- (WKApiUserInfoManager *)newApplyManager
{
    if (_newApplyManager == nil) {
        _newApplyManager = [[WKApiUserInfoManager alloc] init];
        _newApplyManager.delegate = self;
        _newApplyManager.paramSource = self;
    }
    return _newApplyManager;
}

@end
