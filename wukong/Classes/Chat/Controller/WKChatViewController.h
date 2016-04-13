//
//  WKChatViewController.h
//  wukong
//
//  Created by liuweiqing on 16/4/13.
//  Copyright © 2016年 RT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>

@interface WKChatViewController : RCConversationViewController

/**
 *  会话数据模型
 */
@property (strong,nonatomic) RCConversationModel *conversation;

@end
