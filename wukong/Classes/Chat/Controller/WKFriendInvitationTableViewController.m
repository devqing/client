//
//  WKFriendInvitationTableViewController.m
//  wukong
//
//  Created by liuweiqing on 16/4/13.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKFriendInvitationTableViewController.h"
#import "WKFriendInviteViewCell.h"
#import "WKApiAcceptFriendManager.h"
#import "WKAccountInfo.h"

@interface WKFriendInvitationTableViewController ()<WKFriendInviteViewCellDelegate,RTAPIManagerApiCallBackDelegate,RTAPIManagerParamSourceDelegate>

@property (nonatomic, strong) NSMutableArray *messageArray;
@property (nonatomic, strong) WKApiAcceptFriendManager *apiManager;
@property (nonatomic, strong) NSString *sourceId;

@end

@implementation WKFriendInvitationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.messageArray = [[[RCIMClient sharedRCIMClient] getLatestMessages:self.conversationType
                                                                 targetId:self.targetId
                                                                    count:30] mutableCopy];
    
    __block WKFriendInvitationTableViewController *weakSelf = self;
    [self.messageArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        RCMessage *message = obj;
        if (![message.content isKindOfClass:[RCContactNotificationMessage class]]) {
            [weakSelf.messageArray removeObject:obj];
        } else if (![((RCContactNotificationMessage *)message.content).operation isEqualToString:ContactNotificationMessage_ContactOperationRequest]) {
            [weakSelf.messageArray removeObject:obj];
        }
    }];
    [self.tableView reloadData];
}

#pragma mark --RTAPIManagerApiCallBackDelegate

- (void)managerCallAPIDidFailed:(RTApiBaseManager *)manager
{
    
}

- (void)managerCallAPIDidSuccess:(RTApiBaseManager *)manager
{
    NSLog(@"%@",[manager fetchDataWithReformer:nil]);
}

#pragma mark --RTAPIManagerParamSourceDelegate

- (NSDictionary *)paramsForApi:(RTApiBaseManager *)manager
{
    return @{
             @"from_id":self.sourceId,
             @"to_id":[WKAccountInfo sharedInstance].uid
             };
}

#pragma mark --WKFriendInviteViewCellDelegate
- (void)friendInviteViewCell:(WKFriendInviteViewCell *)friendInviteViewCell didClickAcceptButton:(UIButton *)button sourceId:(NSString *)sourceId
{
    self.sourceId = sourceId;
    [self.apiManager loadData];
}

#pragma mark --UITableViewDataSource
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        RCMessage *message = self.messageArray[indexPath.row];
        
        if ([[RCIMClient sharedRCIMClient] deleteMessages:@[[NSNumber numberWithLong:message.messageId]]]) {
            
            [self.messageArray removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
        }
        else {
            NSLog(@"删除失败，请重试");
        }
        
        if (0 == self.messageArray.count) {
            
            // 删除会话列表
            [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_SYSTEM targetId:self.targetId];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WKFriendInviteViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WKFriendInviteViewCell"];
    if (cell == nil) {
        cell = [[WKFriendInviteViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WKFriendInviteViewCell"];
    }
    cell.delegate = self;
    [cell setModel:self.messageArray[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark --getter&setter
- (WKApiAcceptFriendManager *)apiManager
{
    if (_apiManager == nil) {
        _apiManager = [[WKApiAcceptFriendManager alloc] init];
        _apiManager.delegate = self;
        _apiManager.paramSource = self;
    }
    return _apiManager;
}


@end
