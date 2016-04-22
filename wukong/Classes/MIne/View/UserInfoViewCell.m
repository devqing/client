//
//  UserInfoViewCell.m
//  wukong
//
//  Created by liuweiqing on 16/4/18.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "UserInfoViewCell.h"
#import <UIImageView+WebCache.h>
#import "WKAccountInfo.h"

@interface UserInfoViewCell()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *wechatLabel;

@end

@implementation UserInfoViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self configCell];
    }
    return self;
}
- (void)configCell
{
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.wechatLabel];
}

#pragma mark --getter&setter
- (UIImageView *)iconView
{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 60, 60)];
        [_iconView sd_setImageWithURL:[NSURL URLWithString:[WKAccountInfo sharedInstance].avatar]];
    }
    return _iconView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 20, UI_SCREEN_WIDTH-85-60, 20)];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:18];
        _nameLabel.text = [WKAccountInfo sharedInstance].nikeName;
        
    }
    return _nameLabel;
}

- (UILabel *)wechatLabel
{
    if (_wechatLabel == nil) {
        _wechatLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 45, UI_SCREEN_WIDTH-85-60, 20)];
        _wechatLabel.font = [UIFont systemFontOfSize:16];
        _wechatLabel.textColor = [UIColor blackColor];
        _wechatLabel.text = [WKAccountInfo sharedInstance].nikeName;
    }
    return _wechatLabel;
}


@end
