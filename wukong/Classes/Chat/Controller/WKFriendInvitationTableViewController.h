//
//  WKFriendInvitationTableViewController.h
//  wukong
//
//  Created by liuweiqing on 16/4/13.
//  Copyright © 2016年 RT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>

@interface WKFriendInvitationTableViewController : UITableViewController

/**
 *  targetId
 */
@property(nonatomic, strong) NSString *targetId;
/**
 *  targetName
 */
@property(nonatomic, strong) NSString *userName;
/**
 *  conversationType
 */
@property(nonatomic) RCConversationType conversationType;
/**
 * model
 */
@property (strong,nonatomic) RCConversationModel *conversation;

@end
