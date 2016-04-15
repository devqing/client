//
//  WKFriendInviteViewCell.m
//  wukong
//
//  Created by liuweiqing on 16/4/13.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "WKFriendInviteViewCell.h"
#import <UIImageView+WebCache.h>

@interface WKFriendInviteViewCell()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *inviteLabel;
@property (nonatomic, strong) UIButton *acceptButton;
@property (nonatomic, strong) NSString *sourceId;

@end

@implementation WKFriendInviteViewCell

#pragma mark --life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)configCell
{
    [self addSubview:self.iconView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.inviteLabel];
    [self addSubview:self.acceptButton];
}

- (void)setModel:(RCMessage *)model
{
    
    RCContactNotificationMessage *contactNotificationMsg = (RCContactNotificationMessage *)model.content;
    self.sourceId = contactNotificationMsg.sourceUserId;
    NSDictionary *cache_userinfo = [[NSUserDefaults standardUserDefaults]objectForKey:contactNotificationMsg.sourceUserId];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:cache_userinfo[@"avatar"]] placeholderImage:[UIImage imageNamed:@"fts_default_headimage"]];
    self.nameLabel.text = cache_userinfo[@"nike_name"];
    self.inviteLabel.text = @"申请添加您为好友";
}

#pragma mark --event response
- (void)acceptButtonClick
{
    if ([self.delegate respondsToSelector:@selector(friendInviteViewCell:didClickAcceptButton:sourceId:)]) {
        [self.delegate friendInviteViewCell:self didClickAcceptButton:self.acceptButton sourceId:self.sourceId];
    }
}

#pragma mark --getter&setter
- (UIImageView *)iconView
{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7.5, 45, 45)];
    }
    return _iconView;
}
- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, UI_SCREEN_WIDTH-55-20, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}

- (UILabel *)inviteLabel
{
    if (_inviteLabel == nil) {
        _inviteLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 35, UI_SCREEN_WIDTH-55-20, 16)];
        _inviteLabel.textColor = [UIColor blackColor];
        _inviteLabel.font = [UIFont systemFontOfSize:12];
        _inviteLabel.text = @"申请添加您为好友";
    }
    return _inviteLabel;
}

- (UIButton *)acceptButton
{
    if (_acceptButton == nil) {
        _acceptButton = [[UIButton alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH-35-15, 17.5, 40, 25)];
        _acceptButton.backgroundColor = UIColorFromRGB(UI_COLOR_TABBAR_TEXT_HL);
        [_acceptButton setTitle:@"接受" forState:UIControlStateNormal];
        _acceptButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_acceptButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_acceptButton addTarget:self action:@selector(acceptButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _acceptButton.layer.cornerRadius = 4.0;
        _acceptButton.layer.masksToBounds = YES;
    }
    return _acceptButton;
}


@end
