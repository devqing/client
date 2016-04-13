//
//  WKFriendInviteViewCell.h
//  wukong
//
//  Created by liuweiqing on 16/4/13.
//  Copyright © 2016年 RT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>

@class WKFriendInviteViewCell;
@protocol WKFriendInviteViewCellDelegate <NSObject>

- (void)friendInviteViewCell:(WKFriendInviteViewCell *)friendInviteViewCell didClickAcceptButton:(UIButton *)button sourceId:(NSString *)sourceId;

@end

@interface WKFriendInviteViewCell : UITableViewCell

@property (nonatomic, strong) RCMessage *model;
@property (nonatomic, weak) id<WKFriendInviteViewCellDelegate> delegate;

@end
